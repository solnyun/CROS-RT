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
ros2 run evaluation_3_randomdag uunifast_node -n node60_0_2 -p 84 -st topic60_0_1 -pt None -u 0.04520322456119791 > ./result_10chains/node60_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_1_2 -p 115 -st topic60_1_1 -pt None -u 0.00840200772270483 > ./result_10chains/node60_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_2_2 -p 240 -st topic60_2_1 -pt None -u 0.029115145943726273 > ./result_10chains/node60_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_3_2 -p 317 -st topic60_3_1 -pt None -u 0.025109681857473476 > ./result_10chains/node60_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_4_2 -p 487 -st topic60_4_1 -pt None -u 0.04960683775101288 > ./result_10chains/node60_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_5_2 -p 549 -st topic60_5_1 -pt None -u 0.009488111899396329 > ./result_10chains/node60_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_6_2 -p 658 -st topic60_6_1 -pt None -u 0.014173620151069169 > ./result_10chains/node60_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_7_2 -p 750 -st topic60_7_1 -pt None -u 0.004087776454470213 > ./result_10chains/node60_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_8_2 -p 910 -st topic60_8_1 -pt None -u 0.005004899584940763 > ./result_10chains/node60_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_9_2 -p 923 -st topic60_9_1 -pt None -u 0.01110942241645581 > ./result_10chains/node60_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_0_0 -p 84 -st none -pt topic60_0_0 -u 0.002632691920103236 > ./result_10chains/node60_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_1_0 -p 115 -st none -pt topic60_1_0 -u 0.003747702796438046 > ./result_10chains/node60_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_2_0 -p 240 -st none -pt topic60_2_0 -u 0.0026733578729950525 > ./result_10chains/node60_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_3_0 -p 317 -st none -pt topic60_3_0 -u 0.005183800891865431 > ./result_10chains/node60_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_4_0 -p 487 -st none -pt topic60_4_0 -u 0.03859568230193455 > ./result_10chains/node60_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_5_0 -p 549 -st none -pt topic60_5_0 -u 0.017768625659488918 > ./result_10chains/node60_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_6_0 -p 658 -st none -pt topic60_6_0 -u 0.016612543873165492 > ./result_10chains/node60_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_7_0 -p 750 -st none -pt topic60_7_0 -u 0.012710739645191267 > ./result_10chains/node60_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_8_0 -p 910 -st none -pt topic60_8_0 -u 0.00828625308059465 > ./result_10chains/node60_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_9_0 -p 923 -st none -pt topic60_9_0 -u 0.005437645950704572 > ./result_10chains/node60_9_0.txt &
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
    "./result_10chains/node60_0_0.txt 90"
    "./result_10chains/node60_0_2.txt 90"
    "./result_10chains/node60_1_0.txt 89"
    "./result_10chains/node60_1_2.txt 89"
    "./result_10chains/node60_2_0.txt 88"
    "./result_10chains/node60_2_2.txt 88"
    "./result_10chains/node60_3_0.txt 87"
    "./result_10chains/node60_3_2.txt 87"
    "./result_10chains/node60_4_0.txt 86"
    "./result_10chains/node60_4_2.txt 86"
    "./result_10chains/node60_5_0.txt 85"
    "./result_10chains/node60_5_2.txt 85"
    "./result_10chains/node60_6_0.txt 84"
    "./result_10chains/node60_6_2.txt 84"
    "./result_10chains/node60_7_0.txt 83"
    "./result_10chains/node60_7_2.txt 83"
    "./result_10chains/node60_8_0.txt 82"
    "./result_10chains/node60_8_2.txt 82"
    "./result_10chains/node60_9_0.txt 81"
    "./result_10chains/node60_9_2.txt 81"
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
