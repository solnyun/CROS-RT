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
ros2 run evaluation_3_randomdag uunifast_node -n node231_0_2 -p 18 -st topic231_0_1 -pt None -u 0.0015731844056988131 > ./result_6chains/node231_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_1_2 -p 203 -st topic231_1_1 -pt None -u 0.028669300474732373 > ./result_6chains/node231_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_2_2 -p 495 -st topic231_2_1 -pt None -u 0.030606637024329086 > ./result_6chains/node231_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_3_2 -p 790 -st topic231_3_1 -pt None -u 0.035122910903267204 > ./result_6chains/node231_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_4_2 -p 908 -st topic231_4_1 -pt None -u 0.001980901670847496 > ./result_6chains/node231_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_5_2 -p 936 -st topic231_5_1 -pt None -u 0.037449763943371496 > ./result_6chains/node231_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_0_0 -p 18 -st none -pt topic231_0_0 -u 0.09907979058778593 > ./result_6chains/node231_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_1_0 -p 203 -st none -pt topic231_1_0 -u 0.041184264000526605 > ./result_6chains/node231_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_2_0 -p 495 -st none -pt topic231_2_0 -u 0.0021076369259364625 > ./result_6chains/node231_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_3_0 -p 790 -st none -pt topic231_3_0 -u 0.012712814680042511 > ./result_6chains/node231_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_4_0 -p 908 -st none -pt topic231_4_0 -u 0.0072829307352101635 > ./result_6chains/node231_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_5_0 -p 936 -st none -pt topic231_5_0 -u 0.020712777948147368 > ./result_6chains/node231_5_0.txt &
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
    "./result_6chains/node231_0_0.txt 90"
    "./result_6chains/node231_0_2.txt 90"
    "./result_6chains/node231_1_0.txt 89"
    "./result_6chains/node231_1_2.txt 89"
    "./result_6chains/node231_2_0.txt 88"
    "./result_6chains/node231_2_2.txt 88"
    "./result_6chains/node231_3_0.txt 87"
    "./result_6chains/node231_3_2.txt 87"
    "./result_6chains/node231_4_0.txt 86"
    "./result_6chains/node231_4_2.txt 86"
    "./result_6chains/node231_5_0.txt 85"
    "./result_6chains/node231_5_2.txt 85"
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
