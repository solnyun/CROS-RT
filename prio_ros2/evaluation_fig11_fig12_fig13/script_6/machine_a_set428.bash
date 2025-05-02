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
ros2 run evaluation_3_randomdag uunifast_node -n node428_0_2 -p 29 -st topic428_0_1 -pt None -u 0.10623940539379761 > ./result_6chains/node428_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_1_2 -p 51 -st topic428_1_1 -pt None -u 0.008411653098531258 > ./result_6chains/node428_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_2_2 -p 240 -st topic428_2_1 -pt None -u 0.005327702745119484 > ./result_6chains/node428_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_3_2 -p 632 -st topic428_3_1 -pt None -u 0.0004079147064986466 > ./result_6chains/node428_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_4_2 -p 825 -st topic428_4_1 -pt None -u 0.03921397498171941 > ./result_6chains/node428_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_5_2 -p 960 -st topic428_5_1 -pt None -u 0.01715771326561687 > ./result_6chains/node428_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_0_0 -p 29 -st none -pt topic428_0_0 -u 0.01982223380430498 > ./result_6chains/node428_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_1_0 -p 51 -st none -pt topic428_1_0 -u 0.007404402107987429 > ./result_6chains/node428_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_2_0 -p 240 -st none -pt topic428_2_0 -u 0.031931384092897364 > ./result_6chains/node428_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_3_0 -p 632 -st none -pt topic428_3_0 -u 0.017700124431970832 > ./result_6chains/node428_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_4_0 -p 825 -st none -pt topic428_4_0 -u 0.005749395414349934 > ./result_6chains/node428_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_5_0 -p 960 -st none -pt topic428_5_0 -u 0.003960944831145376 > ./result_6chains/node428_5_0.txt &
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
    "./result_6chains/node428_0_0.txt 90"
    "./result_6chains/node428_0_2.txt 90"
    "./result_6chains/node428_1_0.txt 89"
    "./result_6chains/node428_1_2.txt 89"
    "./result_6chains/node428_2_0.txt 88"
    "./result_6chains/node428_2_2.txt 88"
    "./result_6chains/node428_3_0.txt 87"
    "./result_6chains/node428_3_2.txt 87"
    "./result_6chains/node428_4_0.txt 86"
    "./result_6chains/node428_4_2.txt 86"
    "./result_6chains/node428_5_0.txt 85"
    "./result_6chains/node428_5_2.txt 85"
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
