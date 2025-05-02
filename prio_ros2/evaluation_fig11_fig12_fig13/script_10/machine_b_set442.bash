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
ros2 run evaluation_3_randomdag uunifast_node -n node442_0_1 -p 255 -st topic442_0_0 -pt topic442_0_1 -u 0.030840210801324264 > ./result_10chains/node442_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_1_1 -p 459 -st topic442_1_0 -pt topic442_1_1 -u 0.0013404907865354754 > ./result_10chains/node442_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_2_1 -p 630 -st topic442_2_0 -pt topic442_2_1 -u 0.03811153302107867 > ./result_10chains/node442_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_3_1 -p 645 -st topic442_3_0 -pt topic442_3_1 -u 0.007123034742435197 > ./result_10chains/node442_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_4_1 -p 666 -st topic442_4_0 -pt topic442_4_1 -u 0.012626632485184697 > ./result_10chains/node442_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_5_1 -p 812 -st topic442_5_0 -pt topic442_5_1 -u 0.01506984225728028 > ./result_10chains/node442_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_6_1 -p 860 -st topic442_6_0 -pt topic442_6_1 -u 0.0044456558372754085 > ./result_10chains/node442_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_7_1 -p 886 -st topic442_7_0 -pt topic442_7_1 -u 0.0047153532091968875 > ./result_10chains/node442_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_8_1 -p 976 -st topic442_8_0 -pt topic442_8_1 -u 0.04589757703962275 > ./result_10chains/node442_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_9_1 -p 999 -st topic442_9_0 -pt topic442_9_1 -u 0.01674949081042961 > ./result_10chains/node442_9_1.txt &
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
    "./result_10chains/node442_0_1.txt 90"
    "./result_10chains/node442_1_1.txt 89"
    "./result_10chains/node442_2_1.txt 88"
    "./result_10chains/node442_3_1.txt 87"
    "./result_10chains/node442_4_1.txt 86"
    "./result_10chains/node442_5_1.txt 85"
    "./result_10chains/node442_6_1.txt 84"
    "./result_10chains/node442_7_1.txt 83"
    "./result_10chains/node442_8_1.txt 82"
    "./result_10chains/node442_9_1.txt 81"
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
