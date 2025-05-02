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
ros2 run evaluation_3_randomdag uunifast_node -n node34_0_2 -p 228 -st topic34_0_1 -pt None -u 0.05361685464089544 > ./result_6chains/node34_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_1_2 -p 371 -st topic34_1_1 -pt None -u 0.036511193095116246 > ./result_6chains/node34_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_2_2 -p 386 -st topic34_2_1 -pt None -u 0.10682970960444876 > ./result_6chains/node34_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_3_2 -p 546 -st topic34_3_1 -pt None -u 0.018914805805720136 > ./result_6chains/node34_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_4_2 -p 858 -st topic34_4_1 -pt None -u 0.021460986505936336 > ./result_6chains/node34_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_5_2 -p 890 -st topic34_5_1 -pt None -u 0.06611713413109963 > ./result_6chains/node34_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_0_0 -p 228 -st none -pt topic34_0_0 -u 0.009020294038739385 > ./result_6chains/node34_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_1_0 -p 371 -st none -pt topic34_1_0 -u 0.013694251485878384 > ./result_6chains/node34_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_2_0 -p 386 -st none -pt topic34_2_0 -u 0.012952109282514612 > ./result_6chains/node34_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_3_0 -p 546 -st none -pt topic34_3_0 -u 0.03610949882809025 > ./result_6chains/node34_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_4_0 -p 858 -st none -pt topic34_4_0 -u 0.001575313730904332 > ./result_6chains/node34_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_5_0 -p 890 -st none -pt topic34_5_0 -u 0.043841736722006 > ./result_6chains/node34_5_0.txt &
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
    "./result_6chains/node34_0_0.txt 90"
    "./result_6chains/node34_0_2.txt 90"
    "./result_6chains/node34_1_0.txt 89"
    "./result_6chains/node34_1_2.txt 89"
    "./result_6chains/node34_2_0.txt 88"
    "./result_6chains/node34_2_2.txt 88"
    "./result_6chains/node34_3_0.txt 87"
    "./result_6chains/node34_3_2.txt 87"
    "./result_6chains/node34_4_0.txt 86"
    "./result_6chains/node34_4_2.txt 86"
    "./result_6chains/node34_5_0.txt 85"
    "./result_6chains/node34_5_2.txt 85"
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
