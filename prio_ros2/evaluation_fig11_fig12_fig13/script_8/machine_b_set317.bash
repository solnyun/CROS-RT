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
ros2 run evaluation_3_randomdag uunifast_node -n node317_0_1 -p 36 -st topic317_0_0 -pt topic317_0_1 -u 0.04049741833205739 > ./result_8chains/node317_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_1_1 -p 82 -st topic317_1_0 -pt topic317_1_1 -u 0.0012480909494283488 > ./result_8chains/node317_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_2_1 -p 214 -st topic317_2_0 -pt topic317_2_1 -u 0.03524176076574986 > ./result_8chains/node317_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_3_1 -p 232 -st topic317_3_0 -pt topic317_3_1 -u 0.020558003353729704 > ./result_8chains/node317_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_4_1 -p 359 -st topic317_4_0 -pt topic317_4_1 -u 0.00729776070082605 > ./result_8chains/node317_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_5_1 -p 601 -st topic317_5_0 -pt topic317_5_1 -u 0.013802294028546214 > ./result_8chains/node317_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_6_1 -p 813 -st topic317_6_0 -pt topic317_6_1 -u 0.05424875826004441 > ./result_8chains/node317_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_7_1 -p 985 -st topic317_7_0 -pt topic317_7_1 -u 0.00878055267154979 > ./result_8chains/node317_7_1.txt &
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
    "./result_8chains/node317_0_1.txt 90"
    "./result_8chains/node317_1_1.txt 89"
    "./result_8chains/node317_2_1.txt 88"
    "./result_8chains/node317_3_1.txt 87"
    "./result_8chains/node317_4_1.txt 86"
    "./result_8chains/node317_5_1.txt 85"
    "./result_8chains/node317_6_1.txt 84"
    "./result_8chains/node317_7_1.txt 83"
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
