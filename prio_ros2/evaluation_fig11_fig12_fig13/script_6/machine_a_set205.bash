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
ros2 run evaluation_3_randomdag uunifast_node -n node205_0_2 -p 23 -st topic205_0_1 -pt None -u 0.020137831401191852 > ./result_6chains/node205_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_1_2 -p 71 -st topic205_1_1 -pt None -u 0.05609513293674245 > ./result_6chains/node205_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_2_2 -p 257 -st topic205_2_1 -pt None -u 0.04529713566910101 > ./result_6chains/node205_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_3_2 -p 261 -st topic205_3_1 -pt None -u 0.0008683071030255868 > ./result_6chains/node205_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_4_2 -p 659 -st topic205_4_1 -pt None -u 0.008510101324286548 > ./result_6chains/node205_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_5_2 -p 941 -st topic205_5_1 -pt None -u 0.023925771696834023 > ./result_6chains/node205_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_0_0 -p 23 -st none -pt topic205_0_0 -u 0.0008708936552636604 > ./result_6chains/node205_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_1_0 -p 71 -st none -pt topic205_1_0 -u 0.015978106407292747 > ./result_6chains/node205_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_2_0 -p 257 -st none -pt topic205_2_0 -u 0.04342105168188154 > ./result_6chains/node205_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_3_0 -p 261 -st none -pt topic205_3_0 -u 0.07236162329637097 > ./result_6chains/node205_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_4_0 -p 659 -st none -pt topic205_4_0 -u 0.00780062652459744 > ./result_6chains/node205_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_5_0 -p 941 -st none -pt topic205_5_0 -u 0.007369117868739755 > ./result_6chains/node205_5_0.txt &
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
    "./result_6chains/node205_0_0.txt 90"
    "./result_6chains/node205_0_2.txt 90"
    "./result_6chains/node205_1_0.txt 89"
    "./result_6chains/node205_1_2.txt 89"
    "./result_6chains/node205_2_0.txt 88"
    "./result_6chains/node205_2_2.txt 88"
    "./result_6chains/node205_3_0.txt 87"
    "./result_6chains/node205_3_2.txt 87"
    "./result_6chains/node205_4_0.txt 86"
    "./result_6chains/node205_4_2.txt 86"
    "./result_6chains/node205_5_0.txt 85"
    "./result_6chains/node205_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
