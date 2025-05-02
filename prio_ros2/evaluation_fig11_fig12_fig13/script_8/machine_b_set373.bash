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
ros2 run evaluation_3_randomdag uunifast_node -n node373_0_1 -p 160 -st topic373_0_0 -pt topic373_0_1 -u 0.03736982909698433 > ./result_8chains/node373_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_1_1 -p 291 -st topic373_1_0 -pt topic373_1_1 -u 0.01673316178767431 > ./result_8chains/node373_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_2_1 -p 318 -st topic373_2_0 -pt topic373_2_1 -u 0.003932811188678664 > ./result_8chains/node373_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_3_1 -p 485 -st topic373_3_0 -pt topic373_3_1 -u 0.049587388622749196 > ./result_8chains/node373_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_4_1 -p 696 -st topic373_4_0 -pt topic373_4_1 -u 0.03778558833948026 > ./result_8chains/node373_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_5_1 -p 869 -st topic373_5_0 -pt topic373_5_1 -u 0.00484730188618121 > ./result_8chains/node373_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_6_1 -p 928 -st topic373_6_0 -pt topic373_6_1 -u 0.024402325019317092 > ./result_8chains/node373_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_7_1 -p 983 -st topic373_7_0 -pt topic373_7_1 -u 0.0028391289379502225 > ./result_8chains/node373_7_1.txt &
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
    "./result_8chains/node373_0_1.txt 90"
    "./result_8chains/node373_1_1.txt 89"
    "./result_8chains/node373_2_1.txt 88"
    "./result_8chains/node373_3_1.txt 87"
    "./result_8chains/node373_4_1.txt 86"
    "./result_8chains/node373_5_1.txt 85"
    "./result_8chains/node373_6_1.txt 84"
    "./result_8chains/node373_7_1.txt 83"
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
