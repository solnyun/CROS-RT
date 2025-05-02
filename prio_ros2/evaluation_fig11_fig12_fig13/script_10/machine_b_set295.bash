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
ros2 run evaluation_3_randomdag uunifast_node -n node295_0_1 -p 107 -st topic295_0_0 -pt topic295_0_1 -u 0.010529423043613595 > ./result_10chains/node295_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_1_1 -p 168 -st topic295_1_0 -pt topic295_1_1 -u 0.036695415435349876 > ./result_10chains/node295_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_2_1 -p 208 -st topic295_2_0 -pt topic295_2_1 -u 0.019724606602548267 > ./result_10chains/node295_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_3_1 -p 276 -st topic295_3_0 -pt topic295_3_1 -u 0.024343295830381084 > ./result_10chains/node295_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_4_1 -p 358 -st topic295_4_0 -pt topic295_4_1 -u 0.003359520378677483 > ./result_10chains/node295_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_5_1 -p 406 -st topic295_5_0 -pt topic295_5_1 -u 0.019550725554842385 > ./result_10chains/node295_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_6_1 -p 426 -st topic295_6_0 -pt topic295_6_1 -u 0.017745337114257576 > ./result_10chains/node295_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_7_1 -p 464 -st topic295_7_0 -pt topic295_7_1 -u 0.021614234948872324 > ./result_10chains/node295_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_8_1 -p 546 -st topic295_8_0 -pt topic295_8_1 -u 0.009212962120851612 > ./result_10chains/node295_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_9_1 -p 650 -st topic295_9_0 -pt topic295_9_1 -u 0.020182164756774697 > ./result_10chains/node295_9_1.txt &
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
    "./result_10chains/node295_0_1.txt 90"
    "./result_10chains/node295_1_1.txt 89"
    "./result_10chains/node295_2_1.txt 88"
    "./result_10chains/node295_3_1.txt 87"
    "./result_10chains/node295_4_1.txt 86"
    "./result_10chains/node295_5_1.txt 85"
    "./result_10chains/node295_6_1.txt 84"
    "./result_10chains/node295_7_1.txt 83"
    "./result_10chains/node295_8_1.txt 82"
    "./result_10chains/node295_9_1.txt 81"
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
