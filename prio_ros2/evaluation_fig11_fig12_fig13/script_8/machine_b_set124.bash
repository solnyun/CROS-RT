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
ros2 run evaluation_3_randomdag uunifast_node -n node124_0_1 -p 92 -st topic124_0_0 -pt topic124_0_1 -u 0.037582035499522604 > ./result_8chains/node124_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_1_1 -p 111 -st topic124_1_0 -pt topic124_1_1 -u 0.028578466865476992 > ./result_8chains/node124_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_2_1 -p 313 -st topic124_2_0 -pt topic124_2_1 -u 0.04411247884502695 > ./result_8chains/node124_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_3_1 -p 361 -st topic124_3_0 -pt topic124_3_1 -u 0.01373557790274943 > ./result_8chains/node124_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_4_1 -p 468 -st topic124_4_0 -pt topic124_4_1 -u 0.042290439395237994 > ./result_8chains/node124_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_5_1 -p 626 -st topic124_5_0 -pt topic124_5_1 -u 0.03522591863252275 > ./result_8chains/node124_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_6_1 -p 654 -st topic124_6_0 -pt topic124_6_1 -u 0.029075259093301515 > ./result_8chains/node124_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_7_1 -p 775 -st topic124_7_0 -pt topic124_7_1 -u 0.011113184219933481 > ./result_8chains/node124_7_1.txt &
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
    "./result_8chains/node124_0_1.txt 90"
    "./result_8chains/node124_1_1.txt 89"
    "./result_8chains/node124_2_1.txt 88"
    "./result_8chains/node124_3_1.txt 87"
    "./result_8chains/node124_4_1.txt 86"
    "./result_8chains/node124_5_1.txt 85"
    "./result_8chains/node124_6_1.txt 84"
    "./result_8chains/node124_7_1.txt 83"
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
