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
ros2 run evaluation_3_randomdag uunifast_node -n node282_0_1 -p 152 -st topic282_0_0 -pt topic282_0_1 -u 0.013589675020655723 > ./result_8chains/node282_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_1_1 -p 360 -st topic282_1_0 -pt topic282_1_1 -u 0.0071949041761952826 > ./result_8chains/node282_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_2_1 -p 450 -st topic282_2_0 -pt topic282_2_1 -u 0.00976060931433853 > ./result_8chains/node282_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_3_1 -p 649 -st topic282_3_0 -pt topic282_3_1 -u 0.006307531177000725 > ./result_8chains/node282_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_4_1 -p 651 -st topic282_4_0 -pt topic282_4_1 -u 0.03864960253814376 > ./result_8chains/node282_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_5_1 -p 820 -st topic282_5_0 -pt topic282_5_1 -u 0.006815566847108628 > ./result_8chains/node282_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_6_1 -p 869 -st topic282_6_0 -pt topic282_6_1 -u 0.023285754738495028 > ./result_8chains/node282_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_7_1 -p 962 -st topic282_7_0 -pt topic282_7_1 -u 0.01181898438204436 > ./result_8chains/node282_7_1.txt &
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
    "./result_8chains/node282_0_1.txt 90"
    "./result_8chains/node282_1_1.txt 89"
    "./result_8chains/node282_2_1.txt 88"
    "./result_8chains/node282_3_1.txt 87"
    "./result_8chains/node282_4_1.txt 86"
    "./result_8chains/node282_5_1.txt 85"
    "./result_8chains/node282_6_1.txt 84"
    "./result_8chains/node282_7_1.txt 83"
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
