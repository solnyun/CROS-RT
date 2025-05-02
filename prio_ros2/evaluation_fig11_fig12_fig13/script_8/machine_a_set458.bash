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
ros2 run evaluation_3_randomdag uunifast_node -n node458_0_2 -p 31 -st topic458_0_1 -pt None -u 0.029374433342723605 > ./result_8chains/node458_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_1_2 -p 42 -st topic458_1_1 -pt None -u 0.012431569884359783 > ./result_8chains/node458_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_2_2 -p 46 -st topic458_2_1 -pt None -u 0.009957046474155795 > ./result_8chains/node458_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_3_2 -p 122 -st topic458_3_1 -pt None -u 0.015106780668251163 > ./result_8chains/node458_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_4_2 -p 283 -st topic458_4_1 -pt None -u 0.07613689848073749 > ./result_8chains/node458_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_5_2 -p 368 -st topic458_5_1 -pt None -u 0.012627601566370966 > ./result_8chains/node458_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_6_2 -p 698 -st topic458_6_1 -pt None -u 0.007197205504537972 > ./result_8chains/node458_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_7_2 -p 813 -st topic458_7_1 -pt None -u 0.020746699656274643 > ./result_8chains/node458_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_0_0 -p 31 -st none -pt topic458_0_0 -u 0.026481513572306048 > ./result_8chains/node458_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_1_0 -p 42 -st none -pt topic458_1_0 -u 0.026680202386264895 > ./result_8chains/node458_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_2_0 -p 46 -st none -pt topic458_2_0 -u 0.007169519908413913 > ./result_8chains/node458_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_3_0 -p 122 -st none -pt topic458_3_0 -u 0.005435784212914352 > ./result_8chains/node458_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_4_0 -p 283 -st none -pt topic458_4_0 -u 0.013567162391783072 > ./result_8chains/node458_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_5_0 -p 368 -st none -pt topic458_5_0 -u 0.06580662089255113 > ./result_8chains/node458_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_6_0 -p 698 -st none -pt topic458_6_0 -u 0.010763223285086235 > ./result_8chains/node458_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_7_0 -p 813 -st none -pt topic458_7_0 -u 0.019633133529601915 > ./result_8chains/node458_7_0.txt &
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
    "./result_8chains/node458_0_0.txt 90"
    "./result_8chains/node458_0_2.txt 90"
    "./result_8chains/node458_1_0.txt 89"
    "./result_8chains/node458_1_2.txt 89"
    "./result_8chains/node458_2_0.txt 88"
    "./result_8chains/node458_2_2.txt 88"
    "./result_8chains/node458_3_0.txt 87"
    "./result_8chains/node458_3_2.txt 87"
    "./result_8chains/node458_4_0.txt 86"
    "./result_8chains/node458_4_2.txt 86"
    "./result_8chains/node458_5_0.txt 85"
    "./result_8chains/node458_5_2.txt 85"
    "./result_8chains/node458_6_0.txt 84"
    "./result_8chains/node458_6_2.txt 84"
    "./result_8chains/node458_7_0.txt 83"
    "./result_8chains/node458_7_2.txt 83"
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
