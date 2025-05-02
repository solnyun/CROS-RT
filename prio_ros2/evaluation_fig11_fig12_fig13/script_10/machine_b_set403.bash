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
ros2 run evaluation_3_randomdag uunifast_node -n node403_0_1 -p 19 -st topic403_0_0 -pt topic403_0_1 -u 0.0019330358149769467 > ./result_10chains/node403_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_1_1 -p 155 -st topic403_1_0 -pt topic403_1_1 -u 0.004054667695985559 > ./result_10chains/node403_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_2_1 -p 267 -st topic403_2_0 -pt topic403_2_1 -u 0.01526005485348092 > ./result_10chains/node403_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_3_1 -p 296 -st topic403_3_0 -pt topic403_3_1 -u 0.017557602762157787 > ./result_10chains/node403_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_4_1 -p 441 -st topic403_4_0 -pt topic403_4_1 -u 0.016100567788684295 > ./result_10chains/node403_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_5_1 -p 739 -st topic403_5_0 -pt topic403_5_1 -u 0.004491819498609578 > ./result_10chains/node403_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_6_1 -p 744 -st topic403_6_0 -pt topic403_6_1 -u 0.004045283522015358 > ./result_10chains/node403_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_7_1 -p 943 -st topic403_7_0 -pt topic403_7_1 -u 0.03216488289674134 > ./result_10chains/node403_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_8_1 -p 967 -st topic403_8_0 -pt topic403_8_1 -u 0.0016422733627027841 > ./result_10chains/node403_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_9_1 -p 999 -st topic403_9_0 -pt topic403_9_1 -u 0.023513854528585627 > ./result_10chains/node403_9_1.txt &
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
    "./result_10chains/node403_0_1.txt 90"
    "./result_10chains/node403_1_1.txt 89"
    "./result_10chains/node403_2_1.txt 88"
    "./result_10chains/node403_3_1.txt 87"
    "./result_10chains/node403_4_1.txt 86"
    "./result_10chains/node403_5_1.txt 85"
    "./result_10chains/node403_6_1.txt 84"
    "./result_10chains/node403_7_1.txt 83"
    "./result_10chains/node403_8_1.txt 82"
    "./result_10chains/node403_9_1.txt 81"
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
