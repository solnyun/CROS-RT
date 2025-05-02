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
ros2 run evaluation_3_randomdag uunifast_node -n node299_0_1 -p 21 -st topic299_0_0 -pt topic299_0_1 -u 0.008417038383709385 > ./result_10chains/node299_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_1_1 -p 81 -st topic299_1_0 -pt topic299_1_1 -u 0.015851125831705504 > ./result_10chains/node299_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_2_1 -p 95 -st topic299_2_0 -pt topic299_2_1 -u 0.040326060108429096 > ./result_10chains/node299_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_3_1 -p 170 -st topic299_3_0 -pt topic299_3_1 -u 0.01753239650648608 > ./result_10chains/node299_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_4_1 -p 256 -st topic299_4_0 -pt topic299_4_1 -u 5.0417207567710065e-06 > ./result_10chains/node299_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_5_1 -p 342 -st topic299_5_0 -pt topic299_5_1 -u 0.016588077348446972 > ./result_10chains/node299_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_6_1 -p 437 -st topic299_6_0 -pt topic299_6_1 -u 0.014043941633356316 > ./result_10chains/node299_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_7_1 -p 560 -st topic299_7_0 -pt topic299_7_1 -u 0.0523843179214257 > ./result_10chains/node299_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_8_1 -p 698 -st topic299_8_0 -pt topic299_8_1 -u 0.013295494138406846 > ./result_10chains/node299_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_9_1 -p 836 -st topic299_9_0 -pt topic299_9_1 -u 0.015313067461095318 > ./result_10chains/node299_9_1.txt &
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
    "./result_10chains/node299_0_1.txt 90"
    "./result_10chains/node299_1_1.txt 89"
    "./result_10chains/node299_2_1.txt 88"
    "./result_10chains/node299_3_1.txt 87"
    "./result_10chains/node299_4_1.txt 86"
    "./result_10chains/node299_5_1.txt 85"
    "./result_10chains/node299_6_1.txt 84"
    "./result_10chains/node299_7_1.txt 83"
    "./result_10chains/node299_8_1.txt 82"
    "./result_10chains/node299_9_1.txt 81"
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
