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
ros2 run evaluation_3_randomdag uunifast_node -n node307_0_1 -p 47 -st topic307_0_0 -pt topic307_0_1 -u 0.007033663744952179 > ./result_8chains/node307_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_1_1 -p 78 -st topic307_1_0 -pt topic307_1_1 -u 0.03287277427559815 > ./result_8chains/node307_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_2_1 -p 81 -st topic307_2_0 -pt topic307_2_1 -u 0.0176696631145154 > ./result_8chains/node307_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_3_1 -p 106 -st topic307_3_0 -pt topic307_3_1 -u 0.0394372969062744 > ./result_8chains/node307_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_4_1 -p 349 -st topic307_4_0 -pt topic307_4_1 -u 0.007799639019027194 > ./result_8chains/node307_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_5_1 -p 427 -st topic307_5_0 -pt topic307_5_1 -u 0.006490140120623378 > ./result_8chains/node307_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_6_1 -p 435 -st topic307_6_0 -pt topic307_6_1 -u 0.05047552198620997 > ./result_8chains/node307_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_7_1 -p 522 -st topic307_7_0 -pt topic307_7_1 -u 0.04147855464306817 > ./result_8chains/node307_7_1.txt &
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
    "./result_8chains/node307_0_1.txt 90"
    "./result_8chains/node307_1_1.txt 89"
    "./result_8chains/node307_2_1.txt 88"
    "./result_8chains/node307_3_1.txt 87"
    "./result_8chains/node307_4_1.txt 86"
    "./result_8chains/node307_5_1.txt 85"
    "./result_8chains/node307_6_1.txt 84"
    "./result_8chains/node307_7_1.txt 83"
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
