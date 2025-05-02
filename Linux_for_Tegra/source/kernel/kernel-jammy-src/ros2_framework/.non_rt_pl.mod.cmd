cmd_ros2_framework/non_rt_pl.mod := printf '%s\n'   non_rt_pl.o | awk '!x[$$0]++ { print("ros2_framework/"$$0) }' > ros2_framework/non_rt_pl.mod
