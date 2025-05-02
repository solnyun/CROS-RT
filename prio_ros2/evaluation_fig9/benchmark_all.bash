#!/bin/bash

echo "Lidar Node"
./benchmark_test 2.3
echo "Camera1 Node"
./benchmark_test 23.1
echo "Camera2 Node"
./benchmark_test 20.6
echo "TF Node and Goal Node"
./benchmark_test 1.7

echo "pose Node"
./benchmark_test 2.2
echo "local_costmap Node"
./benchmark_test 18.4
echo "local_plan Node"
./benchmark_test 9.1

echo "global_costmap Node"
./benchmark_test 16.1

echo "pre_processing Node"
./benchmark_test 7.9
echo "object_detection Node"
./benchmark_test 14.2
echo "object_tracking Node"
./benchmark_test 17.9

echo "depth_estimation Node"
./benchmark_test 17.9
echo "traffic_prediction Node"
./benchmark_test 6.6

echo "joint Node"
./benchmark_test 11.0
echo "URDF Node"
./benchmark_test 6.6
echo "state Node"
./benchmark_test 7.9

echo "global_plan Node"
./benchmark_test 195.9
