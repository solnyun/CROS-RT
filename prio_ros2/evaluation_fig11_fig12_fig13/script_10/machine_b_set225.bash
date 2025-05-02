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
ros2 run evaluation_3_randomdag uunifast_node -n node225_0_1 -p 119 -st topic225_0_0 -pt topic225_0_1 -u 0.04541747336181012 > ./result_10chains/node225_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_1_1 -p 239 -st topic225_1_0 -pt topic225_1_1 -u 0.03194512391822257 > ./result_10chains/node225_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_2_1 -p 254 -st topic225_2_0 -pt topic225_2_1 -u 0.019845865111127736 > ./result_10chains/node225_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_3_1 -p 257 -st topic225_3_0 -pt topic225_3_1 -u 0.017196109169872242 > ./result_10chains/node225_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_4_1 -p 423 -st topic225_4_0 -pt topic225_4_1 -u 0.010719797806686748 > ./result_10chains/node225_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_5_1 -p 592 -st topic225_5_0 -pt topic225_5_1 -u 0.00769630789693973 > ./result_10chains/node225_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_6_1 -p 640 -st topic225_6_0 -pt topic225_6_1 -u 0.0553529194281433 > ./result_10chains/node225_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_7_1 -p 839 -st topic225_7_0 -pt topic225_7_1 -u 0.0023892501749514378 > ./result_10chains/node225_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_8_1 -p 850 -st topic225_8_0 -pt topic225_8_1 -u 0.002602753748338099 > ./result_10chains/node225_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_9_1 -p 882 -st topic225_9_0 -pt topic225_9_1 -u 0.007656047379003564 > ./result_10chains/node225_9_1.txt &
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
    "./result_10chains/node225_0_1.txt 90"
    "./result_10chains/node225_1_1.txt 89"
    "./result_10chains/node225_2_1.txt 88"
    "./result_10chains/node225_3_1.txt 87"
    "./result_10chains/node225_4_1.txt 86"
    "./result_10chains/node225_5_1.txt 85"
    "./result_10chains/node225_6_1.txt 84"
    "./result_10chains/node225_7_1.txt 83"
    "./result_10chains/node225_8_1.txt 82"
    "./result_10chains/node225_9_1.txt 81"
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
