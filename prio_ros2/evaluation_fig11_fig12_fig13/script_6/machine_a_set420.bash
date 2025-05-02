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
ros2 run evaluation_3_randomdag uunifast_node -n node420_0_2 -p 286 -st topic420_0_1 -pt None -u 0.057202091611906314 > ./result_6chains/node420_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_1_2 -p 499 -st topic420_1_1 -pt None -u 0.02705317871509874 > ./result_6chains/node420_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_2_2 -p 541 -st topic420_2_1 -pt None -u 0.040747610591592764 > ./result_6chains/node420_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_3_2 -p 548 -st topic420_3_1 -pt None -u 0.0008068506263231162 > ./result_6chains/node420_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_4_2 -p 631 -st topic420_4_1 -pt None -u 0.005895505089388506 > ./result_6chains/node420_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_5_2 -p 825 -st topic420_5_1 -pt None -u 0.008953380635334192 > ./result_6chains/node420_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_0_0 -p 286 -st none -pt topic420_0_0 -u 0.013341345140513494 > ./result_6chains/node420_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_1_0 -p 499 -st none -pt topic420_1_0 -u 0.015552480641765398 > ./result_6chains/node420_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_2_0 -p 541 -st none -pt topic420_2_0 -u 0.010384945401388124 > ./result_6chains/node420_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_3_0 -p 548 -st none -pt topic420_3_0 -u 0.0060791113025488175 > ./result_6chains/node420_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_4_0 -p 631 -st none -pt topic420_4_0 -u 0.017993732733788403 > ./result_6chains/node420_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_5_0 -p 825 -st none -pt topic420_5_0 -u 0.019571319223854675 > ./result_6chains/node420_5_0.txt &
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
    "./result_6chains/node420_0_0.txt 90"
    "./result_6chains/node420_0_2.txt 90"
    "./result_6chains/node420_1_0.txt 89"
    "./result_6chains/node420_1_2.txt 89"
    "./result_6chains/node420_2_0.txt 88"
    "./result_6chains/node420_2_2.txt 88"
    "./result_6chains/node420_3_0.txt 87"
    "./result_6chains/node420_3_2.txt 87"
    "./result_6chains/node420_4_0.txt 86"
    "./result_6chains/node420_4_2.txt 86"
    "./result_6chains/node420_5_0.txt 85"
    "./result_6chains/node420_5_2.txt 85"
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
