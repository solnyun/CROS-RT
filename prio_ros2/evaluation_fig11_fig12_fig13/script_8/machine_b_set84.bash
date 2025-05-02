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
ros2 run evaluation_3_randomdag uunifast_node -n node84_0_1 -p 73 -st topic84_0_0 -pt topic84_0_1 -u 0.04608867534060068 > ./result_8chains/node84_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_1_1 -p 127 -st topic84_1_0 -pt topic84_1_1 -u 0.00542059728601646 > ./result_8chains/node84_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_2_1 -p 211 -st topic84_2_0 -pt topic84_2_1 -u 0.002390963398870294 > ./result_8chains/node84_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_3_1 -p 302 -st topic84_3_0 -pt topic84_3_1 -u 0.006873877021981334 > ./result_8chains/node84_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_4_1 -p 423 -st topic84_4_0 -pt topic84_4_1 -u 0.018427935516197813 > ./result_8chains/node84_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_5_1 -p 449 -st topic84_5_0 -pt topic84_5_1 -u 0.0017543242670602643 > ./result_8chains/node84_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_6_1 -p 450 -st topic84_6_0 -pt topic84_6_1 -u 0.006663706001383385 > ./result_8chains/node84_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_7_1 -p 719 -st topic84_7_0 -pt topic84_7_1 -u 0.020275246471915913 > ./result_8chains/node84_7_1.txt &
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
    "./result_8chains/node84_0_1.txt 90"
    "./result_8chains/node84_1_1.txt 89"
    "./result_8chains/node84_2_1.txt 88"
    "./result_8chains/node84_3_1.txt 87"
    "./result_8chains/node84_4_1.txt 86"
    "./result_8chains/node84_5_1.txt 85"
    "./result_8chains/node84_6_1.txt 84"
    "./result_8chains/node84_7_1.txt 83"
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
