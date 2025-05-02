#include "rclcpp/rclcpp.hpp"
#include "std_msgs/msg/string.hpp"
#include "rcutils/cmdline_parser.h"

#include <string>
#include <iostream>
#include <unistd.h>
#include <cstdio>
#include <cstring>
#include <sys/syscall.h>
#include <time.h>
#include <sys/timex.h>
#include <sstream>
#include <iomanip>
#include <sched.h>
#include <vector>
#include <chrono>

void print_usage() {
    std::cout << "Usage for uunifast_node:\n";
    std::cout << "  uunifast_node [-h] [-n node_name] [-u utilization] [-p period_ms] [-st subscriber_topic] [-pt publisher_topic]\n";
    std::cout << "Options:\n";
    std::cout << "  -h  : Print this help message.\n";
    std::cout << "  -n  : Specify the node name. Defaults to 'default_node'.\n";
    std::cout << "  -u  : Specify the utilization for calculating task load. Defaults to 0.1.\n";
    std::cout << "  -p  : Specify the timer callback period in milliseconds. Defaults to 1000ms.\n";
    std::cout << "  -st : Specify the subscriber topic name. Use 'none' for timer-based execution.\n";
    std::cout << "  -pt : Specify the publisher topic name. Use 'none' to indicate no publishing.\n";
}

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

long utilization_to_load(double utilization, std::chrono::milliseconds period) {
    double base_execution_time = 0.1;  // Base time in milliseconds for a unit of work
    double base_load = 10378;        // Base computational load for the unit of work
    double desired_execution_time = utilization * period.count(); // Desired execution time in milliseconds
    return static_cast<long>((desired_execution_time * base_load) / base_execution_time);
}

class ChainNode : public rclcpp::Node {
public:
    int pkt_num_;
    long load;
    size_t count_ = 1;
    rclcpp::TimerBase::SharedPtr timer_;
    rclcpp::Subscription<std_msgs::msg::String>::SharedPtr sub_;
    rclcpp::Publisher<std_msgs::msg::String>::SharedPtr pub_;

    ChainNode(const std::string &name, double utilization, std::chrono::milliseconds period, const std::string &subscriber_topic, const std::string &publisher_topic, int pkt_num)
    : Node(name), pkt_num_(pkt_num), load(utilization_to_load(utilization, period)) {
        // Timer-based execution
        if (subscriber_topic == "none") {
            timer_ = this->create_wall_timer(period, [this, name, publisher_topic]() {
                auto message = std::make_unique<std_msgs::msg::String>();
		int a = 0;
                message->data = "Data#" + std::to_string(count_++);

		struct ntptimeval t;
		ntp_gettime(&t);
		printf("%s pub %s %ld.%.09ld\n", name.c_str(), message->data.c_str(), t.time.tv_sec, t.time.tv_usec);

                //dummy_task(this->load);
		if (pkt_num_)
			a = (pkt_num_ * 1024) - (128 * (pkt_num_ / 64));
		std::string payload(a, 'C');
		message->data += " " + payload; 

                if (publisher_topic != "None") {
                    pub_->publish(std::move(message));
                }
            });
        } else {
            // Subscriber-based execution
            sub_ = this->create_subscription<std_msgs::msg::String>(subscriber_topic, 10, [this, name, publisher_topic](const std_msgs::msg::String::SharedPtr msg) {
		struct ntptimeval t, t2;
		ntp_gettime(&t);
		printf("%s start %s %ld.%09ld\n", name.c_str(), msg->data.c_str(), t.time.tv_sec, t.time.tv_usec);

                dummy_task(this->load);

		ntp_gettime(&t2);
        	printf("%s end %s %ld.%09ld\n", name.c_str(), msg->data.c_str(), t2.time.tv_sec, t2.time.tv_usec);

                if (publisher_topic != "None") {
                    pub_->publish(std::move(*msg));
                }
            });
        }

        // Initialize the publisher if needed
        if (publisher_topic != "None") {
            pub_ = this->create_publisher<std_msgs::msg::String>(publisher_topic, 10);
        }
    }
};

int main(int argc, char *argv[]) {
    setvbuf(stdout, NULL, _IONBF, BUFSIZ);

    if (rcutils_cli_option_exist(argv, argv + argc, "-h")) {
        print_usage();
        return 0;
    }

    rclcpp::init(argc, argv);

    std::string node_name = "None";
    double utilization = 0.1;
    std::chrono::milliseconds timer_period = std::chrono::milliseconds(1000);
    std::string subscriber_topic = "none";
    std::string publisher_topic = "None";

    char *node_name_cli = rcutils_cli_get_option(argv, argv + argc, "-n");
    if (node_name_cli) {
        node_name = std::string(node_name_cli);
    }

    char *utilization_cli = rcutils_cli_get_option(argv, argv + argc, "-u");
    if (utilization_cli) {
        utilization = std::stod(utilization_cli);
    }

    char *period_cli = rcutils_cli_get_option(argv, argv + argc, "-p");
    if (period_cli) {
	timer_period = std::chrono::milliseconds(std::stoi(period_cli));
    }

    char *subscriber_topic_cli = rcutils_cli_get_option(argv, argv + argc, "-st");
    if (subscriber_topic_cli) {
        subscriber_topic = std::string(subscriber_topic_cli);
    }

    char *publisher_topic_cli = rcutils_cli_get_option(argv, argv + argc, "-pt");
    if (publisher_topic_cli) {
        publisher_topic = std::string(publisher_topic_cli);
    }

    int pkt_num = 2;
    char * pkt_num_cli = rcutils_cli_get_option(argv, argv + argc, "-pkt");
    if (nullptr != pkt_num_cli) {
        pkt_num = std::stoi(pkt_num_cli);
    }


    auto node = std::make_shared<ChainNode>(node_name, utilization, timer_period, subscriber_topic, publisher_topic, pkt_num);

    rclcpp::spin(node);
    rclcpp::shutdown();
    return 0;
}

