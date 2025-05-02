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
ros2 run evaluation_3_randomdag uunifast_node -n node20_0_1 -p 22 -st topic20_0_0 -pt topic20_0_1 -u 0.018142065570875943 > ./result_10chains/node20_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node20_1_1 -p 55 -st topic20_1_0 -pt topic20_1_1 -u 0.003433357035163287 > ./result_10chains/node20_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node20_2_1 -p 284 -st topic20_2_0 -pt topic20_2_1 -u 0.04404530222029074 > ./result_10chains/node20_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node20_3_1 -p 591 -st topic20_3_0 -pt topic20_3_1 -u 0.0019493959867257216 > ./result_10chains/node20_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node20_4_1 -p 684 -st topic20_4_0 -pt topic20_4_1 -u 0.0053121850257472625 > ./result_10chains/node20_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node20_5_1 -p 730 -st topic20_5_0 -pt topic20_5_1 -u 0.0017178058347062097 > ./result_10chains/node20_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node20_6_1 -p 789 -st topic20_6_0 -pt topic20_6_1 -u 0.005250397304625842 > ./result_10chains/node20_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node20_7_1 -p 851 -st topic20_7_0 -pt topic20_7_1 -u 0.013238486890763665 > ./result_10chains/node20_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node20_8_1 -p 872 -st topic20_8_0 -pt topic20_8_1 -u 0.021515061984638095 > ./result_10chains/node20_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node20_9_1 -p 901 -st topic20_9_0 -pt topic20_9_1 -u 0.0061308231175635376 > ./result_10chains/node20_9_1.txt &
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
    "./result_10chains/node20_0_1.txt 90"
    "./result_10chains/node20_1_1.txt 89"
    "./result_10chains/node20_2_1.txt 88"
    "./result_10chains/node20_3_1.txt 87"
    "./result_10chains/node20_4_1.txt 86"
    "./result_10chains/node20_5_1.txt 85"
    "./result_10chains/node20_6_1.txt 84"
    "./result_10chains/node20_7_1.txt 83"
    "./result_10chains/node20_8_1.txt 82"
    "./result_10chains/node20_9_1.txt 81"
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
