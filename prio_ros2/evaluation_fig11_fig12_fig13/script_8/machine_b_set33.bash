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
ros2 run evaluation_3_randomdag uunifast_node -n node33_0_1 -p 257 -st topic33_0_0 -pt topic33_0_1 -u 0.0072062339232421 > ./result_8chains/node33_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node33_1_1 -p 683 -st topic33_1_0 -pt topic33_1_1 -u 0.06554126615564398 > ./result_8chains/node33_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node33_2_1 -p 705 -st topic33_2_0 -pt topic33_2_1 -u 0.005992926908696461 > ./result_8chains/node33_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node33_3_1 -p 709 -st topic33_3_0 -pt topic33_3_1 -u 0.018255582827202133 > ./result_8chains/node33_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node33_4_1 -p 836 -st topic33_4_0 -pt topic33_4_1 -u 0.012006316775990733 > ./result_8chains/node33_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node33_5_1 -p 858 -st topic33_5_0 -pt topic33_5_1 -u 0.004369425158952708 > ./result_8chains/node33_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node33_6_1 -p 990 -st topic33_6_0 -pt topic33_6_1 -u 0.010907969496521286 > ./result_8chains/node33_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node33_7_1 -p 997 -st topic33_7_0 -pt topic33_7_1 -u 0.018817434738232514 > ./result_8chains/node33_7_1.txt &
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
    "./result_8chains/node33_0_1.txt 90"
    "./result_8chains/node33_1_1.txt 89"
    "./result_8chains/node33_2_1.txt 88"
    "./result_8chains/node33_3_1.txt 87"
    "./result_8chains/node33_4_1.txt 86"
    "./result_8chains/node33_5_1.txt 85"
    "./result_8chains/node33_6_1.txt 84"
    "./result_8chains/node33_7_1.txt 83"
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
