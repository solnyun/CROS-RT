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
ros2 run evaluation_3_randomdag uunifast_node -n node460_0_2 -p 245 -st topic460_0_1 -pt None -u 0.035274703888013736 > ./result_6chains/node460_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_1_2 -p 366 -st topic460_1_1 -pt None -u 0.06093564607182389 > ./result_6chains/node460_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_2_2 -p 628 -st topic460_2_1 -pt None -u 0.029754391066107527 > ./result_6chains/node460_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_3_2 -p 638 -st topic460_3_1 -pt None -u 0.003490621595359511 > ./result_6chains/node460_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_4_2 -p 895 -st topic460_4_1 -pt None -u 0.025184187213075873 > ./result_6chains/node460_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_5_2 -p 957 -st topic460_5_1 -pt None -u 0.07129318522379322 > ./result_6chains/node460_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_0_0 -p 245 -st none -pt topic460_0_0 -u 0.02908060314158606 > ./result_6chains/node460_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_1_0 -p 366 -st none -pt topic460_1_0 -u 0.035650776108990534 > ./result_6chains/node460_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_2_0 -p 628 -st none -pt topic460_2_0 -u 0.0075383455525593335 > ./result_6chains/node460_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_3_0 -p 638 -st none -pt topic460_3_0 -u 0.05923562567917304 > ./result_6chains/node460_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_4_0 -p 895 -st none -pt topic460_4_0 -u 0.0016467190313002866 > ./result_6chains/node460_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_5_0 -p 957 -st none -pt topic460_5_0 -u 0.017596818126854194 > ./result_6chains/node460_5_0.txt &
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
    "./result_6chains/node460_0_0.txt 90"
    "./result_6chains/node460_0_2.txt 90"
    "./result_6chains/node460_1_0.txt 89"
    "./result_6chains/node460_1_2.txt 89"
    "./result_6chains/node460_2_0.txt 88"
    "./result_6chains/node460_2_2.txt 88"
    "./result_6chains/node460_3_0.txt 87"
    "./result_6chains/node460_3_2.txt 87"
    "./result_6chains/node460_4_0.txt 86"
    "./result_6chains/node460_4_2.txt 86"
    "./result_6chains/node460_5_0.txt 85"
    "./result_6chains/node460_5_2.txt 85"
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
