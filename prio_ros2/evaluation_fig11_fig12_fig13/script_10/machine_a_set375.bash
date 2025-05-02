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
ros2 run evaluation_3_randomdag uunifast_node -n node375_0_2 -p 36 -st topic375_0_1 -pt None -u 0.003668912804302482 > ./result_10chains/node375_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_1_2 -p 94 -st topic375_1_1 -pt None -u 0.0018429888524466032 > ./result_10chains/node375_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_2_2 -p 239 -st topic375_2_1 -pt None -u 0.021975126490957675 > ./result_10chains/node375_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_3_2 -p 306 -st topic375_3_1 -pt None -u 0.047763670522797064 > ./result_10chains/node375_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_4_2 -p 395 -st topic375_4_1 -pt None -u 0.004142391423860803 > ./result_10chains/node375_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_5_2 -p 530 -st topic375_5_1 -pt None -u 0.04259250806599871 > ./result_10chains/node375_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_6_2 -p 535 -st topic375_6_1 -pt None -u 0.04958260404031321 > ./result_10chains/node375_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_7_2 -p 672 -st topic375_7_1 -pt None -u 0.0021287440986469397 > ./result_10chains/node375_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_8_2 -p 687 -st topic375_8_1 -pt None -u 0.005545110171230241 > ./result_10chains/node375_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_9_2 -p 941 -st topic375_9_1 -pt None -u 0.003744041092121949 > ./result_10chains/node375_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_0_0 -p 36 -st none -pt topic375_0_0 -u 0.014500238713236135 > ./result_10chains/node375_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_1_0 -p 94 -st none -pt topic375_1_0 -u 0.005442435000780899 > ./result_10chains/node375_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_2_0 -p 239 -st none -pt topic375_2_0 -u 0.021681226557514532 > ./result_10chains/node375_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_3_0 -p 306 -st none -pt topic375_3_0 -u 0.010319455508713882 > ./result_10chains/node375_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_4_0 -p 395 -st none -pt topic375_4_0 -u 0.004772046242300376 > ./result_10chains/node375_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_5_0 -p 530 -st none -pt topic375_5_0 -u 0.011435403344619677 > ./result_10chains/node375_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_6_0 -p 535 -st none -pt topic375_6_0 -u 0.00724616774845066 > ./result_10chains/node375_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_7_0 -p 672 -st none -pt topic375_7_0 -u 0.00022836078352209133 > ./result_10chains/node375_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_8_0 -p 687 -st none -pt topic375_8_0 -u 0.02163541835850328 > ./result_10chains/node375_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_9_0 -p 941 -st none -pt topic375_9_0 -u 8.238215028471933e-05 > ./result_10chains/node375_9_0.txt &
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
    "./result_10chains/node375_0_0.txt 90"
    "./result_10chains/node375_0_2.txt 90"
    "./result_10chains/node375_1_0.txt 89"
    "./result_10chains/node375_1_2.txt 89"
    "./result_10chains/node375_2_0.txt 88"
    "./result_10chains/node375_2_2.txt 88"
    "./result_10chains/node375_3_0.txt 87"
    "./result_10chains/node375_3_2.txt 87"
    "./result_10chains/node375_4_0.txt 86"
    "./result_10chains/node375_4_2.txt 86"
    "./result_10chains/node375_5_0.txt 85"
    "./result_10chains/node375_5_2.txt 85"
    "./result_10chains/node375_6_0.txt 84"
    "./result_10chains/node375_6_2.txt 84"
    "./result_10chains/node375_7_0.txt 83"
    "./result_10chains/node375_7_2.txt 83"
    "./result_10chains/node375_8_0.txt 82"
    "./result_10chains/node375_8_2.txt 82"
    "./result_10chains/node375_9_0.txt 81"
    "./result_10chains/node375_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
