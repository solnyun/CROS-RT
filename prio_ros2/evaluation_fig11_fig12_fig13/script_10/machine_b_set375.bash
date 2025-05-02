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
ros2 run evaluation_3_randomdag uunifast_node -n node375_0_1 -p 36 -st topic375_0_0 -pt topic375_0_1 -u 0.035664631277050385 > ./result_10chains/node375_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_1_1 -p 94 -st topic375_1_0 -pt topic375_1_1 -u 0.004929022354875412 > ./result_10chains/node375_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_2_1 -p 239 -st topic375_2_0 -pt topic375_2_1 -u 0.018889029386462308 > ./result_10chains/node375_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_3_1 -p 306 -st topic375_3_0 -pt topic375_3_1 -u 0.0001879710167406179 > ./result_10chains/node375_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_4_1 -p 395 -st topic375_4_0 -pt topic375_4_1 -u 0.019491376444762232 > ./result_10chains/node375_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_5_1 -p 530 -st topic375_5_0 -pt topic375_5_1 -u 0.0799135897639244 > ./result_10chains/node375_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_6_1 -p 535 -st topic375_6_0 -pt topic375_6_1 -u 0.0011402284085989811 > ./result_10chains/node375_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_7_1 -p 672 -st topic375_7_0 -pt topic375_7_1 -u 0.022867691814837138 > ./result_10chains/node375_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_8_1 -p 687 -st topic375_8_0 -pt topic375_8_1 -u 0.024769189059312156 > ./result_10chains/node375_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_9_1 -p 941 -st topic375_9_0 -pt topic375_9_1 -u 0.011818038502834438 > ./result_10chains/node375_9_1.txt &
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
    "./result_10chains/node375_0_1.txt 90"
    "./result_10chains/node375_1_1.txt 89"
    "./result_10chains/node375_2_1.txt 88"
    "./result_10chains/node375_3_1.txt 87"
    "./result_10chains/node375_4_1.txt 86"
    "./result_10chains/node375_5_1.txt 85"
    "./result_10chains/node375_6_1.txt 84"
    "./result_10chains/node375_7_1.txt 83"
    "./result_10chains/node375_8_1.txt 82"
    "./result_10chains/node375_9_1.txt 81"
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
