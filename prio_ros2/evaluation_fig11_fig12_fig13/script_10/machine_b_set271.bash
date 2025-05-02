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
ros2 run evaluation_3_randomdag uunifast_node -n node271_0_1 -p 64 -st topic271_0_0 -pt topic271_0_1 -u 0.01883803039489418 > ./result_10chains/node271_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_1_1 -p 85 -st topic271_1_0 -pt topic271_1_1 -u 0.023958988686723304 > ./result_10chains/node271_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_2_1 -p 95 -st topic271_2_0 -pt topic271_2_1 -u 0.022343233937458906 > ./result_10chains/node271_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_3_1 -p 206 -st topic271_3_0 -pt topic271_3_1 -u 0.00010511285365910616 > ./result_10chains/node271_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_4_1 -p 369 -st topic271_4_0 -pt topic271_4_1 -u 0.010213599579058208 > ./result_10chains/node271_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_5_1 -p 448 -st topic271_5_0 -pt topic271_5_1 -u 0.04737194426336447 > ./result_10chains/node271_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_6_1 -p 540 -st topic271_6_0 -pt topic271_6_1 -u 0.006767334529914959 > ./result_10chains/node271_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_7_1 -p 716 -st topic271_7_0 -pt topic271_7_1 -u 0.02085259572565412 > ./result_10chains/node271_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_8_1 -p 764 -st topic271_8_0 -pt topic271_8_1 -u 0.036049503400213914 > ./result_10chains/node271_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_9_1 -p 905 -st topic271_9_0 -pt topic271_9_1 -u 0.051894040401733406 > ./result_10chains/node271_9_1.txt &
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
    "./result_10chains/node271_0_1.txt 90"
    "./result_10chains/node271_1_1.txt 89"
    "./result_10chains/node271_2_1.txt 88"
    "./result_10chains/node271_3_1.txt 87"
    "./result_10chains/node271_4_1.txt 86"
    "./result_10chains/node271_5_1.txt 85"
    "./result_10chains/node271_6_1.txt 84"
    "./result_10chains/node271_7_1.txt 83"
    "./result_10chains/node271_8_1.txt 82"
    "./result_10chains/node271_9_1.txt 81"
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
