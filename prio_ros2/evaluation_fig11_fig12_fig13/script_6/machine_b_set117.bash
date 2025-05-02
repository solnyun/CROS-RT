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
ros2 run evaluation_3_randomdag uunifast_node -n node117_0_1 -p 230 -st topic117_0_0 -pt topic117_0_1 -u 0.007641267494387427 > ./result_6chains/node117_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_1_1 -p 309 -st topic117_1_0 -pt topic117_1_1 -u 0.011484042629170077 > ./result_6chains/node117_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_2_1 -p 363 -st topic117_2_0 -pt topic117_2_1 -u 0.007600536822905846 > ./result_6chains/node117_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_3_1 -p 511 -st topic117_3_0 -pt topic117_3_1 -u 0.11409889770404652 > ./result_6chains/node117_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_4_1 -p 575 -st topic117_4_0 -pt topic117_4_1 -u 0.004923681814253469 > ./result_6chains/node117_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_5_1 -p 690 -st topic117_5_0 -pt topic117_5_1 -u 0.062496030032361656 > ./result_6chains/node117_5_1.txt &
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
    "./result_6chains/node117_0_1.txt 90"
    "./result_6chains/node117_1_1.txt 89"
    "./result_6chains/node117_2_1.txt 88"
    "./result_6chains/node117_3_1.txt 87"
    "./result_6chains/node117_4_1.txt 86"
    "./result_6chains/node117_5_1.txt 85"
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
