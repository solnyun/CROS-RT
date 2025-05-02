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
ros2 run evaluation_3_randomdag uunifast_node -n node3_0_1 -p 15 -st topic3_0_0 -pt topic3_0_1 -u 0.008210139716235187 > ./result_8chains/node3_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node3_1_1 -p 42 -st topic3_1_0 -pt topic3_1_1 -u 0.026679429611439986 > ./result_8chains/node3_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node3_2_1 -p 50 -st topic3_2_0 -pt topic3_2_1 -u 0.0009735492685862268 > ./result_8chains/node3_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node3_3_1 -p 158 -st topic3_3_0 -pt topic3_3_1 -u 0.002040836106674049 > ./result_8chains/node3_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node3_4_1 -p 160 -st topic3_4_0 -pt topic3_4_1 -u 0.044278090360185235 > ./result_8chains/node3_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node3_5_1 -p 435 -st topic3_5_0 -pt topic3_5_1 -u 0.03253064467003142 > ./result_8chains/node3_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node3_6_1 -p 669 -st topic3_6_0 -pt topic3_6_1 -u 0.017473697578213904 > ./result_8chains/node3_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node3_7_1 -p 803 -st topic3_7_0 -pt topic3_7_1 -u 0.03900934450092629 > ./result_8chains/node3_7_1.txt &
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
    "./result_8chains/node3_0_1.txt 90"
    "./result_8chains/node3_1_1.txt 89"
    "./result_8chains/node3_2_1.txt 88"
    "./result_8chains/node3_3_1.txt 87"
    "./result_8chains/node3_4_1.txt 86"
    "./result_8chains/node3_5_1.txt 85"
    "./result_8chains/node3_6_1.txt 84"
    "./result_8chains/node3_7_1.txt 83"
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
