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
ros2 run evaluation_3_randomdag uunifast_node -n node255_0_2 -p 429 -st topic255_0_1 -pt None -u 0.06582596167824725 > ./result_2chains/node255_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_1_2 -p 741 -st topic255_1_1 -pt None -u 0.07853227080572578 > ./result_2chains/node255_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_0_0 -p 429 -st none -pt topic255_0_0 -u 0.09663724559602116 > ./result_2chains/node255_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_1_0 -p 741 -st none -pt topic255_1_0 -u 0.07830566169081563 > ./result_2chains/node255_1_0.txt &
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
    "./result_2chains/node255_0_0.txt 90"
    "./result_2chains/node255_0_2.txt 90"
    "./result_2chains/node255_1_0.txt 89"
    "./result_2chains/node255_1_2.txt 89"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
