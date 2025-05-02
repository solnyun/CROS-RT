#!/bin/bash

# Print usage information and exit
print_usage() {
    echo "Usage: $0 <vanilla|framework> <with_nonRT_pl|no>"
    exit 1
}

if [ "$#" -ne 2 ]; then
    print_usage
fi

type=$1
model=$2

# Create a directory to store the result data
# CreateDIR=result/
# if [ ! -d "$CreateDIR" ]; then
#    mkdir "$CreateDIR"
# fi
ros2 run evaluation_3_randomdag uunifast_node -n node138_0_1 -p 36 -st topic138_0_0 -pt topic138_0_1 -u 0.02028148728533824 > ./result_10chains/node138_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_1_1 -p 224 -st topic138_1_0 -pt topic138_1_1 -u 0.027224218039557158 > ./result_10chains/node138_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_2_1 -p 253 -st topic138_2_0 -pt topic138_2_1 -u 0.026313060157314383 > ./result_10chains/node138_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_3_1 -p 367 -st topic138_3_0 -pt topic138_3_1 -u 0.06543168554874734 > ./result_10chains/node138_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_4_1 -p 562 -st topic138_4_0 -pt topic138_4_1 -u 0.02036938359848614 > ./result_10chains/node138_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_5_1 -p 739 -st topic138_5_0 -pt topic138_5_1 -u 0.02310518992791208 > ./result_10chains/node138_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_6_1 -p 794 -st topic138_6_0 -pt topic138_6_1 -u 0.015842758129133716 > ./result_10chains/node138_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_7_1 -p 885 -st topic138_7_0 -pt topic138_7_1 -u 0.006889742650574182 > ./result_10chains/node138_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_8_1 -p 938 -st topic138_8_0 -pt topic138_8_1 -u 0.012474111290588799 > ./result_10chains/node138_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_9_1 -p 974 -st topic138_9_0 -pt topic138_9_1 -u 0.007333901795147438 > ./result_10chains/node138_9_1.txt &
sleep 20
finalize_framework() {
    if [ "$type" == "framework" ]; then
        if [ "$model" == "with_nonRT" ]; then
            python3 pri_remove.py "$file_name_motor"
        fi
        for filepath in "${files[@]}"; do
            file=$(echo "$filepath" | cut -d' ' -f1)
            python3 pri_remove.py "$file"
        done
    fi
}


# Priority Assignments
declare -a files=(
    "./result_10chains/node138_0_1.txt 90"
    "./result_10chains/node138_1_1.txt 89"
    "./result_10chains/node138_2_1.txt 88"
    "./result_10chains/node138_3_1.txt 87"
    "./result_10chains/node138_4_1.txt 86"
    "./result_10chains/node138_5_1.txt 85"
    "./result_10chains/node138_6_1.txt 84"
    "./result_10chains/node138_7_1.txt 83"
    "./result_10chains/node138_8_1.txt 82"
    "./result_10chains/node138_9_1.txt 81"
)

for filepath in "${files[@]}"; do
    file=$(echo "$filepath" | cut -d' ' -f1)
    priority=$(echo "$filepath" | cut -d' ' -f2)
    if [ "$type" == "vanilla" ]; then
        python3 pri_assign.py $file $priority
    elif [ "$type" == "framework" ]; then
        python3 pri_identifier.py $file $priority
    fi
done
echo "End Priority Assignment"

# Finalize by performing a final command and killing any remaining processes
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
