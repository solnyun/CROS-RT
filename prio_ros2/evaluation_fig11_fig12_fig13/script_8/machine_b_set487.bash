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
ros2 run evaluation_3_randomdag uunifast_node -n node487_0_1 -p 25 -st topic487_0_0 -pt topic487_0_1 -u 0.0019807077644998783 > ./result_8chains/node487_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_1_1 -p 106 -st topic487_1_0 -pt topic487_1_1 -u 0.010219878249108916 > ./result_8chains/node487_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_2_1 -p 181 -st topic487_2_0 -pt topic487_2_1 -u 0.07397696344379001 > ./result_8chains/node487_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_3_1 -p 413 -st topic487_3_0 -pt topic487_3_1 -u 0.006082561232607364 > ./result_8chains/node487_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_4_1 -p 579 -st topic487_4_0 -pt topic487_4_1 -u 0.009361685108600026 > ./result_8chains/node487_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_5_1 -p 739 -st topic487_5_0 -pt topic487_5_1 -u 0.005607787160472361 > ./result_8chains/node487_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_6_1 -p 815 -st topic487_6_0 -pt topic487_6_1 -u 0.03568347183429499 > ./result_8chains/node487_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_7_1 -p 854 -st topic487_7_0 -pt topic487_7_1 -u 0.05145628681612507 > ./result_8chains/node487_7_1.txt &
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
    "./result_8chains/node487_0_1.txt 90"
    "./result_8chains/node487_1_1.txt 89"
    "./result_8chains/node487_2_1.txt 88"
    "./result_8chains/node487_3_1.txt 87"
    "./result_8chains/node487_4_1.txt 86"
    "./result_8chains/node487_5_1.txt 85"
    "./result_8chains/node487_6_1.txt 84"
    "./result_8chains/node487_7_1.txt 83"
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
