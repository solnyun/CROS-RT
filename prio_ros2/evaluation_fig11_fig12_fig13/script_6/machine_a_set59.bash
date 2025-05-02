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
ros2 run evaluation_3_randomdag uunifast_node -n node59_0_2 -p 120 -st topic59_0_1 -pt None -u 0.02742786229187749 > ./result_6chains/node59_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_1_2 -p 536 -st topic59_1_1 -pt None -u 0.008609427519161106 > ./result_6chains/node59_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_2_2 -p 578 -st topic59_2_1 -pt None -u 0.06714255931824722 > ./result_6chains/node59_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_3_2 -p 660 -st topic59_3_1 -pt None -u 0.10311139117956113 > ./result_6chains/node59_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_4_2 -p 672 -st topic59_4_1 -pt None -u 0.0021080498134005976 > ./result_6chains/node59_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_5_2 -p 979 -st topic59_5_1 -pt None -u 0.007060237259751962 > ./result_6chains/node59_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_0_0 -p 120 -st none -pt topic59_0_0 -u 0.012768686701310261 > ./result_6chains/node59_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_1_0 -p 536 -st none -pt topic59_1_0 -u 0.03345247641533805 > ./result_6chains/node59_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_2_0 -p 578 -st none -pt topic59_2_0 -u 0.07277007598877544 > ./result_6chains/node59_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_3_0 -p 660 -st none -pt topic59_3_0 -u 0.010529033437851637 > ./result_6chains/node59_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_4_0 -p 672 -st none -pt topic59_4_0 -u 0.019544507712617933 > ./result_6chains/node59_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_5_0 -p 979 -st none -pt topic59_5_0 -u 0.010923696606123696 > ./result_6chains/node59_5_0.txt &
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
    "./result_6chains/node59_0_0.txt 90"
    "./result_6chains/node59_0_2.txt 90"
    "./result_6chains/node59_1_0.txt 89"
    "./result_6chains/node59_1_2.txt 89"
    "./result_6chains/node59_2_0.txt 88"
    "./result_6chains/node59_2_2.txt 88"
    "./result_6chains/node59_3_0.txt 87"
    "./result_6chains/node59_3_2.txt 87"
    "./result_6chains/node59_4_0.txt 86"
    "./result_6chains/node59_4_2.txt 86"
    "./result_6chains/node59_5_0.txt 85"
    "./result_6chains/node59_5_2.txt 85"
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
