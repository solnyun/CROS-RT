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
ros2 run evaluation_3_randomdag uunifast_node -n node425_0_2 -p 255 -st topic425_0_1 -pt None -u 0.008986051169136977 > ./result_6chains/node425_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_1_2 -p 536 -st topic425_1_1 -pt None -u 0.02475213385023428 > ./result_6chains/node425_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_2_2 -p 581 -st topic425_2_1 -pt None -u 0.0024693350980268813 > ./result_6chains/node425_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_3_2 -p 781 -st topic425_3_1 -pt None -u 0.027581975872632877 > ./result_6chains/node425_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_4_2 -p 861 -st topic425_4_1 -pt None -u 0.04634820676452951 > ./result_6chains/node425_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_5_2 -p 928 -st topic425_5_1 -pt None -u 0.002307697532334633 > ./result_6chains/node425_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_0_0 -p 255 -st none -pt topic425_0_0 -u 0.034652143365082044 > ./result_6chains/node425_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_1_0 -p 536 -st none -pt topic425_1_0 -u 0.0663305147944857 > ./result_6chains/node425_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_2_0 -p 581 -st none -pt topic425_2_0 -u 0.09793358799155247 > ./result_6chains/node425_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_3_0 -p 781 -st none -pt topic425_3_0 -u 0.018499952817064458 > ./result_6chains/node425_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_4_0 -p 861 -st none -pt topic425_4_0 -u 0.029873860991020074 > ./result_6chains/node425_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_5_0 -p 928 -st none -pt topic425_5_0 -u 0.018915195406093845 > ./result_6chains/node425_5_0.txt &
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
    "./result_6chains/node425_0_0.txt 90"
    "./result_6chains/node425_0_2.txt 90"
    "./result_6chains/node425_1_0.txt 89"
    "./result_6chains/node425_1_2.txt 89"
    "./result_6chains/node425_2_0.txt 88"
    "./result_6chains/node425_2_2.txt 88"
    "./result_6chains/node425_3_0.txt 87"
    "./result_6chains/node425_3_2.txt 87"
    "./result_6chains/node425_4_0.txt 86"
    "./result_6chains/node425_4_2.txt 86"
    "./result_6chains/node425_5_0.txt 85"
    "./result_6chains/node425_5_2.txt 85"
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
