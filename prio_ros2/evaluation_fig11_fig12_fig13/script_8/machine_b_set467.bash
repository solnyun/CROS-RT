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
ros2 run evaluation_3_randomdag uunifast_node -n node467_0_1 -p 78 -st topic467_0_0 -pt topic467_0_1 -u 0.004154359519258577 > ./result_8chains/node467_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_1_1 -p 92 -st topic467_1_0 -pt topic467_1_1 -u 0.011313713185515772 > ./result_8chains/node467_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_2_1 -p 230 -st topic467_2_0 -pt topic467_2_1 -u 0.004555955365565578 > ./result_8chains/node467_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_3_1 -p 284 -st topic467_3_0 -pt topic467_3_1 -u 0.015643843563227455 > ./result_8chains/node467_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_4_1 -p 431 -st topic467_4_0 -pt topic467_4_1 -u 0.02472540362072076 > ./result_8chains/node467_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_5_1 -p 580 -st topic467_5_0 -pt topic467_5_1 -u 0.018556847970016527 > ./result_8chains/node467_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_6_1 -p 582 -st topic467_6_0 -pt topic467_6_1 -u 0.016328999727416943 > ./result_8chains/node467_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_7_1 -p 855 -st topic467_7_0 -pt topic467_7_1 -u 0.010381217236506615 > ./result_8chains/node467_7_1.txt &
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
    "./result_8chains/node467_0_1.txt 90"
    "./result_8chains/node467_1_1.txt 89"
    "./result_8chains/node467_2_1.txt 88"
    "./result_8chains/node467_3_1.txt 87"
    "./result_8chains/node467_4_1.txt 86"
    "./result_8chains/node467_5_1.txt 85"
    "./result_8chains/node467_6_1.txt 84"
    "./result_8chains/node467_7_1.txt 83"
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
