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
ros2 run evaluation_3_randomdag uunifast_node -n node343_0_1 -p 148 -st topic343_0_0 -pt topic343_0_1 -u 0.04218823409392447 > ./result_10chains/node343_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_1_1 -p 208 -st topic343_1_0 -pt topic343_1_1 -u 0.019158322163548513 > ./result_10chains/node343_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_2_1 -p 531 -st topic343_2_0 -pt topic343_2_1 -u 0.008578783465946316 > ./result_10chains/node343_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_3_1 -p 653 -st topic343_3_0 -pt topic343_3_1 -u 0.03547808009143094 > ./result_10chains/node343_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_4_1 -p 724 -st topic343_4_0 -pt topic343_4_1 -u 0.0044378285774363535 > ./result_10chains/node343_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_5_1 -p 790 -st topic343_5_0 -pt topic343_5_1 -u 0.010659846677122747 > ./result_10chains/node343_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_6_1 -p 797 -st topic343_6_0 -pt topic343_6_1 -u 0.024840342458332665 > ./result_10chains/node343_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_7_1 -p 864 -st topic343_7_0 -pt topic343_7_1 -u 0.015554232778620475 > ./result_10chains/node343_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_8_1 -p 985 -st topic343_8_0 -pt topic343_8_1 -u 0.006748075326613701 > ./result_10chains/node343_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_9_1 -p 996 -st topic343_9_0 -pt topic343_9_1 -u 0.03136742683109927 > ./result_10chains/node343_9_1.txt &
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
    "./result_10chains/node343_0_1.txt 90"
    "./result_10chains/node343_1_1.txt 89"
    "./result_10chains/node343_2_1.txt 88"
    "./result_10chains/node343_3_1.txt 87"
    "./result_10chains/node343_4_1.txt 86"
    "./result_10chains/node343_5_1.txt 85"
    "./result_10chains/node343_6_1.txt 84"
    "./result_10chains/node343_7_1.txt 83"
    "./result_10chains/node343_8_1.txt 82"
    "./result_10chains/node343_9_1.txt 81"
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
