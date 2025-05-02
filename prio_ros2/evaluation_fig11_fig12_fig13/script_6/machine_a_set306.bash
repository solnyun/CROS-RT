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
ros2 run evaluation_3_randomdag uunifast_node -n node306_0_2 -p 245 -st topic306_0_1 -pt None -u 0.011906204640734497 > ./result_6chains/node306_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_1_2 -p 334 -st topic306_1_1 -pt None -u 0.01318830768378687 > ./result_6chains/node306_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_2_2 -p 450 -st topic306_2_1 -pt None -u 0.03596852222413721 > ./result_6chains/node306_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_3_2 -p 463 -st topic306_3_1 -pt None -u 0.02301947461408757 > ./result_6chains/node306_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_4_2 -p 550 -st topic306_4_1 -pt None -u 0.0509928938007468 > ./result_6chains/node306_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_5_2 -p 947 -st topic306_5_1 -pt None -u 0.02099243717199275 > ./result_6chains/node306_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_0_0 -p 245 -st none -pt topic306_0_0 -u 0.02579798822211682 > ./result_6chains/node306_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_1_0 -p 334 -st none -pt topic306_1_0 -u 0.006366765284034792 > ./result_6chains/node306_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_2_0 -p 450 -st none -pt topic306_2_0 -u 0.02159859744509257 > ./result_6chains/node306_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_3_0 -p 463 -st none -pt topic306_3_0 -u 0.020550250914030455 > ./result_6chains/node306_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_4_0 -p 550 -st none -pt topic306_4_0 -u 0.02647443477893971 > ./result_6chains/node306_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_5_0 -p 947 -st none -pt topic306_5_0 -u 0.014405141435194918 > ./result_6chains/node306_5_0.txt &
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
    "./result_6chains/node306_0_0.txt 90"
    "./result_6chains/node306_0_2.txt 90"
    "./result_6chains/node306_1_0.txt 89"
    "./result_6chains/node306_1_2.txt 89"
    "./result_6chains/node306_2_0.txt 88"
    "./result_6chains/node306_2_2.txt 88"
    "./result_6chains/node306_3_0.txt 87"
    "./result_6chains/node306_3_2.txt 87"
    "./result_6chains/node306_4_0.txt 86"
    "./result_6chains/node306_4_2.txt 86"
    "./result_6chains/node306_5_0.txt 85"
    "./result_6chains/node306_5_2.txt 85"
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
