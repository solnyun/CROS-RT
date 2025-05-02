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
ros2 run evaluation_3_randomdag uunifast_node -n node439_0_2 -p 100 -st topic439_0_1 -pt None -u 0.015536947303529391 > ./result_6chains/node439_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_1_2 -p 262 -st topic439_1_1 -pt None -u 0.07562264247832073 > ./result_6chains/node439_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_2_2 -p 324 -st topic439_2_1 -pt None -u 0.018718036873382526 > ./result_6chains/node439_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_3_2 -p 726 -st topic439_3_1 -pt None -u 0.052216183134224714 > ./result_6chains/node439_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_4_2 -p 748 -st topic439_4_1 -pt None -u 0.031933021473209436 > ./result_6chains/node439_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_5_2 -p 865 -st topic439_5_1 -pt None -u 0.012891069822956229 > ./result_6chains/node439_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_0_0 -p 100 -st none -pt topic439_0_0 -u 0.0003389710913909716 > ./result_6chains/node439_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_1_0 -p 262 -st none -pt topic439_1_0 -u 0.017513079590828595 > ./result_6chains/node439_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_2_0 -p 324 -st none -pt topic439_2_0 -u 0.018683088326492348 > ./result_6chains/node439_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_3_0 -p 726 -st none -pt topic439_3_0 -u 0.01572091483892557 > ./result_6chains/node439_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_4_0 -p 748 -st none -pt topic439_4_0 -u 0.027215139028071184 > ./result_6chains/node439_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_5_0 -p 865 -st none -pt topic439_5_0 -u 0.043146727936925575 > ./result_6chains/node439_5_0.txt &
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
    "./result_6chains/node439_0_0.txt 90"
    "./result_6chains/node439_0_2.txt 90"
    "./result_6chains/node439_1_0.txt 89"
    "./result_6chains/node439_1_2.txt 89"
    "./result_6chains/node439_2_0.txt 88"
    "./result_6chains/node439_2_2.txt 88"
    "./result_6chains/node439_3_0.txt 87"
    "./result_6chains/node439_3_2.txt 87"
    "./result_6chains/node439_4_0.txt 86"
    "./result_6chains/node439_4_2.txt 86"
    "./result_6chains/node439_5_0.txt 85"
    "./result_6chains/node439_5_2.txt 85"
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
