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
ros2 run evaluation_3_randomdag uunifast_node -n node36_0_1 -p 218 -st topic36_0_0 -pt topic36_0_1 -u 0.01814685411405398 > ./result_10chains/node36_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node36_1_1 -p 278 -st topic36_1_0 -pt topic36_1_1 -u 0.009307819244579685 > ./result_10chains/node36_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node36_2_1 -p 314 -st topic36_2_0 -pt topic36_2_1 -u 0.02355985053403592 > ./result_10chains/node36_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node36_3_1 -p 373 -st topic36_3_0 -pt topic36_3_1 -u 0.012475825931413609 > ./result_10chains/node36_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node36_4_1 -p 485 -st topic36_4_0 -pt topic36_4_1 -u 0.01903567438361292 > ./result_10chains/node36_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node36_5_1 -p 775 -st topic36_5_0 -pt topic36_5_1 -u 0.043128011758654355 > ./result_10chains/node36_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node36_6_1 -p 803 -st topic36_6_0 -pt topic36_6_1 -u 0.003680365946359593 > ./result_10chains/node36_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node36_7_1 -p 848 -st topic36_7_0 -pt topic36_7_1 -u 0.0020034905640820277 > ./result_10chains/node36_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node36_8_1 -p 915 -st topic36_8_0 -pt topic36_8_1 -u 0.0009463037528065904 > ./result_10chains/node36_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node36_9_1 -p 977 -st topic36_9_0 -pt topic36_9_1 -u 0.04822809005402235 > ./result_10chains/node36_9_1.txt &
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
    "./result_10chains/node36_0_1.txt 90"
    "./result_10chains/node36_1_1.txt 89"
    "./result_10chains/node36_2_1.txt 88"
    "./result_10chains/node36_3_1.txt 87"
    "./result_10chains/node36_4_1.txt 86"
    "./result_10chains/node36_5_1.txt 85"
    "./result_10chains/node36_6_1.txt 84"
    "./result_10chains/node36_7_1.txt 83"
    "./result_10chains/node36_8_1.txt 82"
    "./result_10chains/node36_9_1.txt 81"
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
