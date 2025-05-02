#include <chrono>
#include <cstdio>
#include <memory>
#include <string>
#include <utility>

#include "rclcpp/rclcpp.hpp"
#include "rcutils/cmdline_parser.h"
#include "std_msgs/msg/string.hpp"

#include <time.h>
#include <sys/timex.h>

using namespace std::chrono_literals;

class Talker : public rclcpp::Node
{
	public:
		explicit Talker(const std::string & topic_name, std::chrono::milliseconds period, int pkt_num)
		: Node("talker"), pkt_num_(pkt_num)
		{
			rclcpp::QoS qos(rclcpp::KeepLast(1));
			pub1_ = this->create_publisher<std_msgs::msg::String>(topic_name, qos);
			timer1_ = this->create_wall_timer(period, std::bind(&Talker::timer_callback, this));
		}
	private:
		void timer_callback()
		{
			struct ntptimeval t1;
			int a = 0;
      			msg1_ = std::make_unique<std_msgs::msg::String>();
      			msg1_->data = "Data#" + std::to_string(count1_++);
			std::cout<<"LP pub "<<msg1_->data.c_str();
			ntp_gettime(&t1);
			printf(" %ld.%.9ld\n", t1.time.tv_sec, t1.time.tv_usec);

			//payload add
			if (pkt_num_)
				a = (pkt_num_ * 1024) - (128 * (pkt_num_ / 64));
			std::string payload(a, 'B');
			msg1_->data += " " + payload;
	    		pub1_->publish(std::move(msg1_));
		}

		size_t count1_ = 1;
		int pkt_num_;
		//size_t count2_ = 1;
	  std::unique_ptr<std_msgs::msg::String> msg1_;
	  rclcpp::Publisher<std_msgs::msg::String>::SharedPtr pub1_;
	  rclcpp::TimerBase::SharedPtr timer1_;
};


int main(int argc, char * argv[])
{
  // Force flush of the stdout buffer.
  // This ensures a correct sync of all prints
  // even when executed simultaneously within the launch file.
  setvbuf(stdout, NULL, _IONBF, BUFSIZ);


  rclcpp::init(argc, argv);
  auto topic = std::string("chatter");
  char * cli_option = rcutils_cli_get_option(argv, argv + argc, "-t");
  if (nullptr != cli_option) {
    topic = std::string(cli_option);
  }
  
  std::chrono::milliseconds timer_period = std::chrono::milliseconds(1000);
  char * timer_period_cli = rcutils_cli_get_option(argv, argv + argc, "-p");
  if (nullptr != timer_period_cli) {
    timer_period = std::chrono::milliseconds(std::stoi(timer_period_cli));
  }

  int pkt_num = 0;
  char * pkt_num_cli = rcutils_cli_get_option(argv, argv + argc, "-s");
  if (nullptr != pkt_num_cli) {
    pkt_num = std::stoi(pkt_num_cli);
  }



  // Create a node.
  auto node = std::make_shared<Talker>(topic, timer_period, pkt_num);

  // spin will block until work comes in, execute work as it becomes available, and keep blocking.
  // It will only be interrupted by Ctrl-C.
  rclcpp::spin(node);

  rclcpp::shutdown();
  return 0;
}
