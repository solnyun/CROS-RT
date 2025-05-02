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
ros2 run evaluation_3_randomdag uunifast_node -n node0_0_1 -p 107 -st topic0_0_0 -pt topic0_0_1 -u 0.007405183588542752 > ./result_10chains/node0_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node0_1_1 -p 112 -st topic0_1_0 -pt topic0_1_1 -u 0.038600051880124664 > ./result_10chains/node0_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node0_2_1 -p 160 -st topic0_2_0 -pt topic0_2_1 -u 0.01248522791560236 > ./result_10chains/node0_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node0_3_1 -p 462 -st topic0_3_0 -pt topic0_3_1 -u 0.02967337724021199 > ./result_10chains/node0_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node0_4_1 -p 473 -st topic0_4_0 -pt topic0_4_1 -u 0.0277949745828118 > ./result_10chains/node0_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node0_5_1 -p 484 -st topic0_5_0 -pt topic0_5_1 -u 0.014579002382939285 > ./result_10chains/node0_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node0_6_1 -p 501 -st topic0_6_0 -pt topic0_6_1 -u 0.014775476960606743 > ./result_10chains/node0_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node0_7_1 -p 777 -st topic0_7_0 -pt topic0_7_1 -u 0.005924588290358648 > ./result_10chains/node0_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node0_8_1 -p 842 -st topic0_8_0 -pt topic0_8_1 -u 0.018848314111014508 > ./result_10chains/node0_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node0_9_1 -p 999 -st topic0_9_0 -pt topic0_9_1 -u 0.012502840333180314 > ./result_10chains/node0_9_1.txt &
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
    "./result_10chains/node0_0_1.txt 90"
    "./result_10chains/node0_1_1.txt 89"
    "./result_10chains/node0_2_1.txt 88"
    "./result_10chains/node0_3_1.txt 87"
    "./result_10chains/node0_4_1.txt 86"
    "./result_10chains/node0_5_1.txt 85"
    "./result_10chains/node0_6_1.txt 84"
    "./result_10chains/node0_7_1.txt 83"
    "./result_10chains/node0_8_1.txt 82"
    "./result_10chains/node0_9_1.txt 81"
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
