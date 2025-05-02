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
ros2 run evaluation_3_randomdag uunifast_node -n node282_0_2 -p 131 -st topic282_0_1 -pt None -u 0.09429370379642638 > ./result_6chains/node282_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_1_2 -p 254 -st topic282_1_1 -pt None -u 0.005777474893085777 > ./result_6chains/node282_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_2_2 -p 437 -st topic282_2_1 -pt None -u 0.008370624223330014 > ./result_6chains/node282_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_3_2 -p 696 -st topic282_3_1 -pt None -u 0.007176673648636084 > ./result_6chains/node282_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_4_2 -p 828 -st topic282_4_1 -pt None -u 0.0010114063263225864 > ./result_6chains/node282_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_5_2 -p 931 -st topic282_5_1 -pt None -u 0.024175132089974627 > ./result_6chains/node282_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_0_0 -p 131 -st none -pt topic282_0_0 -u 0.017176136783662255 > ./result_6chains/node282_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_1_0 -p 254 -st none -pt topic282_1_0 -u 0.01311473853510653 > ./result_6chains/node282_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_2_0 -p 437 -st none -pt topic282_2_0 -u 0.018939404860408737 > ./result_6chains/node282_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_3_0 -p 696 -st none -pt topic282_3_0 -u 0.07558048125249989 > ./result_6chains/node282_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_4_0 -p 828 -st none -pt topic282_4_0 -u 0.004312192901220646 > ./result_6chains/node282_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_5_0 -p 931 -st none -pt topic282_5_0 -u 0.007094103636431995 > ./result_6chains/node282_5_0.txt &
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
    "./result_6chains/node282_0_0.txt 90"
    "./result_6chains/node282_0_2.txt 90"
    "./result_6chains/node282_1_0.txt 89"
    "./result_6chains/node282_1_2.txt 89"
    "./result_6chains/node282_2_0.txt 88"
    "./result_6chains/node282_2_2.txt 88"
    "./result_6chains/node282_3_0.txt 87"
    "./result_6chains/node282_3_2.txt 87"
    "./result_6chains/node282_4_0.txt 86"
    "./result_6chains/node282_4_2.txt 86"
    "./result_6chains/node282_5_0.txt 85"
    "./result_6chains/node282_5_2.txt 85"
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
