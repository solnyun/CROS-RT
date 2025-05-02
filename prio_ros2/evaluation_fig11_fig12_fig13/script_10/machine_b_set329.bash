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
ros2 run evaluation_3_randomdag uunifast_node -n node329_0_1 -p 171 -st topic329_0_0 -pt topic329_0_1 -u 0.003087823854354632 > ./result_10chains/node329_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_1_1 -p 278 -st topic329_1_0 -pt topic329_1_1 -u 0.014716650239797457 > ./result_10chains/node329_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_2_1 -p 391 -st topic329_2_0 -pt topic329_2_1 -u 0.0044512210134270425 > ./result_10chains/node329_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_3_1 -p 478 -st topic329_3_0 -pt topic329_3_1 -u 0.009469875956740259 > ./result_10chains/node329_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_4_1 -p 532 -st topic329_4_0 -pt topic329_4_1 -u 0.003917968739540478 > ./result_10chains/node329_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_5_1 -p 559 -st topic329_5_0 -pt topic329_5_1 -u 0.0036969020466735003 > ./result_10chains/node329_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_6_1 -p 734 -st topic329_6_0 -pt topic329_6_1 -u 0.02837461377873335 > ./result_10chains/node329_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_7_1 -p 739 -st topic329_7_0 -pt topic329_7_1 -u 0.014081310065015867 > ./result_10chains/node329_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_8_1 -p 747 -st topic329_8_0 -pt topic329_8_1 -u 0.007336179500733231 > ./result_10chains/node329_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_9_1 -p 841 -st topic329_9_0 -pt topic329_9_1 -u 0.028843230603181266 > ./result_10chains/node329_9_1.txt &
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
    "./result_10chains/node329_0_1.txt 90"
    "./result_10chains/node329_1_1.txt 89"
    "./result_10chains/node329_2_1.txt 88"
    "./result_10chains/node329_3_1.txt 87"
    "./result_10chains/node329_4_1.txt 86"
    "./result_10chains/node329_5_1.txt 85"
    "./result_10chains/node329_6_1.txt 84"
    "./result_10chains/node329_7_1.txt 83"
    "./result_10chains/node329_8_1.txt 82"
    "./result_10chains/node329_9_1.txt 81"
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
