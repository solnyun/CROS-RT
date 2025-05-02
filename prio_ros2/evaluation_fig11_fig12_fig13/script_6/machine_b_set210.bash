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
ros2 run evaluation_3_randomdag uunifast_node -n node210_0_1 -p 127 -st topic210_0_0 -pt topic210_0_1 -u 0.0557380650804718 > ./result_6chains/node210_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_1_1 -p 260 -st topic210_1_0 -pt topic210_1_1 -u 0.12722698529064486 > ./result_6chains/node210_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_2_1 -p 437 -st topic210_2_0 -pt topic210_2_1 -u 0.04327213569029881 > ./result_6chains/node210_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_3_1 -p 692 -st topic210_3_0 -pt topic210_3_1 -u 0.010586399502043126 > ./result_6chains/node210_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_4_1 -p 918 -st topic210_4_0 -pt topic210_4_1 -u 0.0029977341380032774 > ./result_6chains/node210_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_5_1 -p 941 -st topic210_5_0 -pt topic210_5_1 -u 0.001683969058722909 > ./result_6chains/node210_5_1.txt &
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
    "./result_6chains/node210_0_1.txt 90"
    "./result_6chains/node210_1_1.txt 89"
    "./result_6chains/node210_2_1.txt 88"
    "./result_6chains/node210_3_1.txt 87"
    "./result_6chains/node210_4_1.txt 86"
    "./result_6chains/node210_5_1.txt 85"
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
