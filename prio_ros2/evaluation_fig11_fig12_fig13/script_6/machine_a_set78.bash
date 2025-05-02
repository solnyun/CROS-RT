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
ros2 run evaluation_3_randomdag uunifast_node -n node78_0_2 -p 47 -st topic78_0_1 -pt None -u 0.019254075324202036 > ./result_6chains/node78_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_1_2 -p 154 -st topic78_1_1 -pt None -u 0.00825416146580682 > ./result_6chains/node78_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_2_2 -p 162 -st topic78_2_1 -pt None -u 0.054326373703736996 > ./result_6chains/node78_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_3_2 -p 260 -st topic78_3_1 -pt None -u 0.042199985023080644 > ./result_6chains/node78_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_4_2 -p 264 -st topic78_4_1 -pt None -u 0.004867223525537395 > ./result_6chains/node78_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_5_2 -p 276 -st topic78_5_1 -pt None -u 0.024214449673191415 > ./result_6chains/node78_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_0_0 -p 47 -st none -pt topic78_0_0 -u 0.01671682391585566 > ./result_6chains/node78_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_1_0 -p 154 -st none -pt topic78_1_0 -u 0.018460347869189153 > ./result_6chains/node78_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_2_0 -p 162 -st none -pt topic78_2_0 -u 0.012574405430642699 > ./result_6chains/node78_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_3_0 -p 260 -st none -pt topic78_3_0 -u 0.012197270572777197 > ./result_6chains/node78_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_4_0 -p 264 -st none -pt topic78_4_0 -u 0.0017688742024873638 > ./result_6chains/node78_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_5_0 -p 276 -st none -pt topic78_5_0 -u 0.015510479633516212 > ./result_6chains/node78_5_0.txt &
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
    "./result_6chains/node78_0_0.txt 90"
    "./result_6chains/node78_0_2.txt 90"
    "./result_6chains/node78_1_0.txt 89"
    "./result_6chains/node78_1_2.txt 89"
    "./result_6chains/node78_2_0.txt 88"
    "./result_6chains/node78_2_2.txt 88"
    "./result_6chains/node78_3_0.txt 87"
    "./result_6chains/node78_3_2.txt 87"
    "./result_6chains/node78_4_0.txt 86"
    "./result_6chains/node78_4_2.txt 86"
    "./result_6chains/node78_5_0.txt 85"
    "./result_6chains/node78_5_2.txt 85"
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
