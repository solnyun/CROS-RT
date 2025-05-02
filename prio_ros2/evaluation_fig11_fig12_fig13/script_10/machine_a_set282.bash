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
ros2 run evaluation_3_randomdag uunifast_node -n node282_0_2 -p 60 -st topic282_0_1 -pt None -u 0.009202683363272346 > ./result_10chains/node282_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_1_2 -p 99 -st topic282_1_1 -pt None -u 0.034394408788257336 > ./result_10chains/node282_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_2_2 -p 255 -st topic282_2_1 -pt None -u 0.010102541199128623 > ./result_10chains/node282_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_3_2 -p 289 -st topic282_3_1 -pt None -u 0.04826963875501794 > ./result_10chains/node282_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_4_2 -p 331 -st topic282_4_1 -pt None -u 0.032158216252445554 > ./result_10chains/node282_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_5_2 -p 567 -st topic282_5_1 -pt None -u 0.0009750293472635119 > ./result_10chains/node282_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_6_2 -p 623 -st topic282_6_1 -pt None -u 0.005097838977599939 > ./result_10chains/node282_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_7_2 -p 811 -st topic282_7_1 -pt None -u 0.03677942772596288 > ./result_10chains/node282_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_8_2 -p 854 -st topic282_8_1 -pt None -u 0.05336907499186391 > ./result_10chains/node282_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_9_2 -p 918 -st topic282_9_1 -pt None -u 0.03929580000612647 > ./result_10chains/node282_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_0_0 -p 60 -st none -pt topic282_0_0 -u 0.013429218438384016 > ./result_10chains/node282_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_1_0 -p 99 -st none -pt topic282_1_0 -u 0.004984525644893878 > ./result_10chains/node282_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_2_0 -p 255 -st none -pt topic282_2_0 -u 0.006362850565052147 > ./result_10chains/node282_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_3_0 -p 289 -st none -pt topic282_3_0 -u 0.044512743931877874 > ./result_10chains/node282_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_4_0 -p 331 -st none -pt topic282_4_0 -u 0.035787787205714405 > ./result_10chains/node282_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_5_0 -p 567 -st none -pt topic282_5_0 -u 0.006204067181219547 > ./result_10chains/node282_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_6_0 -p 623 -st none -pt topic282_6_0 -u 0.015220846137224603 > ./result_10chains/node282_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_7_0 -p 811 -st none -pt topic282_7_0 -u 0.0001980634412623028 > ./result_10chains/node282_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_8_0 -p 854 -st none -pt topic282_8_0 -u 0.0003692695133107604 > ./result_10chains/node282_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_9_0 -p 918 -st none -pt topic282_9_0 -u 0.005646205717181371 > ./result_10chains/node282_9_0.txt &
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
    "./result_10chains/node282_0_0.txt 90"
    "./result_10chains/node282_0_2.txt 90"
    "./result_10chains/node282_1_0.txt 89"
    "./result_10chains/node282_1_2.txt 89"
    "./result_10chains/node282_2_0.txt 88"
    "./result_10chains/node282_2_2.txt 88"
    "./result_10chains/node282_3_0.txt 87"
    "./result_10chains/node282_3_2.txt 87"
    "./result_10chains/node282_4_0.txt 86"
    "./result_10chains/node282_4_2.txt 86"
    "./result_10chains/node282_5_0.txt 85"
    "./result_10chains/node282_5_2.txt 85"
    "./result_10chains/node282_6_0.txt 84"
    "./result_10chains/node282_6_2.txt 84"
    "./result_10chains/node282_7_0.txt 83"
    "./result_10chains/node282_7_2.txt 83"
    "./result_10chains/node282_8_0.txt 82"
    "./result_10chains/node282_8_2.txt 82"
    "./result_10chains/node282_9_0.txt 81"
    "./result_10chains/node282_9_2.txt 81"
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
