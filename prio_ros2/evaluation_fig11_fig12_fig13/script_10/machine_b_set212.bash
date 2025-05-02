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
ros2 run evaluation_3_randomdag uunifast_node -n node212_0_1 -p 51 -st topic212_0_0 -pt topic212_0_1 -u 0.023101700284128 > ./result_10chains/node212_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_1_1 -p 55 -st topic212_1_0 -pt topic212_1_1 -u 0.03666664059829777 > ./result_10chains/node212_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_2_1 -p 190 -st topic212_2_0 -pt topic212_2_1 -u 0.004547685494194931 > ./result_10chains/node212_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_3_1 -p 262 -st topic212_3_0 -pt topic212_3_1 -u 0.0002839219243419011 > ./result_10chains/node212_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_4_1 -p 269 -st topic212_4_0 -pt topic212_4_1 -u 0.00835181960057374 > ./result_10chains/node212_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_5_1 -p 468 -st topic212_5_0 -pt topic212_5_1 -u 0.018650730710966512 > ./result_10chains/node212_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_6_1 -p 623 -st topic212_6_0 -pt topic212_6_1 -u 0.0013148897580206875 > ./result_10chains/node212_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_7_1 -p 679 -st topic212_7_0 -pt topic212_7_1 -u 0.002317773245589516 > ./result_10chains/node212_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_8_1 -p 756 -st topic212_8_0 -pt topic212_8_1 -u 0.03981067741398122 > ./result_10chains/node212_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_9_1 -p 936 -st topic212_9_0 -pt topic212_9_1 -u 0.0049156948105286225 > ./result_10chains/node212_9_1.txt &
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
    "./result_10chains/node212_0_1.txt 90"
    "./result_10chains/node212_1_1.txt 89"
    "./result_10chains/node212_2_1.txt 88"
    "./result_10chains/node212_3_1.txt 87"
    "./result_10chains/node212_4_1.txt 86"
    "./result_10chains/node212_5_1.txt 85"
    "./result_10chains/node212_6_1.txt 84"
    "./result_10chains/node212_7_1.txt 83"
    "./result_10chains/node212_8_1.txt 82"
    "./result_10chains/node212_9_1.txt 81"
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
