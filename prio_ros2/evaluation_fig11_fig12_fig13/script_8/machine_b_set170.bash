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
ros2 run evaluation_3_randomdag uunifast_node -n node170_0_1 -p 17 -st topic170_0_0 -pt topic170_0_1 -u 0.035857256661264325 > ./result_8chains/node170_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_1_1 -p 141 -st topic170_1_0 -pt topic170_1_1 -u 0.004651125701682413 > ./result_8chains/node170_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_2_1 -p 370 -st topic170_2_0 -pt topic170_2_1 -u 0.009465826346899353 > ./result_8chains/node170_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_3_1 -p 455 -st topic170_3_0 -pt topic170_3_1 -u 0.01573304027433614 > ./result_8chains/node170_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_4_1 -p 478 -st topic170_4_0 -pt topic170_4_1 -u 0.006615969193065618 > ./result_8chains/node170_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_5_1 -p 517 -st topic170_5_0 -pt topic170_5_1 -u 0.005702531215196316 > ./result_8chains/node170_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_6_1 -p 534 -st topic170_6_0 -pt topic170_6_1 -u 0.011778774224609295 > ./result_8chains/node170_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_7_1 -p 799 -st topic170_7_0 -pt topic170_7_1 -u 0.07069522053804844 > ./result_8chains/node170_7_1.txt &
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
    "./result_8chains/node170_0_1.txt 90"
    "./result_8chains/node170_1_1.txt 89"
    "./result_8chains/node170_2_1.txt 88"
    "./result_8chains/node170_3_1.txt 87"
    "./result_8chains/node170_4_1.txt 86"
    "./result_8chains/node170_5_1.txt 85"
    "./result_8chains/node170_6_1.txt 84"
    "./result_8chains/node170_7_1.txt 83"
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
