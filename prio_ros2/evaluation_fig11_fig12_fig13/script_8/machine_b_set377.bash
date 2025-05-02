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
ros2 run evaluation_3_randomdag uunifast_node -n node377_0_1 -p 112 -st topic377_0_0 -pt topic377_0_1 -u 0.007305103347079567 > ./result_8chains/node377_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_1_1 -p 166 -st topic377_1_0 -pt topic377_1_1 -u 0.008728420700388706 > ./result_8chains/node377_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_2_1 -p 247 -st topic377_2_0 -pt topic377_2_1 -u 0.006055272181022142 > ./result_8chains/node377_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_3_1 -p 275 -st topic377_3_0 -pt topic377_3_1 -u 0.007427738985595123 > ./result_8chains/node377_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_4_1 -p 382 -st topic377_4_0 -pt topic377_4_1 -u 0.007146205749637702 > ./result_8chains/node377_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_5_1 -p 450 -st topic377_5_0 -pt topic377_5_1 -u 0.04244262609389582 > ./result_8chains/node377_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_6_1 -p 482 -st topic377_6_0 -pt topic377_6_1 -u 0.007953446993527041 > ./result_8chains/node377_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_7_1 -p 834 -st topic377_7_0 -pt topic377_7_1 -u 0.0030071361408131048 > ./result_8chains/node377_7_1.txt &
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
    "./result_8chains/node377_0_1.txt 90"
    "./result_8chains/node377_1_1.txt 89"
    "./result_8chains/node377_2_1.txt 88"
    "./result_8chains/node377_3_1.txt 87"
    "./result_8chains/node377_4_1.txt 86"
    "./result_8chains/node377_5_1.txt 85"
    "./result_8chains/node377_6_1.txt 84"
    "./result_8chains/node377_7_1.txt 83"
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
