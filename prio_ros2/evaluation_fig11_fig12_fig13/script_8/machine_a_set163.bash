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
ros2 run evaluation_3_randomdag uunifast_node -n node163_0_2 -p 144 -st topic163_0_1 -pt None -u 0.02709343216039417 > ./result_8chains/node163_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_1_2 -p 236 -st topic163_1_1 -pt None -u 0.00949974499460432 > ./result_8chains/node163_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_2_2 -p 649 -st topic163_2_1 -pt None -u 0.03039821160141276 > ./result_8chains/node163_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_3_2 -p 742 -st topic163_3_1 -pt None -u 0.03485644317914138 > ./result_8chains/node163_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_4_2 -p 749 -st topic163_4_1 -pt None -u 0.0036479989144844738 > ./result_8chains/node163_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_5_2 -p 812 -st topic163_5_1 -pt None -u 0.0378703147189174 > ./result_8chains/node163_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_6_2 -p 907 -st topic163_6_1 -pt None -u 0.012123147189955247 > ./result_8chains/node163_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_7_2 -p 992 -st topic163_7_1 -pt None -u 0.013295028608189579 > ./result_8chains/node163_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_0_0 -p 144 -st none -pt topic163_0_0 -u 0.00621243363598728 > ./result_8chains/node163_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_1_0 -p 236 -st none -pt topic163_1_0 -u 0.002880117554078465 > ./result_8chains/node163_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_2_0 -p 649 -st none -pt topic163_2_0 -u 0.005630712836200202 > ./result_8chains/node163_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_3_0 -p 742 -st none -pt topic163_3_0 -u 0.015426940712789328 > ./result_8chains/node163_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_4_0 -p 749 -st none -pt topic163_4_0 -u 0.014166821790113387 > ./result_8chains/node163_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_5_0 -p 812 -st none -pt topic163_5_0 -u 0.06010474009389949 > ./result_8chains/node163_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_6_0 -p 907 -st none -pt topic163_6_0 -u 0.031289599230679116 > ./result_8chains/node163_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_7_0 -p 992 -st none -pt topic163_7_0 -u 0.0021547267866664846 > ./result_8chains/node163_7_0.txt &
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
    "./result_8chains/node163_0_0.txt 90"
    "./result_8chains/node163_0_2.txt 90"
    "./result_8chains/node163_1_0.txt 89"
    "./result_8chains/node163_1_2.txt 89"
    "./result_8chains/node163_2_0.txt 88"
    "./result_8chains/node163_2_2.txt 88"
    "./result_8chains/node163_3_0.txt 87"
    "./result_8chains/node163_3_2.txt 87"
    "./result_8chains/node163_4_0.txt 86"
    "./result_8chains/node163_4_2.txt 86"
    "./result_8chains/node163_5_0.txt 85"
    "./result_8chains/node163_5_2.txt 85"
    "./result_8chains/node163_6_0.txt 84"
    "./result_8chains/node163_6_2.txt 84"
    "./result_8chains/node163_7_0.txt 83"
    "./result_8chains/node163_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
