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
ros2 run evaluation_3_randomdag uunifast_node -n node203_0_1 -p 64 -st topic203_0_0 -pt topic203_0_1 -u 0.006870451896653973 > ./result_8chains/node203_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_1_1 -p 174 -st topic203_1_0 -pt topic203_1_1 -u 0.022322883624099676 > ./result_8chains/node203_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_2_1 -p 195 -st topic203_2_0 -pt topic203_2_1 -u 0.0033980178842616393 > ./result_8chains/node203_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_3_1 -p 269 -st topic203_3_0 -pt topic203_3_1 -u 0.0033508173836544197 > ./result_8chains/node203_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_4_1 -p 438 -st topic203_4_0 -pt topic203_4_1 -u 0.015496902176025201 > ./result_8chains/node203_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_5_1 -p 688 -st topic203_5_0 -pt topic203_5_1 -u 0.01823288117663044 > ./result_8chains/node203_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_6_1 -p 735 -st topic203_6_0 -pt topic203_6_1 -u 0.009695016114821778 > ./result_8chains/node203_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_7_1 -p 937 -st topic203_7_0 -pt topic203_7_1 -u 0.028700805857936176 > ./result_8chains/node203_7_1.txt &
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
    "./result_8chains/node203_0_1.txt 90"
    "./result_8chains/node203_1_1.txt 89"
    "./result_8chains/node203_2_1.txt 88"
    "./result_8chains/node203_3_1.txt 87"
    "./result_8chains/node203_4_1.txt 86"
    "./result_8chains/node203_5_1.txt 85"
    "./result_8chains/node203_6_1.txt 84"
    "./result_8chains/node203_7_1.txt 83"
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
