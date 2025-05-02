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
ros2 run evaluation_3_randomdag uunifast_node -n node212_0_2 -p 141 -st topic212_0_1 -pt None -u 0.019402288458557015 > ./result_6chains/node212_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_1_2 -p 354 -st topic212_1_1 -pt None -u 0.006264564274273798 > ./result_6chains/node212_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_2_2 -p 374 -st topic212_2_1 -pt None -u 0.08584386864595711 > ./result_6chains/node212_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_3_2 -p 562 -st topic212_3_1 -pt None -u 0.04999471184161759 > ./result_6chains/node212_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_4_2 -p 838 -st topic212_4_1 -pt None -u 0.024271836274486046 > ./result_6chains/node212_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_5_2 -p 908 -st topic212_5_1 -pt None -u 0.009429633895786122 > ./result_6chains/node212_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_0_0 -p 141 -st none -pt topic212_0_0 -u 0.059761792152028426 > ./result_6chains/node212_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_1_0 -p 354 -st none -pt topic212_1_0 -u 0.03945429525072908 > ./result_6chains/node212_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_2_0 -p 374 -st none -pt topic212_2_0 -u 0.0011283283074511319 > ./result_6chains/node212_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_3_0 -p 562 -st none -pt topic212_3_0 -u 0.0021409826934847 > ./result_6chains/node212_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_4_0 -p 838 -st none -pt topic212_4_0 -u 0.04861217766682834 > ./result_6chains/node212_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_5_0 -p 908 -st none -pt topic212_5_0 -u 0.005939507001760668 > ./result_6chains/node212_5_0.txt &
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
    "./result_6chains/node212_0_0.txt 90"
    "./result_6chains/node212_0_2.txt 90"
    "./result_6chains/node212_1_0.txt 89"
    "./result_6chains/node212_1_2.txt 89"
    "./result_6chains/node212_2_0.txt 88"
    "./result_6chains/node212_2_2.txt 88"
    "./result_6chains/node212_3_0.txt 87"
    "./result_6chains/node212_3_2.txt 87"
    "./result_6chains/node212_4_0.txt 86"
    "./result_6chains/node212_4_2.txt 86"
    "./result_6chains/node212_5_0.txt 85"
    "./result_6chains/node212_5_2.txt 85"
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
