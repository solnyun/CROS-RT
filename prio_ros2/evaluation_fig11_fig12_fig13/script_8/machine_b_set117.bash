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
ros2 run evaluation_3_randomdag uunifast_node -n node117_0_1 -p 289 -st topic117_0_0 -pt topic117_0_1 -u 0.004254541989311855 > ./result_8chains/node117_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_1_1 -p 442 -st topic117_1_0 -pt topic117_1_1 -u 0.014207537715215102 > ./result_8chains/node117_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_2_1 -p 541 -st topic117_2_0 -pt topic117_2_1 -u 0.0040187136284629554 > ./result_8chains/node117_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_3_1 -p 542 -st topic117_3_0 -pt topic117_3_1 -u 0.01537888293662959 > ./result_8chains/node117_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_4_1 -p 602 -st topic117_4_0 -pt topic117_4_1 -u 0.0066584444750425464 > ./result_8chains/node117_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_5_1 -p 716 -st topic117_5_0 -pt topic117_5_1 -u 0.03812916087494572 > ./result_8chains/node117_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_6_1 -p 855 -st topic117_6_0 -pt topic117_6_1 -u 0.05261249225697932 > ./result_8chains/node117_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_7_1 -p 873 -st topic117_7_0 -pt topic117_7_1 -u 0.008255398484316613 > ./result_8chains/node117_7_1.txt &
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
    "./result_8chains/node117_0_1.txt 90"
    "./result_8chains/node117_1_1.txt 89"
    "./result_8chains/node117_2_1.txt 88"
    "./result_8chains/node117_3_1.txt 87"
    "./result_8chains/node117_4_1.txt 86"
    "./result_8chains/node117_5_1.txt 85"
    "./result_8chains/node117_6_1.txt 84"
    "./result_8chains/node117_7_1.txt 83"
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
