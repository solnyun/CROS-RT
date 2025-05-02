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
ros2 run evaluation_3_randomdag uunifast_node -n node490_0_1 -p 50 -st topic490_0_0 -pt topic490_0_1 -u 0.011430095613978897 > ./result_8chains/node490_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_1_1 -p 75 -st topic490_1_0 -pt topic490_1_1 -u 0.012973050551333354 > ./result_8chains/node490_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_2_1 -p 102 -st topic490_2_0 -pt topic490_2_1 -u 0.005282764711821597 > ./result_8chains/node490_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_3_1 -p 205 -st topic490_3_0 -pt topic490_3_1 -u 0.009447012814690015 > ./result_8chains/node490_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_4_1 -p 215 -st topic490_4_0 -pt topic490_4_1 -u 0.10485128287580611 > ./result_8chains/node490_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_5_1 -p 473 -st topic490_5_0 -pt topic490_5_1 -u 0.044831477669269676 > ./result_8chains/node490_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_6_1 -p 534 -st topic490_6_0 -pt topic490_6_1 -u 0.01180656047494369 > ./result_8chains/node490_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_7_1 -p 746 -st topic490_7_0 -pt topic490_7_1 -u 0.0033311369566539246 > ./result_8chains/node490_7_1.txt &
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
    "./result_8chains/node490_0_1.txt 90"
    "./result_8chains/node490_1_1.txt 89"
    "./result_8chains/node490_2_1.txt 88"
    "./result_8chains/node490_3_1.txt 87"
    "./result_8chains/node490_4_1.txt 86"
    "./result_8chains/node490_5_1.txt 85"
    "./result_8chains/node490_6_1.txt 84"
    "./result_8chains/node490_7_1.txt 83"
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
