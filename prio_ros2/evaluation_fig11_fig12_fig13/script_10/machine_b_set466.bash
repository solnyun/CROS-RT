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
ros2 run evaluation_3_randomdag uunifast_node -n node466_0_1 -p 32 -st topic466_0_0 -pt topic466_0_1 -u 0.0005227080203388801 > ./result_10chains/node466_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_1_1 -p 80 -st topic466_1_0 -pt topic466_1_1 -u 0.018620098956050324 > ./result_10chains/node466_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_2_1 -p 168 -st topic466_2_0 -pt topic466_2_1 -u 0.009858528227224883 > ./result_10chains/node466_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_3_1 -p 384 -st topic466_3_0 -pt topic466_3_1 -u 0.001808920305015338 > ./result_10chains/node466_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_4_1 -p 567 -st topic466_4_0 -pt topic466_4_1 -u 0.016657041738293854 > ./result_10chains/node466_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_5_1 -p 747 -st topic466_5_0 -pt topic466_5_1 -u 0.04830940326409228 > ./result_10chains/node466_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_6_1 -p 820 -st topic466_6_0 -pt topic466_6_1 -u 0.011604076340134162 > ./result_10chains/node466_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_7_1 -p 895 -st topic466_7_0 -pt topic466_7_1 -u 0.015340438693910191 > ./result_10chains/node466_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_8_1 -p 929 -st topic466_8_0 -pt topic466_8_1 -u 0.030007624470751365 > ./result_10chains/node466_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_9_1 -p 970 -st topic466_9_0 -pt topic466_9_1 -u 0.04567711910164225 > ./result_10chains/node466_9_1.txt &
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
    "./result_10chains/node466_0_1.txt 90"
    "./result_10chains/node466_1_1.txt 89"
    "./result_10chains/node466_2_1.txt 88"
    "./result_10chains/node466_3_1.txt 87"
    "./result_10chains/node466_4_1.txt 86"
    "./result_10chains/node466_5_1.txt 85"
    "./result_10chains/node466_6_1.txt 84"
    "./result_10chains/node466_7_1.txt 83"
    "./result_10chains/node466_8_1.txt 82"
    "./result_10chains/node466_9_1.txt 81"
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
