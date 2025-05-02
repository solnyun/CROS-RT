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
ros2 run evaluation_3_randomdag uunifast_node -n node243_0_1 -p 10 -st topic243_0_0 -pt topic243_0_1 -u 0.016148986176553026 > ./result_10chains/node243_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_1_1 -p 122 -st topic243_1_0 -pt topic243_1_1 -u 0.0011975160423023379 > ./result_10chains/node243_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_2_1 -p 185 -st topic243_2_0 -pt topic243_2_1 -u 0.006553034113860157 > ./result_10chains/node243_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_3_1 -p 285 -st topic243_3_0 -pt topic243_3_1 -u 0.011156272581040627 > ./result_10chains/node243_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_4_1 -p 367 -st topic243_4_0 -pt topic243_4_1 -u 0.04817339432182083 > ./result_10chains/node243_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_5_1 -p 456 -st topic243_5_0 -pt topic243_5_1 -u 0.0050917091334029 > ./result_10chains/node243_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_6_1 -p 647 -st topic243_6_0 -pt topic243_6_1 -u 0.005112956789584039 > ./result_10chains/node243_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_7_1 -p 828 -st topic243_7_0 -pt topic243_7_1 -u 0.012713466654283329 > ./result_10chains/node243_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_8_1 -p 830 -st topic243_8_0 -pt topic243_8_1 -u 0.06484694711276333 > ./result_10chains/node243_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_9_1 -p 869 -st topic243_9_0 -pt topic243_9_1 -u 0.00575180575222079 > ./result_10chains/node243_9_1.txt &
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
    "./result_10chains/node243_0_1.txt 90"
    "./result_10chains/node243_1_1.txt 89"
    "./result_10chains/node243_2_1.txt 88"
    "./result_10chains/node243_3_1.txt 87"
    "./result_10chains/node243_4_1.txt 86"
    "./result_10chains/node243_5_1.txt 85"
    "./result_10chains/node243_6_1.txt 84"
    "./result_10chains/node243_7_1.txt 83"
    "./result_10chains/node243_8_1.txt 82"
    "./result_10chains/node243_9_1.txt 81"
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
