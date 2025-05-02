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
ros2 run evaluation_3_randomdag uunifast_node -n node21_0_1 -p 327 -st topic21_0_0 -pt topic21_0_1 -u 0.011696238360181632 > ./result_8chains/node21_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node21_1_1 -p 375 -st topic21_1_0 -pt topic21_1_1 -u 0.00810985075277576 > ./result_8chains/node21_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node21_2_1 -p 402 -st topic21_2_0 -pt topic21_2_1 -u 0.03572370890030796 > ./result_8chains/node21_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node21_3_1 -p 827 -st topic21_3_0 -pt topic21_3_1 -u 0.02273290262836941 > ./result_8chains/node21_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node21_4_1 -p 844 -st topic21_4_0 -pt topic21_4_1 -u 0.01576256845636065 > ./result_8chains/node21_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node21_5_1 -p 868 -st topic21_5_0 -pt topic21_5_1 -u 0.005510806507195709 > ./result_8chains/node21_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node21_6_1 -p 872 -st topic21_6_0 -pt topic21_6_1 -u 0.0024955347855635523 > ./result_8chains/node21_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node21_7_1 -p 898 -st topic21_7_0 -pt topic21_7_1 -u 0.03927900885264072 > ./result_8chains/node21_7_1.txt &
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
    "./result_8chains/node21_0_1.txt 90"
    "./result_8chains/node21_1_1.txt 89"
    "./result_8chains/node21_2_1.txt 88"
    "./result_8chains/node21_3_1.txt 87"
    "./result_8chains/node21_4_1.txt 86"
    "./result_8chains/node21_5_1.txt 85"
    "./result_8chains/node21_6_1.txt 84"
    "./result_8chains/node21_7_1.txt 83"
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
