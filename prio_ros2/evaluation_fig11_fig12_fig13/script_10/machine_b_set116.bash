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
ros2 run evaluation_3_randomdag uunifast_node -n node116_0_1 -p 212 -st topic116_0_0 -pt topic116_0_1 -u 0.007309509455915464 > ./result_10chains/node116_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_1_1 -p 248 -st topic116_1_0 -pt topic116_1_1 -u 0.020971168172307764 > ./result_10chains/node116_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_2_1 -p 263 -st topic116_2_0 -pt topic116_2_1 -u 0.009919555192036966 > ./result_10chains/node116_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_3_1 -p 308 -st topic116_3_0 -pt topic116_3_1 -u 0.020701494562327394 > ./result_10chains/node116_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_4_1 -p 380 -st topic116_4_0 -pt topic116_4_1 -u 0.007525984424056387 > ./result_10chains/node116_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_5_1 -p 575 -st topic116_5_0 -pt topic116_5_1 -u 0.005100928626033119 > ./result_10chains/node116_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_6_1 -p 748 -st topic116_6_0 -pt topic116_6_1 -u 0.023046156226692566 > ./result_10chains/node116_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_7_1 -p 832 -st topic116_7_0 -pt topic116_7_1 -u 0.036311761092138364 > ./result_10chains/node116_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_8_1 -p 836 -st topic116_8_0 -pt topic116_8_1 -u 0.0030735766167707956 > ./result_10chains/node116_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_9_1 -p 878 -st topic116_9_0 -pt topic116_9_1 -u 0.0022630007875301776 > ./result_10chains/node116_9_1.txt &
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
    "./result_10chains/node116_0_1.txt 90"
    "./result_10chains/node116_1_1.txt 89"
    "./result_10chains/node116_2_1.txt 88"
    "./result_10chains/node116_3_1.txt 87"
    "./result_10chains/node116_4_1.txt 86"
    "./result_10chains/node116_5_1.txt 85"
    "./result_10chains/node116_6_1.txt 84"
    "./result_10chains/node116_7_1.txt 83"
    "./result_10chains/node116_8_1.txt 82"
    "./result_10chains/node116_9_1.txt 81"
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
