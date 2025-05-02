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
ros2 run evaluation_3_randomdag uunifast_node -n node445_0_2 -p 73 -st topic445_0_1 -pt None -u 0.010180039074895564 > ./result_10chains/node445_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_1_2 -p 74 -st topic445_1_1 -pt None -u 0.0012632257314916795 > ./result_10chains/node445_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_2_2 -p 126 -st topic445_2_1 -pt None -u 0.0009488791387063933 > ./result_10chains/node445_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_3_2 -p 144 -st topic445_3_1 -pt None -u 0.015821261630850514 > ./result_10chains/node445_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_4_2 -p 196 -st topic445_4_1 -pt None -u 0.014959739704095698 > ./result_10chains/node445_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_5_2 -p 427 -st topic445_5_1 -pt None -u 0.005136091657203162 > ./result_10chains/node445_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_6_2 -p 429 -st topic445_6_1 -pt None -u 0.018633318757712403 > ./result_10chains/node445_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_7_2 -p 900 -st topic445_7_1 -pt None -u 0.03069032793705205 > ./result_10chains/node445_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_8_2 -p 956 -st topic445_8_1 -pt None -u 0.001323556662181688 > ./result_10chains/node445_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_9_2 -p 979 -st topic445_9_1 -pt None -u 0.03391631371867479 > ./result_10chains/node445_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_0_0 -p 73 -st none -pt topic445_0_0 -u 0.007966835481604595 > ./result_10chains/node445_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_1_0 -p 74 -st none -pt topic445_1_0 -u 0.014754077254579223 > ./result_10chains/node445_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_2_0 -p 126 -st none -pt topic445_2_0 -u 0.048109746920282026 > ./result_10chains/node445_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_3_0 -p 144 -st none -pt topic445_3_0 -u 0.010421485979897782 > ./result_10chains/node445_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_4_0 -p 196 -st none -pt topic445_4_0 -u 0.0014393328725091914 > ./result_10chains/node445_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_5_0 -p 427 -st none -pt topic445_5_0 -u 0.05133779205545774 > ./result_10chains/node445_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_6_0 -p 429 -st none -pt topic445_6_0 -u 0.00021997770021300878 > ./result_10chains/node445_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_7_0 -p 900 -st none -pt topic445_7_0 -u 0.020166320688279615 > ./result_10chains/node445_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_8_0 -p 956 -st none -pt topic445_8_0 -u 0.011679411872988973 > ./result_10chains/node445_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_9_0 -p 979 -st none -pt topic445_9_0 -u 0.0026493560824291384 > ./result_10chains/node445_9_0.txt &
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
    "./result_10chains/node445_0_0.txt 90"
    "./result_10chains/node445_0_2.txt 90"
    "./result_10chains/node445_1_0.txt 89"
    "./result_10chains/node445_1_2.txt 89"
    "./result_10chains/node445_2_0.txt 88"
    "./result_10chains/node445_2_2.txt 88"
    "./result_10chains/node445_3_0.txt 87"
    "./result_10chains/node445_3_2.txt 87"
    "./result_10chains/node445_4_0.txt 86"
    "./result_10chains/node445_4_2.txt 86"
    "./result_10chains/node445_5_0.txt 85"
    "./result_10chains/node445_5_2.txt 85"
    "./result_10chains/node445_6_0.txt 84"
    "./result_10chains/node445_6_2.txt 84"
    "./result_10chains/node445_7_0.txt 83"
    "./result_10chains/node445_7_2.txt 83"
    "./result_10chains/node445_8_0.txt 82"
    "./result_10chains/node445_8_2.txt 82"
    "./result_10chains/node445_9_0.txt 81"
    "./result_10chains/node445_9_2.txt 81"
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
