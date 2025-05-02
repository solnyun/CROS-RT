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
ros2 run evaluation_3_randomdag uunifast_node -n node182_0_1 -p 73 -st topic182_0_0 -pt topic182_0_1 -u 0.010227455488661774 > ./result_10chains/node182_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_1_1 -p 333 -st topic182_1_0 -pt topic182_1_1 -u 0.006621477683518562 > ./result_10chains/node182_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_2_1 -p 341 -st topic182_2_0 -pt topic182_2_1 -u 0.01944329215793328 > ./result_10chains/node182_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_3_1 -p 414 -st topic182_3_0 -pt topic182_3_1 -u 0.13752689377574667 > ./result_10chains/node182_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_4_1 -p 552 -st topic182_4_0 -pt topic182_4_1 -u 0.011529706935730466 > ./result_10chains/node182_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_5_1 -p 710 -st topic182_5_0 -pt topic182_5_1 -u 0.0018808962845007215 > ./result_10chains/node182_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_6_1 -p 736 -st topic182_6_0 -pt topic182_6_1 -u 0.03414243157704383 > ./result_10chains/node182_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_7_1 -p 928 -st topic182_7_0 -pt topic182_7_1 -u 0.008197056707025405 > ./result_10chains/node182_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_8_1 -p 976 -st topic182_8_0 -pt topic182_8_1 -u 0.0006471630258220173 > ./result_10chains/node182_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_9_1 -p 982 -st topic182_9_0 -pt topic182_9_1 -u 0.011765354602623894 > ./result_10chains/node182_9_1.txt &
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
    "./result_10chains/node182_0_1.txt 90"
    "./result_10chains/node182_1_1.txt 89"
    "./result_10chains/node182_2_1.txt 88"
    "./result_10chains/node182_3_1.txt 87"
    "./result_10chains/node182_4_1.txt 86"
    "./result_10chains/node182_5_1.txt 85"
    "./result_10chains/node182_6_1.txt 84"
    "./result_10chains/node182_7_1.txt 83"
    "./result_10chains/node182_8_1.txt 82"
    "./result_10chains/node182_9_1.txt 81"
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
