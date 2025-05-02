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
ros2 run evaluation_3_randomdag uunifast_node -n node14_0_1 -p 82 -st topic14_0_0 -pt topic14_0_1 -u 0.00023804312341724199 > ./result_10chains/node14_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node14_1_1 -p 311 -st topic14_1_0 -pt topic14_1_1 -u 0.015488363523821769 > ./result_10chains/node14_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node14_2_1 -p 329 -st topic14_2_0 -pt topic14_2_1 -u 0.004844945894754593 > ./result_10chains/node14_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node14_3_1 -p 523 -st topic14_3_0 -pt topic14_3_1 -u 0.00966221357451752 > ./result_10chains/node14_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node14_4_1 -p 573 -st topic14_4_0 -pt topic14_4_1 -u 0.017090649069755492 > ./result_10chains/node14_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node14_5_1 -p 766 -st topic14_5_0 -pt topic14_5_1 -u 0.015478716818397686 > ./result_10chains/node14_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node14_6_1 -p 837 -st topic14_6_0 -pt topic14_6_1 -u 0.0014616454663101686 > ./result_10chains/node14_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node14_7_1 -p 840 -st topic14_7_0 -pt topic14_7_1 -u 0.083563555052141 > ./result_10chains/node14_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node14_8_1 -p 930 -st topic14_8_0 -pt topic14_8_1 -u 0.014314548180127062 > ./result_10chains/node14_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node14_9_1 -p 932 -st topic14_9_0 -pt topic14_9_1 -u 0.0007524193743571814 > ./result_10chains/node14_9_1.txt &
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
    "./result_10chains/node14_0_1.txt 90"
    "./result_10chains/node14_1_1.txt 89"
    "./result_10chains/node14_2_1.txt 88"
    "./result_10chains/node14_3_1.txt 87"
    "./result_10chains/node14_4_1.txt 86"
    "./result_10chains/node14_5_1.txt 85"
    "./result_10chains/node14_6_1.txt 84"
    "./result_10chains/node14_7_1.txt 83"
    "./result_10chains/node14_8_1.txt 82"
    "./result_10chains/node14_9_1.txt 81"
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
