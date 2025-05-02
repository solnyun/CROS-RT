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
ros2 run evaluation_3_randomdag uunifast_node -n node478_0_1 -p 68 -st topic478_0_0 -pt topic478_0_1 -u 0.004936519715034171 > ./result_10chains/node478_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_1_1 -p 84 -st topic478_1_0 -pt topic478_1_1 -u 0.03032406871995319 > ./result_10chains/node478_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_2_1 -p 139 -st topic478_2_0 -pt topic478_2_1 -u 0.002468452428290857 > ./result_10chains/node478_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_3_1 -p 225 -st topic478_3_0 -pt topic478_3_1 -u 0.012388235978470552 > ./result_10chains/node478_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_4_1 -p 269 -st topic478_4_0 -pt topic478_4_1 -u 0.004373807812663333 > ./result_10chains/node478_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_5_1 -p 295 -st topic478_5_0 -pt topic478_5_1 -u 0.0059140535280367 > ./result_10chains/node478_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_6_1 -p 436 -st topic478_6_0 -pt topic478_6_1 -u 0.015572999471036408 > ./result_10chains/node478_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_7_1 -p 645 -st topic478_7_0 -pt topic478_7_1 -u 0.05625511629116284 > ./result_10chains/node478_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_8_1 -p 711 -st topic478_8_0 -pt topic478_8_1 -u 0.00013501166884678784 > ./result_10chains/node478_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_9_1 -p 947 -st topic478_9_0 -pt topic478_9_1 -u 0.015339841903636504 > ./result_10chains/node478_9_1.txt &
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
    "./result_10chains/node478_0_1.txt 90"
    "./result_10chains/node478_1_1.txt 89"
    "./result_10chains/node478_2_1.txt 88"
    "./result_10chains/node478_3_1.txt 87"
    "./result_10chains/node478_4_1.txt 86"
    "./result_10chains/node478_5_1.txt 85"
    "./result_10chains/node478_6_1.txt 84"
    "./result_10chains/node478_7_1.txt 83"
    "./result_10chains/node478_8_1.txt 82"
    "./result_10chains/node478_9_1.txt 81"
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
