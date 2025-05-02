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
ros2 run evaluation_3_randomdag uunifast_node -n node94_0_2 -p 167 -st topic94_0_1 -pt None -u 0.019506938824004116 > ./result_6chains/node94_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_1_2 -p 359 -st topic94_1_1 -pt None -u 0.011130002453430099 > ./result_6chains/node94_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_2_2 -p 428 -st topic94_2_1 -pt None -u 0.0027702208249651417 > ./result_6chains/node94_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_3_2 -p 492 -st topic94_3_1 -pt None -u 0.025388948228635022 > ./result_6chains/node94_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_4_2 -p 820 -st topic94_4_1 -pt None -u 0.0010663251924095951 > ./result_6chains/node94_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_5_2 -p 944 -st topic94_5_1 -pt None -u 0.009102797614669384 > ./result_6chains/node94_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_0_0 -p 167 -st none -pt topic94_0_0 -u 0.037811715671925206 > ./result_6chains/node94_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_1_0 -p 359 -st none -pt topic94_1_0 -u 0.029173120682035425 > ./result_6chains/node94_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_2_0 -p 428 -st none -pt topic94_2_0 -u 0.029950360100754636 > ./result_6chains/node94_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_3_0 -p 492 -st none -pt topic94_3_0 -u 0.040576138182070065 > ./result_6chains/node94_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_4_0 -p 820 -st none -pt topic94_4_0 -u 0.18699963006410414 > ./result_6chains/node94_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_5_0 -p 944 -st none -pt topic94_5_0 -u 0.016858973615412855 > ./result_6chains/node94_5_0.txt &
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
    "./result_6chains/node94_0_0.txt 90"
    "./result_6chains/node94_0_2.txt 90"
    "./result_6chains/node94_1_0.txt 89"
    "./result_6chains/node94_1_2.txt 89"
    "./result_6chains/node94_2_0.txt 88"
    "./result_6chains/node94_2_2.txt 88"
    "./result_6chains/node94_3_0.txt 87"
    "./result_6chains/node94_3_2.txt 87"
    "./result_6chains/node94_4_0.txt 86"
    "./result_6chains/node94_4_2.txt 86"
    "./result_6chains/node94_5_0.txt 85"
    "./result_6chains/node94_5_2.txt 85"
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
