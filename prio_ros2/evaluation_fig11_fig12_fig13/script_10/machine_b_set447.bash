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
ros2 run evaluation_3_randomdag uunifast_node -n node447_0_1 -p 37 -st topic447_0_0 -pt topic447_0_1 -u 0.0022112594877856107 > ./result_10chains/node447_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_1_1 -p 40 -st topic447_1_0 -pt topic447_1_1 -u 0.024269027221574757 > ./result_10chains/node447_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_2_1 -p 41 -st topic447_2_0 -pt topic447_2_1 -u 0.02092607573910854 > ./result_10chains/node447_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_3_1 -p 251 -st topic447_3_0 -pt topic447_3_1 -u 0.00457899167285325 > ./result_10chains/node447_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_4_1 -p 302 -st topic447_4_0 -pt topic447_4_1 -u 0.016047613350935325 > ./result_10chains/node447_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_5_1 -p 408 -st topic447_5_0 -pt topic447_5_1 -u 0.026540303647805796 > ./result_10chains/node447_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_6_1 -p 578 -st topic447_6_0 -pt topic447_6_1 -u 0.01348098391668423 > ./result_10chains/node447_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_7_1 -p 631 -st topic447_7_0 -pt topic447_7_1 -u 0.0019041308144169128 > ./result_10chains/node447_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_8_1 -p 696 -st topic447_8_0 -pt topic447_8_1 -u 0.006020758704548261 > ./result_10chains/node447_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_9_1 -p 744 -st topic447_9_0 -pt topic447_9_1 -u 0.02764351700455967 > ./result_10chains/node447_9_1.txt &
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
    "./result_10chains/node447_0_1.txt 90"
    "./result_10chains/node447_1_1.txt 89"
    "./result_10chains/node447_2_1.txt 88"
    "./result_10chains/node447_3_1.txt 87"
    "./result_10chains/node447_4_1.txt 86"
    "./result_10chains/node447_5_1.txt 85"
    "./result_10chains/node447_6_1.txt 84"
    "./result_10chains/node447_7_1.txt 83"
    "./result_10chains/node447_8_1.txt 82"
    "./result_10chains/node447_9_1.txt 81"
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
