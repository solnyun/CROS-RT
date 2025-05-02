cmd_ros2_framework/non_rt_bg.mod := printf '%s\n'   non_rt_bg.o | awk '!x[$$0]++ { print("ros2_framework/"$$0) }' > ros2_framework/non_rt_bg.mod
