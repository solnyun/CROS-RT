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
    printf("-t topic_name : Specify the topic on which to subscribe. Defaults to chatter.\n");
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
    double base_load = 24606;        // Base computational load for the unit of work
    double desired_execution_time = utilization * period.count(); // Desired execution time in milliseconds
    //std::cout << "desired_execution_time " << desired_execution_time << std::endl;
    return static_cast<long>((desired_execution_time * base_load) / base_execution_time);
}

class Listener : public rclcpp::Node {
public:
    Listener(const std::string& topic_name, double utilization, std::chrono::milliseconds period)
    : Node("listener"), load(utilization_to_load(utilization, period)) {
        auto callback = [this, topic_name](const std_msgs::msg::String::SharedPtr msg) -> void {
            struct ntptimeval t, t2;

            //motivation_2 & motivation_4_ksoftirqd
            get_node_base_interface()->data_num = msg->data;

            syscall(456, 1, msg->data.c_str());
            ntp_gettime(&t);
            printf("%s start %s %ld.%09ld\n", topic_name.c_str(), msg->data.c_str(), t.time.tv_sec, t.time.tv_usec);

            dummy_task(this->load);

            syscall(456, 2, msg->data.c_str());
            ntp_gettime(&t2);
            printf("%s end %s %ld.%09ld\n", topic_name.c_str(), msg->data.c_str(), t2.time.tv_sec, t2.time.tv_usec);
        };
        sub_ = create_subscription<std_msgs::msg::String>(topic_name, 10, callback);
    }

private:
    long load;
    rclcpp::Subscription<std_msgs::msg::String>::SharedPtr sub_;
};

int main(int argc, char* argv[]) {
    setvbuf(stdout, NULL, _IONBF, BUFSIZ);

    if (rcutils_cli_option_exist(argv, argv + argc, "-h")) {
        print_usage();
        return 0;
    }

    rclcpp::init(argc, argv);

    std::string topic = "chatter"; // Default topic
    char* cli_option = rcutils_cli_get_option(argv, argv + argc, "-t");
    if (nullptr != cli_option) {
        topic = std::string(cli_option);
    }

    std::chrono::milliseconds timer_period = std::chrono::milliseconds(1000);
    char* cli_option2 = rcutils_cli_get_option(argv, argv + argc, "-p");
    if (nullptr != cli_option2) {
        timer_period = std::chrono::milliseconds(std::stoi(cli_option2));
    }

    double utilization = 0.01;
    char* cli_option3 = rcutils_cli_get_option(argv, argv + argc, "-u");
    if (nullptr != cli_option3) {
        utilization = std::stod(cli_option3);
    }

    auto node = std::make_shared<Listener>(topic, utilization, timer_period);
    rclcpp::spin(node);
    rclcpp::shutdown();
    return 0;
}
