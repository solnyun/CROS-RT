#include <cstdio>
#include <memory>
#include <string>
#include <unistd.h>
#include <sys/syscall.h>
#include <time.h>
#include <sys/timex.h>

#include "rclcpp/rclcpp.hpp"
#include "rcutils/cmdline_parser.h"
#include "std_msgs/msg/string.hpp"
#include <sys/types.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <sched.h>

void print_usage() {
    printf("Usage for listener app:\n");
    printf("listener [-t topic_name] [-h]\n");
    printf("options:\n");
    printf("-h : Print this help function.\n");
    printf("-t topic_name : Specify the topic on which to subscribe. Defaults to 'topic_camera2'.\n");
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

class Listener : public rclcpp::Node {
public:
    explicit Listener(const std::string& topic_name) : Node("listener"), topic_name_(topic_name) {
        if (topic_name == "topic_camera2") {
            pub_ = create_publisher<std_msgs::msg::String>("topic_estimation", 10);
        }
        sub_ = create_subscription<std_msgs::msg::String>(topic_name, 10,
            [this](const std_msgs::msg::String::SharedPtr msg) {
                unifiedCallback(msg);
            });
    }

private:
    std::string topic_name_;
    rclcpp::Subscription<std_msgs::msg::String>::SharedPtr sub_;
    rclcpp::Publisher<std_msgs::msg::String>::SharedPtr pub_;

    void unifiedCallback(const std_msgs::msg::String::SharedPtr msg) {
        struct ntptimeval t, t2;
	syscall(456, 1, msg->data.c_str());
        ntp_gettime(&t);

        printf("%s start %s %ld.%09ld\n", topic_name_.c_str(), msg->data.c_str(), t.time.tv_sec, t.time.tv_usec);

        long taskLoad = getTaskLoad();
        dummy_task(taskLoad);

	syscall(456, 2, msg->data.c_str());
        ntp_gettime(&t2);
        printf("%s end %s %ld.%09ld\n", topic_name_.c_str(), msg->data.c_str(), t2.time.tv_sec, t2.time.tv_usec);

        if (pub_) {
            pub_->publish(std::move(*msg));
        }
    }

    long getTaskLoad() {
        // Adjust the task load based on the topic
        if (topic_name_ == "topic_camera2") {
            return 1771750; // Load for depth estimation
        } else if (topic_name_ == "topic_estimation") {
            return 692404; // Load for traffic prediction
        }
        return 0;
    }
};

int main(int argc, char* argv[]) {
    setvbuf(stdout, NULL, _IONBF, BUFSIZ);

    if (rcutils_cli_option_exist(argv, argv + argc, "-h")) {
        print_usage();
        return 0;
    }

    rclcpp::init(argc, argv);
    std::string topic = "topic_camera2"; // Default topic
    char* cli_option = rcutils_cli_get_option(argv, argv + argc, "-t");
    if (nullptr != cli_option) {
        topic = std::string(cli_option);
    }

    auto node = std::make_shared<Listener>(topic);
    rclcpp::spin(node);
    rclcpp::shutdown();
    return 0;
}

