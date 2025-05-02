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
ros2 run evaluation_3_randomdag uunifast_node -n node214_0_1 -p 101 -st topic214_0_0 -pt topic214_0_1 -u 0.013577245772039559 > ./result_10chains/node214_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_1_1 -p 119 -st topic214_1_0 -pt topic214_1_1 -u 0.036903613796593626 > ./result_10chains/node214_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_2_1 -p 150 -st topic214_2_0 -pt topic214_2_1 -u 0.04405373718823841 > ./result_10chains/node214_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_3_1 -p 229 -st topic214_3_0 -pt topic214_3_1 -u 0.00017494168629211826 > ./result_10chains/node214_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_4_1 -p 298 -st topic214_4_0 -pt topic214_4_1 -u 0.004703558695340809 > ./result_10chains/node214_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_5_1 -p 307 -st topic214_5_0 -pt topic214_5_1 -u 0.00141726898707345 > ./result_10chains/node214_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_6_1 -p 344 -st topic214_6_0 -pt topic214_6_1 -u 0.007658270752873758 > ./result_10chains/node214_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_7_1 -p 450 -st topic214_7_0 -pt topic214_7_1 -u 0.037496884227524535 > ./result_10chains/node214_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_8_1 -p 886 -st topic214_8_0 -pt topic214_8_1 -u 0.015088125916733613 > ./result_10chains/node214_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_9_1 -p 962 -st topic214_9_0 -pt topic214_9_1 -u 0.007069333315554261 > ./result_10chains/node214_9_1.txt &
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
    "./result_10chains/node214_0_1.txt 90"
    "./result_10chains/node214_1_1.txt 89"
    "./result_10chains/node214_2_1.txt 88"
    "./result_10chains/node214_3_1.txt 87"
    "./result_10chains/node214_4_1.txt 86"
    "./result_10chains/node214_5_1.txt 85"
    "./result_10chains/node214_6_1.txt 84"
    "./result_10chains/node214_7_1.txt 83"
    "./result_10chains/node214_8_1.txt 82"
    "./result_10chains/node214_9_1.txt 81"
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
