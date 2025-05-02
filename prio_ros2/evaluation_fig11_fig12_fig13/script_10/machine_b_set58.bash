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
ros2 run evaluation_3_randomdag uunifast_node -n node58_0_1 -p 96 -st topic58_0_0 -pt topic58_0_1 -u 0.024036989189518188 > ./result_10chains/node58_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_1_1 -p 376 -st topic58_1_0 -pt topic58_1_1 -u 0.022793735401689774 > ./result_10chains/node58_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_2_1 -p 429 -st topic58_2_0 -pt topic58_2_1 -u 0.003062562421931647 > ./result_10chains/node58_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_3_1 -p 458 -st topic58_3_0 -pt topic58_3_1 -u 0.05352076157744903 > ./result_10chains/node58_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_4_1 -p 520 -st topic58_4_0 -pt topic58_4_1 -u 0.01832360377788611 > ./result_10chains/node58_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_5_1 -p 639 -st topic58_5_0 -pt topic58_5_1 -u 0.0022984217103313442 > ./result_10chains/node58_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_6_1 -p 803 -st topic58_6_0 -pt topic58_6_1 -u 0.009760207533781207 > ./result_10chains/node58_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_7_1 -p 861 -st topic58_7_0 -pt topic58_7_1 -u 0.009462878377692774 > ./result_10chains/node58_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_8_1 -p 909 -st topic58_8_0 -pt topic58_8_1 -u 0.002194270252173308 > ./result_10chains/node58_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_9_1 -p 956 -st topic58_9_0 -pt topic58_9_1 -u 0.06326198441441014 > ./result_10chains/node58_9_1.txt &
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
    "./result_10chains/node58_0_1.txt 90"
    "./result_10chains/node58_1_1.txt 89"
    "./result_10chains/node58_2_1.txt 88"
    "./result_10chains/node58_3_1.txt 87"
    "./result_10chains/node58_4_1.txt 86"
    "./result_10chains/node58_5_1.txt 85"
    "./result_10chains/node58_6_1.txt 84"
    "./result_10chains/node58_7_1.txt 83"
    "./result_10chains/node58_8_1.txt 82"
    "./result_10chains/node58_9_1.txt 81"
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
