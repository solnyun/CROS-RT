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
ros2 run evaluation_3_randomdag uunifast_node -n node252_0_2 -p 96 -st topic252_0_1 -pt None -u 0.008976188279291475 > ./result_10chains/node252_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_1_2 -p 161 -st topic252_1_1 -pt None -u 6.782484224876484e-05 > ./result_10chains/node252_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_2_2 -p 164 -st topic252_2_1 -pt None -u 0.002580112550341629 > ./result_10chains/node252_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_3_2 -p 381 -st topic252_3_1 -pt None -u 0.007156969527936152 > ./result_10chains/node252_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_4_2 -p 453 -st topic252_4_1 -pt None -u 0.011395919766444496 > ./result_10chains/node252_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_5_2 -p 462 -st topic252_5_1 -pt None -u 0.021402596140946195 > ./result_10chains/node252_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_6_2 -p 565 -st topic252_6_1 -pt None -u 0.03422407310780837 > ./result_10chains/node252_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_7_2 -p 605 -st topic252_7_1 -pt None -u 0.0018304399385670883 > ./result_10chains/node252_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_8_2 -p 733 -st topic252_8_1 -pt None -u 0.015064292052755026 > ./result_10chains/node252_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_9_2 -p 832 -st topic252_9_1 -pt None -u 0.009538954345370396 > ./result_10chains/node252_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_0_0 -p 96 -st none -pt topic252_0_0 -u 0.00029800610287306073 > ./result_10chains/node252_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_1_0 -p 161 -st none -pt topic252_1_0 -u 0.1066833835042057 > ./result_10chains/node252_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_2_0 -p 164 -st none -pt topic252_2_0 -u 0.013782827777770623 > ./result_10chains/node252_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_3_0 -p 381 -st none -pt topic252_3_0 -u 0.010545845888803751 > ./result_10chains/node252_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_4_0 -p 453 -st none -pt topic252_4_0 -u 0.023450115652627446 > ./result_10chains/node252_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_5_0 -p 462 -st none -pt topic252_5_0 -u 0.003364569472791623 > ./result_10chains/node252_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_6_0 -p 565 -st none -pt topic252_6_0 -u 0.05556333231796223 > ./result_10chains/node252_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_7_0 -p 605 -st none -pt topic252_7_0 -u 0.006693765747780384 > ./result_10chains/node252_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_8_0 -p 733 -st none -pt topic252_8_0 -u 0.03468808594821243 > ./result_10chains/node252_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_9_0 -p 832 -st none -pt topic252_9_0 -u 0.0003008762686205653 > ./result_10chains/node252_9_0.txt &
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
    "./result_10chains/node252_0_0.txt 90"
    "./result_10chains/node252_0_2.txt 90"
    "./result_10chains/node252_1_0.txt 89"
    "./result_10chains/node252_1_2.txt 89"
    "./result_10chains/node252_2_0.txt 88"
    "./result_10chains/node252_2_2.txt 88"
    "./result_10chains/node252_3_0.txt 87"
    "./result_10chains/node252_3_2.txt 87"
    "./result_10chains/node252_4_0.txt 86"
    "./result_10chains/node252_4_2.txt 86"
    "./result_10chains/node252_5_0.txt 85"
    "./result_10chains/node252_5_2.txt 85"
    "./result_10chains/node252_6_0.txt 84"
    "./result_10chains/node252_6_2.txt 84"
    "./result_10chains/node252_7_0.txt 83"
    "./result_10chains/node252_7_2.txt 83"
    "./result_10chains/node252_8_0.txt 82"
    "./result_10chains/node252_8_2.txt 82"
    "./result_10chains/node252_9_0.txt 81"
    "./result_10chains/node252_9_2.txt 81"
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
