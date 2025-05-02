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
ros2 run evaluation_3_randomdag uunifast_node -n node288_0_1 -p 20 -st topic288_0_0 -pt topic288_0_1 -u 0.00383477350761835 > ./result_8chains/node288_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_1_1 -p 333 -st topic288_1_0 -pt topic288_1_1 -u 0.015594695076644294 > ./result_8chains/node288_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_2_1 -p 366 -st topic288_2_0 -pt topic288_2_1 -u 0.0017315845311850486 > ./result_8chains/node288_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_3_1 -p 367 -st topic288_3_0 -pt topic288_3_1 -u 0.05670624001994268 > ./result_8chains/node288_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_4_1 -p 528 -st topic288_4_0 -pt topic288_4_1 -u 0.04214466290760249 > ./result_8chains/node288_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_5_1 -p 603 -st topic288_5_0 -pt topic288_5_1 -u 0.0025663333673830446 > ./result_8chains/node288_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_6_1 -p 776 -st topic288_6_0 -pt topic288_6_1 -u 0.01695793993116919 > ./result_8chains/node288_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_7_1 -p 809 -st topic288_7_0 -pt topic288_7_1 -u 0.006738321176846789 > ./result_8chains/node288_7_1.txt &
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
    "./result_8chains/node288_0_1.txt 90"
    "./result_8chains/node288_1_1.txt 89"
    "./result_8chains/node288_2_1.txt 88"
    "./result_8chains/node288_3_1.txt 87"
    "./result_8chains/node288_4_1.txt 86"
    "./result_8chains/node288_5_1.txt 85"
    "./result_8chains/node288_6_1.txt 84"
    "./result_8chains/node288_7_1.txt 83"
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
