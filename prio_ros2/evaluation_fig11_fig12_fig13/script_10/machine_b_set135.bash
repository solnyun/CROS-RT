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
ros2 run evaluation_3_randomdag uunifast_node -n node135_0_1 -p 45 -st topic135_0_0 -pt topic135_0_1 -u 0.008676816429652512 > ./result_10chains/node135_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_1_1 -p 80 -st topic135_1_0 -pt topic135_1_1 -u 0.023491347621562964 > ./result_10chains/node135_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_2_1 -p 292 -st topic135_2_0 -pt topic135_2_1 -u 0.013431691711567217 > ./result_10chains/node135_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_3_1 -p 344 -st topic135_3_0 -pt topic135_3_1 -u 0.010368240995824396 > ./result_10chains/node135_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_4_1 -p 381 -st topic135_4_0 -pt topic135_4_1 -u 0.024119260736735426 > ./result_10chains/node135_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_5_1 -p 420 -st topic135_5_0 -pt topic135_5_1 -u 0.03254846708641371 > ./result_10chains/node135_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_6_1 -p 487 -st topic135_6_0 -pt topic135_6_1 -u 0.0030695059763406474 > ./result_10chains/node135_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_7_1 -p 572 -st topic135_7_0 -pt topic135_7_1 -u 0.003177865941107194 > ./result_10chains/node135_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_8_1 -p 895 -st topic135_8_0 -pt topic135_8_1 -u 0.012013686381473848 > ./result_10chains/node135_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_9_1 -p 907 -st topic135_9_0 -pt topic135_9_1 -u 0.03405884047691143 > ./result_10chains/node135_9_1.txt &
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
    "./result_10chains/node135_0_1.txt 90"
    "./result_10chains/node135_1_1.txt 89"
    "./result_10chains/node135_2_1.txt 88"
    "./result_10chains/node135_3_1.txt 87"
    "./result_10chains/node135_4_1.txt 86"
    "./result_10chains/node135_5_1.txt 85"
    "./result_10chains/node135_6_1.txt 84"
    "./result_10chains/node135_7_1.txt 83"
    "./result_10chains/node135_8_1.txt 82"
    "./result_10chains/node135_9_1.txt 81"
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
