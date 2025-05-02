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
ros2 run evaluation_3_randomdag uunifast_node -n node372_0_1 -p 123 -st topic372_0_0 -pt topic372_0_1 -u 0.018378790418019042 > ./result_8chains/node372_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_1_1 -p 337 -st topic372_1_0 -pt topic372_1_1 -u 0.035384347347711786 > ./result_8chains/node372_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_2_1 -p 346 -st topic372_2_0 -pt topic372_2_1 -u 0.019814815569241806 > ./result_8chains/node372_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_3_1 -p 438 -st topic372_3_0 -pt topic372_3_1 -u 0.02924705719564441 > ./result_8chains/node372_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_4_1 -p 674 -st topic372_4_0 -pt topic372_4_1 -u 0.00844309604179469 > ./result_8chains/node372_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_5_1 -p 788 -st topic372_5_0 -pt topic372_5_1 -u 0.02473393103165114 > ./result_8chains/node372_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_6_1 -p 884 -st topic372_6_0 -pt topic372_6_1 -u 0.035261448598756226 > ./result_8chains/node372_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_7_1 -p 943 -st topic372_7_0 -pt topic372_7_1 -u 0.006385384494513577 > ./result_8chains/node372_7_1.txt &
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
    "./result_8chains/node372_0_1.txt 90"
    "./result_8chains/node372_1_1.txt 89"
    "./result_8chains/node372_2_1.txt 88"
    "./result_8chains/node372_3_1.txt 87"
    "./result_8chains/node372_4_1.txt 86"
    "./result_8chains/node372_5_1.txt 85"
    "./result_8chains/node372_6_1.txt 84"
    "./result_8chains/node372_7_1.txt 83"
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
