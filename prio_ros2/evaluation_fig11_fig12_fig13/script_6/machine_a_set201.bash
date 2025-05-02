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
ros2 run evaluation_3_randomdag uunifast_node -n node201_0_2 -p 49 -st topic201_0_1 -pt None -u 0.04287995122548344 > ./result_6chains/node201_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_1_2 -p 229 -st topic201_1_1 -pt None -u 0.011197767804035641 > ./result_6chains/node201_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_2_2 -p 396 -st topic201_2_1 -pt None -u 0.01173911326329885 > ./result_6chains/node201_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_3_2 -p 722 -st topic201_3_1 -pt None -u 0.032567471928024005 > ./result_6chains/node201_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_4_2 -p 807 -st topic201_4_1 -pt None -u 0.05897544884151604 > ./result_6chains/node201_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_5_2 -p 836 -st topic201_5_1 -pt None -u 0.05749259397685644 > ./result_6chains/node201_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_0_0 -p 49 -st none -pt topic201_0_0 -u 0.016189936922359927 > ./result_6chains/node201_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_1_0 -p 229 -st none -pt topic201_1_0 -u 0.05341482328094527 > ./result_6chains/node201_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_2_0 -p 396 -st none -pt topic201_2_0 -u 0.021297092887994806 > ./result_6chains/node201_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_3_0 -p 722 -st none -pt topic201_3_0 -u 0.004636091517801533 > ./result_6chains/node201_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_4_0 -p 807 -st none -pt topic201_4_0 -u 0.04196040174146018 > ./result_6chains/node201_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_5_0 -p 836 -st none -pt topic201_5_0 -u 0.01823706857950365 > ./result_6chains/node201_5_0.txt &
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
    "./result_6chains/node201_0_0.txt 90"
    "./result_6chains/node201_0_2.txt 90"
    "./result_6chains/node201_1_0.txt 89"
    "./result_6chains/node201_1_2.txt 89"
    "./result_6chains/node201_2_0.txt 88"
    "./result_6chains/node201_2_2.txt 88"
    "./result_6chains/node201_3_0.txt 87"
    "./result_6chains/node201_3_2.txt 87"
    "./result_6chains/node201_4_0.txt 86"
    "./result_6chains/node201_4_2.txt 86"
    "./result_6chains/node201_5_0.txt 85"
    "./result_6chains/node201_5_2.txt 85"
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
