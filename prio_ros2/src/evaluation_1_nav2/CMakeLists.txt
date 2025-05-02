cmake_minimum_required(VERSION 3.5)
project(evaluation_1_nav2)

# Default to C99
if(NOT CMAKE_C_STANDARD)
  set(CMAKE_C_STANDARD 99)
endif()

# Default to C++14
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# find dependencies
find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(std_msgs REQUIRED)
# uncomment the following section in order to fill in
# further dependencies manually.
# find_package(<dependency> REQUIRED)
add_executable(Lidar src/Lidar.cpp)
add_executable(Local src/local.cpp)
add_executable(Global src/global.cpp)
add_executable(TF_path src/TF_path.cpp)
add_executable(goal_path src/goal.cpp)
add_executable(camera1_path src/camera1_path.cpp)
add_executable(camera2_path src/camera2_path.cpp)
ament_target_dependencies(Lidar rclcpp std_msgs)
ament_target_dependencies(Local rclcpp std_msgs)
ament_target_dependencies(Global rclcpp std_msgs)
ament_target_dependencies(TF_path rclcpp std_msgs)
ament_target_dependencies(goal_path rclcpp std_msgs)
ament_target_dependencies(camera1_path rclcpp std_msgs)
ament_target_dependencies(camera2_path rclcpp std_msgs)

install(TARGETS
  Lidar
  Local
  Global
  camera1_path
  camera2_path
  TF_path
  goal_path
  DESTINATION lib/${PROJECT_NAME})

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  # the following line skips the linter which checks for copyrights
  # uncomment the line when a copyright and license is not present in all source files
  #set(ament_cmake_copyright_FOUND TRUE)
  # the following line skips cpplint (only works in a git repo)
  # uncomment the line when this package is not in a git repo
  #set(ament_cmake_cpplint_FOUND TRUE)
  ament_lint_auto_find_test_dependencies()
endif()

ament_package()
