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
ros2 run evaluation_3_randomdag uunifast_node -n node189_0_2 -p 56 -st topic189_0_1 -pt None -u 0.06774920009003904 > ./result_4chains/node189_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_1_2 -p 125 -st topic189_1_1 -pt None -u 0.035295520288731064 > ./result_4chains/node189_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_2_2 -p 133 -st topic189_2_1 -pt None -u 0.018048740593459622 > ./result_4chains/node189_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_3_2 -p 740 -st topic189_3_1 -pt None -u 0.038167091579675065 > ./result_4chains/node189_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_0_0 -p 56 -st none -pt topic189_0_0 -u 0.04689767906536707 > ./result_4chains/node189_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_1_0 -p 125 -st none -pt topic189_1_0 -u 0.03242650565476407 > ./result_4chains/node189_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_2_0 -p 133 -st none -pt topic189_2_0 -u 0.029021031519186946 > ./result_4chains/node189_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_3_0 -p 740 -st none -pt topic189_3_0 -u 0.08297406484095318 > ./result_4chains/node189_3_0.txt &
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
    "./result_4chains/node189_0_0.txt 90"
    "./result_4chains/node189_0_2.txt 90"
    "./result_4chains/node189_1_0.txt 89"
    "./result_4chains/node189_1_2.txt 89"
    "./result_4chains/node189_2_0.txt 88"
    "./result_4chains/node189_2_2.txt 88"
    "./result_4chains/node189_3_0.txt 87"
    "./result_4chains/node189_3_2.txt 87"
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
