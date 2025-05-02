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
ros2 run evaluation_3_randomdag uunifast_node -n node195_0_1 -p 240 -st topic195_0_0 -pt topic195_0_1 -u 0.011408041847155215 > ./result_6chains/node195_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_1_1 -p 408 -st topic195_1_0 -pt topic195_1_1 -u 0.0009077364476213767 > ./result_6chains/node195_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_2_1 -p 424 -st topic195_2_0 -pt topic195_2_1 -u 0.04078388238519659 > ./result_6chains/node195_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_3_1 -p 466 -st topic195_3_0 -pt topic195_3_1 -u 0.010601860680088837 > ./result_6chains/node195_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_4_1 -p 834 -st topic195_4_0 -pt topic195_4_1 -u 0.0604889208177353 > ./result_6chains/node195_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_5_1 -p 918 -st topic195_5_0 -pt topic195_5_1 -u 0.0374384813344665 > ./result_6chains/node195_5_1.txt &
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
    "./result_6chains/node195_0_1.txt 90"
    "./result_6chains/node195_1_1.txt 89"
    "./result_6chains/node195_2_1.txt 88"
    "./result_6chains/node195_3_1.txt 87"
    "./result_6chains/node195_4_1.txt 86"
    "./result_6chains/node195_5_1.txt 85"
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
