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
ros2 run evaluation_3_randomdag uunifast_node -n node10_0_2 -p 34 -st topic10_0_1 -pt None -u 0.0021772980017304433 > ./result_6chains/node10_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_1_2 -p 308 -st topic10_1_1 -pt None -u 0.02361994866848227 > ./result_6chains/node10_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_2_2 -p 351 -st topic10_2_1 -pt None -u 0.032822112940402215 > ./result_6chains/node10_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_3_2 -p 484 -st topic10_3_1 -pt None -u 0.02775237094813994 > ./result_6chains/node10_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_4_2 -p 825 -st topic10_4_1 -pt None -u 0.004368215439263995 > ./result_6chains/node10_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_5_2 -p 983 -st topic10_5_1 -pt None -u 0.006325327059169912 > ./result_6chains/node10_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_0_0 -p 34 -st none -pt topic10_0_0 -u 0.0026134405552269424 > ./result_6chains/node10_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_1_0 -p 308 -st none -pt topic10_1_0 -u 0.0018130666483130442 > ./result_6chains/node10_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_2_0 -p 351 -st none -pt topic10_2_0 -u 0.053333797525325716 > ./result_6chains/node10_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_3_0 -p 484 -st none -pt topic10_3_0 -u 0.031671254028184104 > ./result_6chains/node10_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_4_0 -p 825 -st none -pt topic10_4_0 -u 0.010574563451374225 > ./result_6chains/node10_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_5_0 -p 983 -st none -pt topic10_5_0 -u 0.052383071174396056 > ./result_6chains/node10_5_0.txt &
sleep 10
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
    "./result_6chains/node10_0_0.txt 90"
    "./result_6chains/node10_0_2.txt 90"
    "./result_6chains/node10_1_0.txt 89"
    "./result_6chains/node10_1_2.txt 89"
    "./result_6chains/node10_2_0.txt 88"
    "./result_6chains/node10_2_2.txt 88"
    "./result_6chains/node10_3_0.txt 87"
    "./result_6chains/node10_3_2.txt 87"
    "./result_6chains/node10_4_0.txt 86"
    "./result_6chains/node10_4_2.txt 86"
    "./result_6chains/node10_5_0.txt 85"
    "./result_6chains/node10_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
