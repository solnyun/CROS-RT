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
ros2 run evaluation_3_randomdag uunifast_node -n node288_0_1 -p 85 -st topic288_0_0 -pt topic288_0_1 -u 0.0031718278461571603 > ./result_10chains/node288_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_1_1 -p 146 -st topic288_1_0 -pt topic288_1_1 -u 0.004265702395342019 > ./result_10chains/node288_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_2_1 -p 284 -st topic288_2_0 -pt topic288_2_1 -u 0.018563518150940428 > ./result_10chains/node288_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_3_1 -p 485 -st topic288_3_0 -pt topic288_3_1 -u 0.025030706207239295 > ./result_10chains/node288_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_4_1 -p 518 -st topic288_4_0 -pt topic288_4_1 -u 0.0012925797365136993 > ./result_10chains/node288_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_5_1 -p 592 -st topic288_5_0 -pt topic288_5_1 -u 0.0048823678172552065 > ./result_10chains/node288_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_6_1 -p 657 -st topic288_6_0 -pt topic288_6_1 -u 0.012862954178078395 > ./result_10chains/node288_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_7_1 -p 666 -st topic288_7_0 -pt topic288_7_1 -u 0.013279386738233784 > ./result_10chains/node288_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_8_1 -p 921 -st topic288_8_0 -pt topic288_8_1 -u 0.006745147836175108 > ./result_10chains/node288_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_9_1 -p 943 -st topic288_9_0 -pt topic288_9_1 -u 0.0004718047099279976 > ./result_10chains/node288_9_1.txt &
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
    "./result_10chains/node288_0_1.txt 90"
    "./result_10chains/node288_1_1.txt 89"
    "./result_10chains/node288_2_1.txt 88"
    "./result_10chains/node288_3_1.txt 87"
    "./result_10chains/node288_4_1.txt 86"
    "./result_10chains/node288_5_1.txt 85"
    "./result_10chains/node288_6_1.txt 84"
    "./result_10chains/node288_7_1.txt 83"
    "./result_10chains/node288_8_1.txt 82"
    "./result_10chains/node288_9_1.txt 81"
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
