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
ros2 run evaluation_3_randomdag uunifast_node -n node368_0_2 -p 279 -st topic368_0_1 -pt None -u 0.018784293789708528 > ./result_6chains/node368_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_1_2 -p 392 -st topic368_1_1 -pt None -u 0.0204929837520344 > ./result_6chains/node368_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_2_2 -p 400 -st topic368_2_1 -pt None -u 0.07347999740314187 > ./result_6chains/node368_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_3_2 -p 543 -st topic368_3_1 -pt None -u 0.024574826606249905 > ./result_6chains/node368_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_4_2 -p 580 -st topic368_4_1 -pt None -u 0.025162040213695544 > ./result_6chains/node368_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_5_2 -p 999 -st topic368_5_1 -pt None -u 0.007769856256819329 > ./result_6chains/node368_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_0_0 -p 279 -st none -pt topic368_0_0 -u 0.0012252064698935472 > ./result_6chains/node368_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_1_0 -p 392 -st none -pt topic368_1_0 -u 0.03112649660487632 > ./result_6chains/node368_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_2_0 -p 400 -st none -pt topic368_2_0 -u 0.03507033308435453 > ./result_6chains/node368_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_3_0 -p 543 -st none -pt topic368_3_0 -u 0.0009857722903652277 > ./result_6chains/node368_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_4_0 -p 580 -st none -pt topic368_4_0 -u 0.010222608714263282 > ./result_6chains/node368_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_5_0 -p 999 -st none -pt topic368_5_0 -u 0.07679204387622313 > ./result_6chains/node368_5_0.txt &
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
    "./result_6chains/node368_0_0.txt 90"
    "./result_6chains/node368_0_2.txt 90"
    "./result_6chains/node368_1_0.txt 89"
    "./result_6chains/node368_1_2.txt 89"
    "./result_6chains/node368_2_0.txt 88"
    "./result_6chains/node368_2_2.txt 88"
    "./result_6chains/node368_3_0.txt 87"
    "./result_6chains/node368_3_2.txt 87"
    "./result_6chains/node368_4_0.txt 86"
    "./result_6chains/node368_4_2.txt 86"
    "./result_6chains/node368_5_0.txt 85"
    "./result_6chains/node368_5_2.txt 85"
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
