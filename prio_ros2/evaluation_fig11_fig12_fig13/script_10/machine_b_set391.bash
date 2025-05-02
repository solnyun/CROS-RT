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
ros2 run evaluation_3_randomdag uunifast_node -n node391_0_1 -p 13 -st topic391_0_0 -pt topic391_0_1 -u 0.0018787121280649521 > ./result_10chains/node391_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_1_1 -p 218 -st topic391_1_0 -pt topic391_1_1 -u 0.08093866588991827 > ./result_10chains/node391_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_2_1 -p 260 -st topic391_2_0 -pt topic391_2_1 -u 0.01890228414785089 > ./result_10chains/node391_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_3_1 -p 375 -st topic391_3_0 -pt topic391_3_1 -u 0.003633215113439281 > ./result_10chains/node391_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_4_1 -p 452 -st topic391_4_0 -pt topic391_4_1 -u 0.008631278181252033 > ./result_10chains/node391_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_5_1 -p 665 -st topic391_5_0 -pt topic391_5_1 -u 0.010684710257260976 > ./result_10chains/node391_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_6_1 -p 698 -st topic391_6_0 -pt topic391_6_1 -u 0.012854049643736154 > ./result_10chains/node391_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_7_1 -p 717 -st topic391_7_0 -pt topic391_7_1 -u 0.031767940851662485 > ./result_10chains/node391_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_8_1 -p 980 -st topic391_8_0 -pt topic391_8_1 -u 0.055555317760993775 > ./result_10chains/node391_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_9_1 -p 983 -st topic391_9_0 -pt topic391_9_1 -u 0.006112087195411852 > ./result_10chains/node391_9_1.txt &
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
    "./result_10chains/node391_0_1.txt 90"
    "./result_10chains/node391_1_1.txt 89"
    "./result_10chains/node391_2_1.txt 88"
    "./result_10chains/node391_3_1.txt 87"
    "./result_10chains/node391_4_1.txt 86"
    "./result_10chains/node391_5_1.txt 85"
    "./result_10chains/node391_6_1.txt 84"
    "./result_10chains/node391_7_1.txt 83"
    "./result_10chains/node391_8_1.txt 82"
    "./result_10chains/node391_9_1.txt 81"
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
