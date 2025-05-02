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
ros2 run evaluation_3_randomdag uunifast_node -n node317_0_1 -p 119 -st topic317_0_0 -pt topic317_0_1 -u 0.011780944311066133 > ./result_10chains/node317_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_1_1 -p 174 -st topic317_1_0 -pt topic317_1_1 -u 0.03700869216732944 > ./result_10chains/node317_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_2_1 -p 328 -st topic317_2_0 -pt topic317_2_1 -u 0.008725740591221776 > ./result_10chains/node317_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_3_1 -p 347 -st topic317_3_0 -pt topic317_3_1 -u 0.026651933279776996 > ./result_10chains/node317_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_4_1 -p 353 -st topic317_4_0 -pt topic317_4_1 -u 0.015484019938646731 > ./result_10chains/node317_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_5_1 -p 369 -st topic317_5_0 -pt topic317_5_1 -u 0.002580624846037438 > ./result_10chains/node317_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_6_1 -p 396 -st topic317_6_0 -pt topic317_6_1 -u 0.02921346530032684 > ./result_10chains/node317_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_7_1 -p 493 -st topic317_7_0 -pt topic317_7_1 -u 0.0022297862485444186 > ./result_10chains/node317_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_8_1 -p 843 -st topic317_8_0 -pt topic317_8_1 -u 0.014391678994317439 > ./result_10chains/node317_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_9_1 -p 960 -st topic317_9_0 -pt topic317_9_1 -u 0.001699624656605378 > ./result_10chains/node317_9_1.txt &
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
    "./result_10chains/node317_0_1.txt 90"
    "./result_10chains/node317_1_1.txt 89"
    "./result_10chains/node317_2_1.txt 88"
    "./result_10chains/node317_3_1.txt 87"
    "./result_10chains/node317_4_1.txt 86"
    "./result_10chains/node317_5_1.txt 85"
    "./result_10chains/node317_6_1.txt 84"
    "./result_10chains/node317_7_1.txt 83"
    "./result_10chains/node317_8_1.txt 82"
    "./result_10chains/node317_9_1.txt 81"
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
