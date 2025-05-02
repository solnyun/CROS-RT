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
ros2 run evaluation_3_randomdag uunifast_node -n node300_0_1 -p 63 -st topic300_0_0 -pt topic300_0_1 -u 0.01828698726249589 > ./result_10chains/node300_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_1_1 -p 120 -st topic300_1_0 -pt topic300_1_1 -u 0.0013934681970310114 > ./result_10chains/node300_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_2_1 -p 135 -st topic300_2_0 -pt topic300_2_1 -u 0.014928886895576088 > ./result_10chains/node300_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_3_1 -p 309 -st topic300_3_0 -pt topic300_3_1 -u 0.01510388455618561 > ./result_10chains/node300_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_4_1 -p 466 -st topic300_4_0 -pt topic300_4_1 -u 0.015737211528452033 > ./result_10chains/node300_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_5_1 -p 485 -st topic300_5_0 -pt topic300_5_1 -u 0.016953151127686195 > ./result_10chains/node300_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_6_1 -p 657 -st topic300_6_0 -pt topic300_6_1 -u 0.008895966112118181 > ./result_10chains/node300_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_7_1 -p 777 -st topic300_7_0 -pt topic300_7_1 -u 0.026941632007406277 > ./result_10chains/node300_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_8_1 -p 907 -st topic300_8_0 -pt topic300_8_1 -u 0.009619151313538528 > ./result_10chains/node300_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_9_1 -p 977 -st topic300_9_0 -pt topic300_9_1 -u 0.008137936815979668 > ./result_10chains/node300_9_1.txt &
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
    "./result_10chains/node300_0_1.txt 90"
    "./result_10chains/node300_1_1.txt 89"
    "./result_10chains/node300_2_1.txt 88"
    "./result_10chains/node300_3_1.txt 87"
    "./result_10chains/node300_4_1.txt 86"
    "./result_10chains/node300_5_1.txt 85"
    "./result_10chains/node300_6_1.txt 84"
    "./result_10chains/node300_7_1.txt 83"
    "./result_10chains/node300_8_1.txt 82"
    "./result_10chains/node300_9_1.txt 81"
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
