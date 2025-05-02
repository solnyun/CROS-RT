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
ros2 run evaluation_3_randomdag uunifast_node -n node437_0_2 -p 135 -st topic437_0_1 -pt None -u 0.013148019754217588 > ./result_6chains/node437_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_1_2 -p 370 -st topic437_1_1 -pt None -u 0.008732223401938743 > ./result_6chains/node437_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_2_2 -p 394 -st topic437_2_1 -pt None -u 0.023189778067615296 > ./result_6chains/node437_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_3_2 -p 443 -st topic437_3_1 -pt None -u 0.04566764817785263 > ./result_6chains/node437_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_4_2 -p 903 -st topic437_4_1 -pt None -u 0.03851034748137692 > ./result_6chains/node437_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_5_2 -p 952 -st topic437_5_1 -pt None -u 0.009330643621002346 > ./result_6chains/node437_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_0_0 -p 135 -st none -pt topic437_0_0 -u 0.014662165518744108 > ./result_6chains/node437_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_1_0 -p 370 -st none -pt topic437_1_0 -u 0.02513828385251865 > ./result_6chains/node437_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_2_0 -p 394 -st none -pt topic437_2_0 -u 0.03561713001210115 > ./result_6chains/node437_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_3_0 -p 443 -st none -pt topic437_3_0 -u 0.18070673401660495 > ./result_6chains/node437_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_4_0 -p 903 -st none -pt topic437_4_0 -u 0.04780526132620588 > ./result_6chains/node437_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_5_0 -p 952 -st none -pt topic437_5_0 -u 0.02904836330696864 > ./result_6chains/node437_5_0.txt &
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
    "./result_6chains/node437_0_0.txt 90"
    "./result_6chains/node437_0_2.txt 90"
    "./result_6chains/node437_1_0.txt 89"
    "./result_6chains/node437_1_2.txt 89"
    "./result_6chains/node437_2_0.txt 88"
    "./result_6chains/node437_2_2.txt 88"
    "./result_6chains/node437_3_0.txt 87"
    "./result_6chains/node437_3_2.txt 87"
    "./result_6chains/node437_4_0.txt 86"
    "./result_6chains/node437_4_2.txt 86"
    "./result_6chains/node437_5_0.txt 85"
    "./result_6chains/node437_5_2.txt 85"
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
