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
ros2 run evaluation_3_randomdag uunifast_node -n node263_0_2 -p 504 -st topic263_0_1 -pt None -u 0.013407813649089939 > ./result_6chains/node263_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_1_2 -p 529 -st topic263_1_1 -pt None -u 0.027863534659567313 > ./result_6chains/node263_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_2_2 -p 531 -st topic263_2_1 -pt None -u 0.012949158854216325 > ./result_6chains/node263_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_3_2 -p 536 -st topic263_3_1 -pt None -u 0.029659800002927977 > ./result_6chains/node263_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_4_2 -p 755 -st topic263_4_1 -pt None -u 0.014292464009496672 > ./result_6chains/node263_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_5_2 -p 947 -st topic263_5_1 -pt None -u 0.03724704617470952 > ./result_6chains/node263_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_0_0 -p 504 -st none -pt topic263_0_0 -u 0.004480644209923446 > ./result_6chains/node263_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_1_0 -p 529 -st none -pt topic263_1_0 -u 0.05855399124271943 > ./result_6chains/node263_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_2_0 -p 531 -st none -pt topic263_2_0 -u 0.024694709324825204 > ./result_6chains/node263_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_3_0 -p 536 -st none -pt topic263_3_0 -u 0.031565992877332694 > ./result_6chains/node263_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_4_0 -p 755 -st none -pt topic263_4_0 -u 0.017167409845518955 > ./result_6chains/node263_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_5_0 -p 947 -st none -pt topic263_5_0 -u 0.00438602578582932 > ./result_6chains/node263_5_0.txt &
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
    "./result_6chains/node263_0_0.txt 90"
    "./result_6chains/node263_0_2.txt 90"
    "./result_6chains/node263_1_0.txt 89"
    "./result_6chains/node263_1_2.txt 89"
    "./result_6chains/node263_2_0.txt 88"
    "./result_6chains/node263_2_2.txt 88"
    "./result_6chains/node263_3_0.txt 87"
    "./result_6chains/node263_3_2.txt 87"
    "./result_6chains/node263_4_0.txt 86"
    "./result_6chains/node263_4_2.txt 86"
    "./result_6chains/node263_5_0.txt 85"
    "./result_6chains/node263_5_2.txt 85"
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
