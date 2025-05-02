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
ros2 run evaluation_3_randomdag uunifast_node -n node22_0_2 -p 142 -st topic22_0_1 -pt None -u 0.03843843267922992 > ./result_6chains/node22_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_1_2 -p 165 -st topic22_1_1 -pt None -u 0.037300027532493896 > ./result_6chains/node22_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_2_2 -p 187 -st topic22_2_1 -pt None -u 0.04125024863645335 > ./result_6chains/node22_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_3_2 -p 236 -st topic22_3_1 -pt None -u 0.036440135941238724 > ./result_6chains/node22_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_4_2 -p 340 -st topic22_4_1 -pt None -u 0.01781419637955685 > ./result_6chains/node22_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_5_2 -p 559 -st topic22_5_1 -pt None -u 0.015060973015889125 > ./result_6chains/node22_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_0_0 -p 142 -st none -pt topic22_0_0 -u 0.08116304825931664 > ./result_6chains/node22_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_1_0 -p 165 -st none -pt topic22_1_0 -u 0.032182081763242776 > ./result_6chains/node22_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_2_0 -p 187 -st none -pt topic22_2_0 -u 0.024500388021322705 > ./result_6chains/node22_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_3_0 -p 236 -st none -pt topic22_3_0 -u 0.009854611713208172 > ./result_6chains/node22_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_4_0 -p 340 -st none -pt topic22_4_0 -u 0.0022750862526775967 > ./result_6chains/node22_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_5_0 -p 559 -st none -pt topic22_5_0 -u 0.023543438770836242 > ./result_6chains/node22_5_0.txt &
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
    "./result_6chains/node22_0_0.txt 90"
    "./result_6chains/node22_0_2.txt 90"
    "./result_6chains/node22_1_0.txt 89"
    "./result_6chains/node22_1_2.txt 89"
    "./result_6chains/node22_2_0.txt 88"
    "./result_6chains/node22_2_2.txt 88"
    "./result_6chains/node22_3_0.txt 87"
    "./result_6chains/node22_3_2.txt 87"
    "./result_6chains/node22_4_0.txt 86"
    "./result_6chains/node22_4_2.txt 86"
    "./result_6chains/node22_5_0.txt 85"
    "./result_6chains/node22_5_2.txt 85"
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
