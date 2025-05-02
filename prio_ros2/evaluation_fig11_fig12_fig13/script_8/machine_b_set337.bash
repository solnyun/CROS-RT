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
ros2 run evaluation_3_randomdag uunifast_node -n node337_0_1 -p 150 -st topic337_0_0 -pt topic337_0_1 -u 0.01499662464643764 > ./result_8chains/node337_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_1_1 -p 310 -st topic337_1_0 -pt topic337_1_1 -u 0.04758363762637702 > ./result_8chains/node337_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_2_1 -p 527 -st topic337_2_0 -pt topic337_2_1 -u 0.019079341397796823 > ./result_8chains/node337_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_3_1 -p 608 -st topic337_3_0 -pt topic337_3_1 -u 0.015451076716511192 > ./result_8chains/node337_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_4_1 -p 643 -st topic337_4_0 -pt topic337_4_1 -u 0.0148589303624658 > ./result_8chains/node337_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_5_1 -p 673 -st topic337_5_0 -pt topic337_5_1 -u 0.00022074474562067126 > ./result_8chains/node337_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_6_1 -p 739 -st topic337_6_0 -pt topic337_6_1 -u 0.008636143382705769 > ./result_8chains/node337_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_7_1 -p 817 -st topic337_7_0 -pt topic337_7_1 -u 0.06584773761009302 > ./result_8chains/node337_7_1.txt &
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
    "./result_8chains/node337_0_1.txt 90"
    "./result_8chains/node337_1_1.txt 89"
    "./result_8chains/node337_2_1.txt 88"
    "./result_8chains/node337_3_1.txt 87"
    "./result_8chains/node337_4_1.txt 86"
    "./result_8chains/node337_5_1.txt 85"
    "./result_8chains/node337_6_1.txt 84"
    "./result_8chains/node337_7_1.txt 83"
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
