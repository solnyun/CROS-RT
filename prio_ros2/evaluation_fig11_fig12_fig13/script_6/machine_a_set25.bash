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
ros2 run evaluation_3_randomdag uunifast_node -n node25_0_2 -p 29 -st topic25_0_1 -pt None -u 0.04408460021560856 > ./result_6chains/node25_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_1_2 -p 124 -st topic25_1_1 -pt None -u 0.05149434908262862 > ./result_6chains/node25_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_2_2 -p 150 -st topic25_2_1 -pt None -u 0.017656070522311357 > ./result_6chains/node25_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_3_2 -p 246 -st topic25_3_1 -pt None -u 0.011021216034109105 > ./result_6chains/node25_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_4_2 -p 330 -st topic25_4_1 -pt None -u 0.060351467272247133 > ./result_6chains/node25_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_5_2 -p 964 -st topic25_5_1 -pt None -u 0.015509767309805385 > ./result_6chains/node25_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_0_0 -p 29 -st none -pt topic25_0_0 -u 0.01592615825864907 > ./result_6chains/node25_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_1_0 -p 124 -st none -pt topic25_1_0 -u 0.08680191210215044 > ./result_6chains/node25_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_2_0 -p 150 -st none -pt topic25_2_0 -u 0.02596465733689507 > ./result_6chains/node25_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_3_0 -p 246 -st none -pt topic25_3_0 -u 0.0020910553173862645 > ./result_6chains/node25_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_4_0 -p 330 -st none -pt topic25_4_0 -u 0.02019658700637239 > ./result_6chains/node25_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_5_0 -p 964 -st none -pt topic25_5_0 -u 0.0253994645777519 > ./result_6chains/node25_5_0.txt &
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
    "./result_6chains/node25_0_0.txt 90"
    "./result_6chains/node25_0_2.txt 90"
    "./result_6chains/node25_1_0.txt 89"
    "./result_6chains/node25_1_2.txt 89"
    "./result_6chains/node25_2_0.txt 88"
    "./result_6chains/node25_2_2.txt 88"
    "./result_6chains/node25_3_0.txt 87"
    "./result_6chains/node25_3_2.txt 87"
    "./result_6chains/node25_4_0.txt 86"
    "./result_6chains/node25_4_2.txt 86"
    "./result_6chains/node25_5_0.txt 85"
    "./result_6chains/node25_5_2.txt 85"
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
