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
ros2 run evaluation_3_randomdag uunifast_node -n node410_0_1 -p 203 -st topic410_0_0 -pt topic410_0_1 -u 0.002118490572016518 > ./result_6chains/node410_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_1_1 -p 457 -st topic410_1_0 -pt topic410_1_1 -u 0.0020247198177797965 > ./result_6chains/node410_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_2_1 -p 478 -st topic410_2_0 -pt topic410_2_1 -u 0.06097567434192297 > ./result_6chains/node410_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_3_1 -p 493 -st topic410_3_0 -pt topic410_3_1 -u 0.009158355210532626 > ./result_6chains/node410_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_4_1 -p 516 -st topic410_4_0 -pt topic410_4_1 -u 0.023740216570848877 > ./result_6chains/node410_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_5_1 -p 520 -st topic410_5_0 -pt topic410_5_1 -u 0.04794867658624321 > ./result_6chains/node410_5_1.txt &
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
    "./result_6chains/node410_0_1.txt 90"
    "./result_6chains/node410_1_1.txt 89"
    "./result_6chains/node410_2_1.txt 88"
    "./result_6chains/node410_3_1.txt 87"
    "./result_6chains/node410_4_1.txt 86"
    "./result_6chains/node410_5_1.txt 85"
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
