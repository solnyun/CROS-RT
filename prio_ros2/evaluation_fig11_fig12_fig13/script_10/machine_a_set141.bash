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
ros2 run evaluation_3_randomdag uunifast_node -n node141_0_2 -p 94 -st topic141_0_1 -pt None -u 0.10889024171213124 > ./result_10chains/node141_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_1_2 -p 132 -st topic141_1_1 -pt None -u 0.007315919207866006 > ./result_10chains/node141_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_2_2 -p 181 -st topic141_2_1 -pt None -u 0.006193822694122941 > ./result_10chains/node141_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_3_2 -p 364 -st topic141_3_1 -pt None -u 0.00016440670759593212 > ./result_10chains/node141_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_4_2 -p 395 -st topic141_4_1 -pt None -u 0.04550716497628682 > ./result_10chains/node141_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_5_2 -p 661 -st topic141_5_1 -pt None -u 0.0020508223989241514 > ./result_10chains/node141_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_6_2 -p 705 -st topic141_6_1 -pt None -u 0.007592978718168997 > ./result_10chains/node141_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_7_2 -p 792 -st topic141_7_1 -pt None -u 0.019279016178430156 > ./result_10chains/node141_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_8_2 -p 867 -st topic141_8_1 -pt None -u 0.0015211047475022707 > ./result_10chains/node141_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_9_2 -p 997 -st topic141_9_1 -pt None -u 0.005778403807732827 > ./result_10chains/node141_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_0_0 -p 94 -st none -pt topic141_0_0 -u 0.026857594313687727 > ./result_10chains/node141_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_1_0 -p 132 -st none -pt topic141_1_0 -u 0.067001900874547 > ./result_10chains/node141_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_2_0 -p 181 -st none -pt topic141_2_0 -u 0.006927044589244757 > ./result_10chains/node141_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_3_0 -p 364 -st none -pt topic141_3_0 -u 0.013574988172967761 > ./result_10chains/node141_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_4_0 -p 395 -st none -pt topic141_4_0 -u 0.005871185325094952 > ./result_10chains/node141_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_5_0 -p 661 -st none -pt topic141_5_0 -u 0.008716260751667565 > ./result_10chains/node141_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_6_0 -p 705 -st none -pt topic141_6_0 -u 0.0014689512090854673 > ./result_10chains/node141_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_7_0 -p 792 -st none -pt topic141_7_0 -u 0.05717612354370026 > ./result_10chains/node141_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_8_0 -p 867 -st none -pt topic141_8_0 -u 0.0020438367125700033 > ./result_10chains/node141_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_9_0 -p 997 -st none -pt topic141_9_0 -u 0.027227424953009297 > ./result_10chains/node141_9_0.txt &
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
    "./result_10chains/node141_0_0.txt 90"
    "./result_10chains/node141_0_2.txt 90"
    "./result_10chains/node141_1_0.txt 89"
    "./result_10chains/node141_1_2.txt 89"
    "./result_10chains/node141_2_0.txt 88"
    "./result_10chains/node141_2_2.txt 88"
    "./result_10chains/node141_3_0.txt 87"
    "./result_10chains/node141_3_2.txt 87"
    "./result_10chains/node141_4_0.txt 86"
    "./result_10chains/node141_4_2.txt 86"
    "./result_10chains/node141_5_0.txt 85"
    "./result_10chains/node141_5_2.txt 85"
    "./result_10chains/node141_6_0.txt 84"
    "./result_10chains/node141_6_2.txt 84"
    "./result_10chains/node141_7_0.txt 83"
    "./result_10chains/node141_7_2.txt 83"
    "./result_10chains/node141_8_0.txt 82"
    "./result_10chains/node141_8_2.txt 82"
    "./result_10chains/node141_9_0.txt 81"
    "./result_10chains/node141_9_2.txt 81"
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
