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
ros2 run evaluation_3_randomdag uunifast_node -n node282_0_1 -p 60 -st topic282_0_0 -pt topic282_0_1 -u 0.0019826528901271123 > ./result_10chains/node282_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_1_1 -p 99 -st topic282_1_0 -pt topic282_1_1 -u 0.0166875285094345 > ./result_10chains/node282_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_2_1 -p 255 -st topic282_2_0 -pt topic282_2_1 -u 0.002661992173390859 > ./result_10chains/node282_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_3_1 -p 289 -st topic282_3_0 -pt topic282_3_1 -u 0.003621913146224509 > ./result_10chains/node282_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_4_1 -p 331 -st topic282_4_0 -pt topic282_4_1 -u 0.0041442153564609785 > ./result_10chains/node282_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_5_1 -p 567 -st topic282_5_0 -pt topic282_5_1 -u 0.018226217423796737 > ./result_10chains/node282_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_6_1 -p 623 -st topic282_6_0 -pt topic282_6_1 -u 0.013034325556341403 > ./result_10chains/node282_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_7_1 -p 811 -st topic282_7_0 -pt topic282_7_1 -u 0.006606463313333116 > ./result_10chains/node282_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_8_1 -p 854 -st topic282_8_0 -pt topic282_8_1 -u 0.001928795410571893 > ./result_10chains/node282_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_9_1 -p 918 -st topic282_9_0 -pt topic282_9_1 -u 0.028745659037259473 > ./result_10chains/node282_9_1.txt &
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
    "./result_10chains/node282_0_1.txt 90"
    "./result_10chains/node282_1_1.txt 89"
    "./result_10chains/node282_2_1.txt 88"
    "./result_10chains/node282_3_1.txt 87"
    "./result_10chains/node282_4_1.txt 86"
    "./result_10chains/node282_5_1.txt 85"
    "./result_10chains/node282_6_1.txt 84"
    "./result_10chains/node282_7_1.txt 83"
    "./result_10chains/node282_8_1.txt 82"
    "./result_10chains/node282_9_1.txt 81"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
