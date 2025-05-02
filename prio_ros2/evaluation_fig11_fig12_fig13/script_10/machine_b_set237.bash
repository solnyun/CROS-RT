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
ros2 run evaluation_3_randomdag uunifast_node -n node237_0_1 -p 47 -st topic237_0_0 -pt topic237_0_1 -u 0.0010036856190648313 > ./result_10chains/node237_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_1_1 -p 72 -st topic237_1_0 -pt topic237_1_1 -u 0.00988940046552339 > ./result_10chains/node237_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_2_1 -p 130 -st topic237_2_0 -pt topic237_2_1 -u 0.009602044838065316 > ./result_10chains/node237_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_3_1 -p 220 -st topic237_3_0 -pt topic237_3_1 -u 0.007358067290380577 > ./result_10chains/node237_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_4_1 -p 242 -st topic237_4_0 -pt topic237_4_1 -u 0.04392423563014364 > ./result_10chains/node237_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_5_1 -p 271 -st topic237_5_0 -pt topic237_5_1 -u 0.02047763520320281 > ./result_10chains/node237_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_6_1 -p 508 -st topic237_6_0 -pt topic237_6_1 -u 0.001287968074661916 > ./result_10chains/node237_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_7_1 -p 516 -st topic237_7_0 -pt topic237_7_1 -u 0.019984145839657394 > ./result_10chains/node237_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_8_1 -p 881 -st topic237_8_0 -pt topic237_8_1 -u 0.0005628660440713251 > ./result_10chains/node237_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_9_1 -p 919 -st topic237_9_0 -pt topic237_9_1 -u 0.01824191423665799 > ./result_10chains/node237_9_1.txt &
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
    "./result_10chains/node237_0_1.txt 90"
    "./result_10chains/node237_1_1.txt 89"
    "./result_10chains/node237_2_1.txt 88"
    "./result_10chains/node237_3_1.txt 87"
    "./result_10chains/node237_4_1.txt 86"
    "./result_10chains/node237_5_1.txt 85"
    "./result_10chains/node237_6_1.txt 84"
    "./result_10chains/node237_7_1.txt 83"
    "./result_10chains/node237_8_1.txt 82"
    "./result_10chains/node237_9_1.txt 81"
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
