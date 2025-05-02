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
ros2 run evaluation_3_randomdag uunifast_node -n node349_0_1 -p 370 -st topic349_0_0 -pt topic349_0_1 -u 0.0009453135185598094 > ./result_8chains/node349_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_1_1 -p 512 -st topic349_1_0 -pt topic349_1_1 -u 0.016664924240976764 > ./result_8chains/node349_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_2_1 -p 641 -st topic349_2_0 -pt topic349_2_1 -u 0.012165306995812253 > ./result_8chains/node349_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_3_1 -p 658 -st topic349_3_0 -pt topic349_3_1 -u 0.029468126593144905 > ./result_8chains/node349_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_4_1 -p 749 -st topic349_4_0 -pt topic349_4_1 -u 0.008174750568942651 > ./result_8chains/node349_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_5_1 -p 779 -st topic349_5_0 -pt topic349_5_1 -u 0.03406976816004992 > ./result_8chains/node349_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_6_1 -p 834 -st topic349_6_0 -pt topic349_6_1 -u 0.03855419806991042 > ./result_8chains/node349_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_7_1 -p 921 -st topic349_7_0 -pt topic349_7_1 -u 0.013893056808935485 > ./result_8chains/node349_7_1.txt &
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
    "./result_8chains/node349_0_1.txt 90"
    "./result_8chains/node349_1_1.txt 89"
    "./result_8chains/node349_2_1.txt 88"
    "./result_8chains/node349_3_1.txt 87"
    "./result_8chains/node349_4_1.txt 86"
    "./result_8chains/node349_5_1.txt 85"
    "./result_8chains/node349_6_1.txt 84"
    "./result_8chains/node349_7_1.txt 83"
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
