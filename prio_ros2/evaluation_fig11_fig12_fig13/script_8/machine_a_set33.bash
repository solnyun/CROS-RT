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
ros2 run evaluation_3_randomdag uunifast_node -n node33_0_2 -p 257 -st topic33_0_1 -pt None -u 0.02000329655073213 > ./result_8chains/node33_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node33_1_2 -p 683 -st topic33_1_1 -pt None -u 0.013937664772150193 > ./result_8chains/node33_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node33_2_2 -p 705 -st topic33_2_1 -pt None -u 0.002803712001371639 > ./result_8chains/node33_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node33_3_2 -p 709 -st topic33_3_1 -pt None -u 0.015571142653818398 > ./result_8chains/node33_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node33_4_2 -p 836 -st topic33_4_1 -pt None -u 0.0031403802182832508 > ./result_8chains/node33_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node33_5_2 -p 858 -st topic33_5_1 -pt None -u 0.015160425649004647 > ./result_8chains/node33_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node33_6_2 -p 990 -st topic33_6_1 -pt None -u 0.013642720244043019 > ./result_8chains/node33_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node33_7_2 -p 997 -st topic33_7_1 -pt None -u 0.03040075337754382 > ./result_8chains/node33_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node33_0_0 -p 257 -st none -pt topic33_0_0 -u 0.00722483251819539 > ./result_8chains/node33_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node33_1_0 -p 683 -st none -pt topic33_1_0 -u 0.04865327060674823 > ./result_8chains/node33_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node33_2_0 -p 705 -st none -pt topic33_2_0 -u 0.027718785266398926 > ./result_8chains/node33_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node33_3_0 -p 709 -st none -pt topic33_3_0 -u 0.049188418362657804 > ./result_8chains/node33_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node33_4_0 -p 836 -st none -pt topic33_4_0 -u 0.012295250623358178 > ./result_8chains/node33_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node33_5_0 -p 858 -st none -pt topic33_5_0 -u 0.06213003485026833 > ./result_8chains/node33_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node33_6_0 -p 990 -st none -pt topic33_6_0 -u 0.003313683253300559 > ./result_8chains/node33_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node33_7_0 -p 997 -st none -pt topic33_7_0 -u 0.03171847306764356 > ./result_8chains/node33_7_0.txt &
sleep 10
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
    "./result_8chains/node33_0_0.txt 90"
    "./result_8chains/node33_0_2.txt 90"
    "./result_8chains/node33_1_0.txt 89"
    "./result_8chains/node33_1_2.txt 89"
    "./result_8chains/node33_2_0.txt 88"
    "./result_8chains/node33_2_2.txt 88"
    "./result_8chains/node33_3_0.txt 87"
    "./result_8chains/node33_3_2.txt 87"
    "./result_8chains/node33_4_0.txt 86"
    "./result_8chains/node33_4_2.txt 86"
    "./result_8chains/node33_5_0.txt 85"
    "./result_8chains/node33_5_2.txt 85"
    "./result_8chains/node33_6_0.txt 84"
    "./result_8chains/node33_6_2.txt 84"
    "./result_8chains/node33_7_0.txt 83"
    "./result_8chains/node33_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
