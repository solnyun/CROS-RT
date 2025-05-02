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
ros2 run evaluation_3_randomdag uunifast_node -n node304_0_1 -p 14 -st topic304_0_0 -pt topic304_0_1 -u 0.037464875195784564 > ./result_10chains/node304_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_1_1 -p 37 -st topic304_1_0 -pt topic304_1_1 -u 0.0060967912945233405 > ./result_10chains/node304_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_2_1 -p 62 -st topic304_2_0 -pt topic304_2_1 -u 0.01781381018905337 > ./result_10chains/node304_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_3_1 -p 178 -st topic304_3_0 -pt topic304_3_1 -u 0.002191370426842143 > ./result_10chains/node304_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_4_1 -p 233 -st topic304_4_0 -pt topic304_4_1 -u 0.01423848023768115 > ./result_10chains/node304_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_5_1 -p 332 -st topic304_5_0 -pt topic304_5_1 -u 0.004451969979318182 > ./result_10chains/node304_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_6_1 -p 345 -st topic304_6_0 -pt topic304_6_1 -u 0.003942075881232118 > ./result_10chains/node304_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_7_1 -p 570 -st topic304_7_0 -pt topic304_7_1 -u 0.007861144412278462 > ./result_10chains/node304_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_8_1 -p 613 -st topic304_8_0 -pt topic304_8_1 -u 0.00704037419641193 > ./result_10chains/node304_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_9_1 -p 646 -st topic304_9_0 -pt topic304_9_1 -u 0.025646572357672974 > ./result_10chains/node304_9_1.txt &
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
    "./result_10chains/node304_0_1.txt 90"
    "./result_10chains/node304_1_1.txt 89"
    "./result_10chains/node304_2_1.txt 88"
    "./result_10chains/node304_3_1.txt 87"
    "./result_10chains/node304_4_1.txt 86"
    "./result_10chains/node304_5_1.txt 85"
    "./result_10chains/node304_6_1.txt 84"
    "./result_10chains/node304_7_1.txt 83"
    "./result_10chains/node304_8_1.txt 82"
    "./result_10chains/node304_9_1.txt 81"
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
