cmd_ros2_framework/rt_handler.mod := printf '%s\n'   rt_handler.o | awk '!x[$$0]++ { print("ros2_framework/"$$0) }' > ros2_framework/rt_handler.mod
