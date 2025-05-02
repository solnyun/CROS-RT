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
ros2 run evaluation_3_randomdag uunifast_node -n node364_0_2 -p 300 -st topic364_0_1 -pt None -u 0.01159670406103136 > ./result_6chains/node364_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_1_2 -p 329 -st topic364_1_1 -pt None -u 0.06599642211748052 > ./result_6chains/node364_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_2_2 -p 387 -st topic364_2_1 -pt None -u 0.008003998242183313 > ./result_6chains/node364_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_3_2 -p 699 -st topic364_3_1 -pt None -u 0.012097963959476904 > ./result_6chains/node364_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_4_2 -p 705 -st topic364_4_1 -pt None -u 0.019206052122121856 > ./result_6chains/node364_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_5_2 -p 767 -st topic364_5_1 -pt None -u 0.015894458644714143 > ./result_6chains/node364_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_0_0 -p 300 -st none -pt topic364_0_0 -u 0.08582867935425409 > ./result_6chains/node364_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_1_0 -p 329 -st none -pt topic364_1_0 -u 0.03964757089862897 > ./result_6chains/node364_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_2_0 -p 387 -st none -pt topic364_2_0 -u 0.022833247387622407 > ./result_6chains/node364_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_3_0 -p 699 -st none -pt topic364_3_0 -u 0.004897930074754225 > ./result_6chains/node364_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_4_0 -p 705 -st none -pt topic364_4_0 -u 0.016997372901403768 > ./result_6chains/node364_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_5_0 -p 767 -st none -pt topic364_5_0 -u 0.04442826684771879 > ./result_6chains/node364_5_0.txt &
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
    "./result_6chains/node364_0_0.txt 90"
    "./result_6chains/node364_0_2.txt 90"
    "./result_6chains/node364_1_0.txt 89"
    "./result_6chains/node364_1_2.txt 89"
    "./result_6chains/node364_2_0.txt 88"
    "./result_6chains/node364_2_2.txt 88"
    "./result_6chains/node364_3_0.txt 87"
    "./result_6chains/node364_3_2.txt 87"
    "./result_6chains/node364_4_0.txt 86"
    "./result_6chains/node364_4_2.txt 86"
    "./result_6chains/node364_5_0.txt 85"
    "./result_6chains/node364_5_2.txt 85"
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
