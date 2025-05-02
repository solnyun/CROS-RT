// Copyright 2015 Open Source Robotics Foundation, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include <unistd.h>

#include <chrono>
#include <cstdio>
#include <memory>

#include "rttest/rttest.h"

#include "rclcpp/rclcpp.hpp"
#include "rcutils/cmdline_parser.h"
#include "rclcpp/strategies/message_pool_memory_strategy.hpp"
#include "rclcpp/strategies/allocator_memory_strategy.hpp"

#include "tlsf_cpp/tlsf.hpp"

#include "pendulum_msgs/msg/joint_command.hpp"
#include "pendulum_msgs/msg/joint_state.hpp"
#include "pendulum_msgs/msg/rttest_results.hpp"

#include "pendulum_control/pendulum_controller.hpp"
#include "pendulum_control/pendulum_motor.hpp"
#include "pendulum_control/rtt_executor.hpp"

#include <time.h>
#include <sys/timex.h>

using rclcpp::strategies::message_pool_memory_strategy::MessagePoolMemoryStrategy;
using rclcpp::memory_strategies::allocator_memory_strategy::AllocatorMemoryStrategy;

template<typename T = void>
using TLSFAllocator = tlsf_heap_allocator<T>;

void print_timestamp(const char* prefix, const float num, const struct ntptimeval& time)
{
        printf("%s Data#%f %ld.%.09ld\n", prefix, num, time.time.tv_sec, time.time.tv_usec);
}

int main(int argc, char * argv[])
{
  // Initialization phase.
  // In the initialization phase of a realtime program, non-realtime-safe operations such as
  // allocation memory are permitted.

  // Create a structure with the default physical properties of the pendulum (length and mass).
  pendulum_control::PendulumProperties properties;

  // Create the properties of the PID controller.
  pendulum_control::PIDProperties pid;
  // Instantiate a PendulumController class which will calculate the next motor command.
  // Run the callback for the controller slightly faster than the executor update loop.
  auto pendulum_controller = std::make_shared<pendulum_control::PendulumController>(
    std::chrono::nanoseconds(6600000), pid);

  // Pass the input arguments to rttest.
  // rttest will store relevant parameters and allocate buffers for data collection
  //rttest_read_args(argc, argv);

  // Pass the input arguments to rclcpp and initialize the signal handler.
  rclcpp::init(argc, argv);

  // The MessagePoolMemoryStrategy preallocates a pool of messages to be used by the subscription.
  // Typically, one MessagePoolMemoryStrategy is used per subscription type, and the size of the
  // message pool is determined by the number of threads (the maximum number of concurrent accesses
  // to the subscription).
  // Since this example is single-threaded, we choose a message pool size of 1 for each strategy.
  auto state_msg_strategy =
    std::make_shared<MessagePoolMemoryStrategy<pendulum_msgs::msg::JointState, 1>>();
  auto command_msg_strategy =
    std::make_shared<MessagePoolMemoryStrategy<pendulum_msgs::msg::JointCommand, 1>>();
  auto setpoint_msg_strategy =
    std::make_shared<MessagePoolMemoryStrategy<pendulum_msgs::msg::JointCommand, 1>>();

  // The controller node represents user code. This example implements a simple PID controller.
  auto name = std::string("pendulum_controller");
  char * cli_option = rcutils_cli_get_option(argv, argv + argc, "-r");
  if (nullptr != cli_option) {
    name = std::string(cli_option);
  }
  auto controller_node = rclcpp::Node::make_shared(name);

  // The quality of service profile is tuned for real-time performance.
  // More QoS settings may be exposed by the rmw interface in the future to fulfill real-time
  // requirements.
  auto qos = rclcpp::QoS(
    // The "KEEP_LAST" history setting tells DDS to store a fixed-size buffer of values before they
    // are sent, to aid with recovery in the event of dropped messages.
    // "depth" specifies the size of this buffer.
    // In this example, we are optimizing for performance and limited resource usage (preventing
    // page faults), instead of reliability. Thus, we set the size of the history buffer to 1.
    rclcpp::KeepLast(1)
  );
  // From http://www.opendds.org/qosusages.html: "A RELIABLE setting can potentially block while
  // trying to send." Therefore set the policy to best effort to avoid blocking during execution.
  qos.best_effort();


  // Create a lambda function to invoke the controller callback when a command is received.
  auto controller_subscribe_callback =
    [&pendulum_controller](pendulum_msgs::msg::JointState::ConstSharedPtr msg) -> void
    {
      struct ntptimeval t1, t2;
      ntp_gettime(&t1);
      pendulum_controller->on_sensor_message(msg);
      ntp_gettime(&t2);
      print_timestamp("sub start", msg->num, t1);
      print_timestamp("sub end", msg->num, t2);
    };

  // Initialize the publisher for the command message.
  auto topic = std::string("pendulum_command");
  char * cli_topic = rcutils_cli_get_option(argv, argv + argc, "-pt");
  if (nullptr != cli_topic) {
    topic = std::string(cli_topic);
  }
  auto command_pub = controller_node->create_publisher<pendulum_msgs::msg::JointCommand>(
    topic, qos);

  // Initialize the subscriber for the sensor message.
  // Notice that we pass the MessageMemoryPoolStrategy<JointState> initialized above.
  auto stopic = std::string("pendulum_sensor");
  char * cli_topic2 = rcutils_cli_get_option(argv, argv + argc, "-st");
  if (nullptr != cli_topic2) {
    stopic = std::string(cli_topic2);
  }
  auto sensor_sub = controller_node->create_subscription<pendulum_msgs::msg::JointState>(
    stopic, qos, controller_subscribe_callback,
    rclcpp::SubscriptionOptions(), state_msg_strategy);

  // Create a lambda function to accept user input to command the pendulum
  auto controller_command_callback =
    [&pendulum_controller](pendulum_msgs::msg::JointCommand::ConstSharedPtr msg) -> void
    {
      pendulum_controller->on_pendulum_setpoint(msg);
    };

  // Receive the most recently published message from the teleop node publisher.
  auto qos_setpoint_sub = qos;
  qos_setpoint_sub.transient_local();

  auto setpoint_topic = std::string("pendulum_setpoint");
  char * cli_topic3 = rcutils_cli_get_option(argv, argv + argc, "-setpoint");
  if (nullptr != cli_topic3) {
      setpoint_topic = std::string(cli_topic3);
  }

  auto setpoint_sub = controller_node->create_subscription<pendulum_msgs::msg::JointCommand>(
    setpoint_topic, qos_setpoint_sub, controller_command_callback,
    rclcpp::SubscriptionOptions(), setpoint_msg_strategy);


  // One of the arguments passed to the Executor is the memory strategy, which delegates the
  // runtime-execution allocations to the TLSF allocator.
  rclcpp::memory_strategy::MemoryStrategy::SharedPtr memory_strategy =
    std::make_shared<AllocatorMemoryStrategy<TLSFAllocator<void>>>();

  float data_num = 0;

  // Create a lambda function that will fire regularly to publish the next command message.
  auto controller_publish_callback =
    [&command_pub, &pendulum_controller, &data_num]()
    {
      if (pendulum_controller->next_message_ready()) {
        auto msg = pendulum_controller->get_next_command_message();
	msg.num = data_num++;
        struct ntptimeval t;
        ntp_gettime(&t);
        print_timestamp("pub", msg.num, t);
        command_pub->publish(msg);
      }
    };

  // Add a timer to enable regular publication of command messages.
  auto controller_publisher_timer = controller_node->create_wall_timer(
    pendulum_controller->get_publish_period(), controller_publish_callback);


  // Lock the currently cached virtual memory into RAM, as well as any future memory allocations,
  // and do our best to prefault the locked memory to prevent future pagefaults.
  // Will return with a non-zero error code if something went wrong (insufficient resources or
  // permissions).
  // Always do this as the last step of the initialization phase.
  // See README.md for instructions on setting permissions.
  // See rttest/rttest.cpp for more details.
  if (rttest_lock_and_prefault_dynamic() != 0) {
    fprintf(stderr, "Couldn't lock all cached virtual memory.\n");
    fprintf(stderr, "Pagefaults from reading pages not yet mapped into RAM will be recorded.\n");
  }

  // End initialization phase

  // Unlike the default SingleThreadedExecutor::spin function, RttExecutor::spin runs in
  // bounded time (for as many iterations as specified in the rttest parameters).
  rclcpp::spin(controller_node);

  // End execution phase
  printf("PendulumController received %zu messages\n", pendulum_controller->messages_received);

  rclcpp::shutdown();

  return 0;
}
