#include <chrono>
#include <cstdio>
#include <memory>
#include <string>
#include <utility>
#include <iostream>

#include "rclcpp/rclcpp.hpp"
#include "std_msgs/msg/string.hpp"

#include <time.h>
#include <sys/timex.h>
#include <sys/types.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <sched.h>

void dummy_task(long load) {
    for (long i = 0; i < load; i++) {
        __asm__ volatile ("nop");
        __asm__ volatile ("nop");
        __asm__ volatile ("nop");
        __asm__ volatile ("nop");
        __asm__ volatile ("nop");
        __asm__ volatile ("nop");
        __asm__ volatile ("nop");
        __asm__ volatile ("nop");
        __asm__ volatile ("nop");
        __asm__ volatile ("nop");
    }
}

using namespace std::chrono_literals;

class Talker : public rclcpp::Node {
public:
    explicit Talker(const std::string &topic_name)
    : Node("Talker"), topic_name_(topic_name) {
        rclcpp::QoS qos(rclcpp::KeepLast(10));
        pub_ = this->create_publisher<std_msgs::msg::String>(topic_name, qos);

        if (topic_name == "topic_lidar") {
            setupTimer(80ms, 237431);
        } else if (topic_name == "topic_camera1") {
            setupTimer(100ms, 2334040);
        } else if (topic_name == "topic_camera2") {
            setupTimer(100ms, 2161368);
        } else if (topic_name == "topic_TF") {
            setupTimer(160ms, 176440);
        } else if (topic_name == "topic_goal") {
            setupTimer(1000ms, 176440);
        }
    }

private:
    std::string topic_name_;
    size_t count_ = 1;
    rclcpp::Publisher<std_msgs::msg::String>::SharedPtr pub_;
    rclcpp::TimerBase::SharedPtr timer_;

    void setupTimer(std::chrono::milliseconds period, long taskLoad) {
        timer_ = this->create_wall_timer(period, [this, taskLoad]() {
            publishMessage(taskLoad);
        });
    }

    void publishMessage(long taskLoad) {
        auto message = std::make_unique<std_msgs::msg::String>();
        message->data = "Data#" + std::to_string(count_++);

	struct ntptimeval t;
        std::cout << "Executor Thread: " << syscall(__NR_gettid) <<" cpu: "<< sched_getcpu() << std::endl;
	ntp_gettime(&t);
        printf("%s pub %s %ld.%.09ld\n", topic_name_.c_str(), message->data.c_str(), t.time.tv_sec, t.time.tv_usec);

        dummy_task(taskLoad);
        pub_->publish(std::move(message));
    }
};

int main(int argc, char* argv[]) {
    setvbuf(stdout, NULL, _IONBF, BUFSIZ);

    rclcpp::init(argc, argv);
    std::string topic = "topic_lidar"; // Default topic
    for (int i = 1; i < argc; ++i) {
        if (std::string(argv[i]) == "-t" && i + 1 < argc) {
            topic = argv[++i];
        }
    }

    auto node = std::make_shared<Talker>(topic);
    rclcpp::spin(node);
    rclcpp::shutdown();
    return 0;
}

