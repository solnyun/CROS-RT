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
ros2 run evaluation_3_randomdag uunifast_node -n node349_0_1 -p 195 -st topic349_0_0 -pt topic349_0_1 -u 0.021117502736432592 > ./result_10chains/node349_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_1_1 -p 381 -st topic349_1_0 -pt topic349_1_1 -u 0.0011354838095668507 > ./result_10chains/node349_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_2_1 -p 390 -st topic349_2_0 -pt topic349_2_1 -u 0.006030388365183603 > ./result_10chains/node349_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_3_1 -p 404 -st topic349_3_0 -pt topic349_3_1 -u 0.03457051740555639 > ./result_10chains/node349_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_4_1 -p 567 -st topic349_4_0 -pt topic349_4_1 -u 0.0027798386452757007 > ./result_10chains/node349_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_5_1 -p 703 -st topic349_5_0 -pt topic349_5_1 -u 0.004404772007852109 > ./result_10chains/node349_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_6_1 -p 933 -st topic349_6_0 -pt topic349_6_1 -u 0.03995978241616871 > ./result_10chains/node349_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_7_1 -p 956 -st topic349_7_0 -pt topic349_7_1 -u 0.016573163610084388 > ./result_10chains/node349_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_8_1 -p 977 -st topic349_8_0 -pt topic349_8_1 -u 0.018342165654534157 > ./result_10chains/node349_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_9_1 -p 978 -st topic349_9_0 -pt topic349_9_1 -u 0.008995199472223641 > ./result_10chains/node349_9_1.txt &
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
    "./result_10chains/node349_0_1.txt 90"
    "./result_10chains/node349_1_1.txt 89"
    "./result_10chains/node349_2_1.txt 88"
    "./result_10chains/node349_3_1.txt 87"
    "./result_10chains/node349_4_1.txt 86"
    "./result_10chains/node349_5_1.txt 85"
    "./result_10chains/node349_6_1.txt 84"
    "./result_10chains/node349_7_1.txt 83"
    "./result_10chains/node349_8_1.txt 82"
    "./result_10chains/node349_9_1.txt 81"
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
