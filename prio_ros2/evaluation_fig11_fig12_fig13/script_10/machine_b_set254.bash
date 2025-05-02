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
ros2 run evaluation_3_randomdag uunifast_node -n node254_0_1 -p 11 -st topic254_0_0 -pt topic254_0_1 -u 0.010134607514253824 > ./result_10chains/node254_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_1_1 -p 196 -st topic254_1_0 -pt topic254_1_1 -u 0.020046865628904842 > ./result_10chains/node254_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_2_1 -p 416 -st topic254_2_0 -pt topic254_2_1 -u 0.006812860630257989 > ./result_10chains/node254_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_3_1 -p 532 -st topic254_3_0 -pt topic254_3_1 -u 0.0007994967595723046 > ./result_10chains/node254_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_4_1 -p 576 -st topic254_4_0 -pt topic254_4_1 -u 0.0031562812362815884 > ./result_10chains/node254_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_5_1 -p 784 -st topic254_5_0 -pt topic254_5_1 -u 0.06077871497880899 > ./result_10chains/node254_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_6_1 -p 815 -st topic254_6_0 -pt topic254_6_1 -u 0.05966675496209037 > ./result_10chains/node254_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_7_1 -p 868 -st topic254_7_0 -pt topic254_7_1 -u 0.004835534021936594 > ./result_10chains/node254_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_8_1 -p 980 -st topic254_8_0 -pt topic254_8_1 -u 0.008739446970196213 > ./result_10chains/node254_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_9_1 -p 998 -st topic254_9_0 -pt topic254_9_1 -u 0.033635639140081 > ./result_10chains/node254_9_1.txt &
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
    "./result_10chains/node254_0_1.txt 90"
    "./result_10chains/node254_1_1.txt 89"
    "./result_10chains/node254_2_1.txt 88"
    "./result_10chains/node254_3_1.txt 87"
    "./result_10chains/node254_4_1.txt 86"
    "./result_10chains/node254_5_1.txt 85"
    "./result_10chains/node254_6_1.txt 84"
    "./result_10chains/node254_7_1.txt 83"
    "./result_10chains/node254_8_1.txt 82"
    "./result_10chains/node254_9_1.txt 81"
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
