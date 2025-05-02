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
ros2 run evaluation_3_randomdag uunifast_node -n node216_0_1 -p 121 -st topic216_0_0 -pt topic216_0_1 -u 0.016619040639670346 > ./result_6chains/node216_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_1_1 -p 142 -st topic216_1_0 -pt topic216_1_1 -u 0.0005809106865656832 > ./result_6chains/node216_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_2_1 -p 401 -st topic216_2_0 -pt topic216_2_1 -u 0.02495188870135215 > ./result_6chains/node216_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_3_1 -p 548 -st topic216_3_0 -pt topic216_3_1 -u 0.011239060152085478 > ./result_6chains/node216_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_4_1 -p 760 -st topic216_4_0 -pt topic216_4_1 -u 0.02893614222176595 > ./result_6chains/node216_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_5_1 -p 810 -st topic216_5_0 -pt topic216_5_1 -u 0.017761648634695093 > ./result_6chains/node216_5_1.txt &
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
    "./result_6chains/node216_0_1.txt 90"
    "./result_6chains/node216_1_1.txt 89"
    "./result_6chains/node216_2_1.txt 88"
    "./result_6chains/node216_3_1.txt 87"
    "./result_6chains/node216_4_1.txt 86"
    "./result_6chains/node216_5_1.txt 85"
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
