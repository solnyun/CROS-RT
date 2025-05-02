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
ros2 run evaluation_3_randomdag uunifast_node -n node440_0_1 -p 153 -st topic440_0_0 -pt topic440_0_1 -u 0.04066849386317822 > ./result_8chains/node440_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_1_1 -p 279 -st topic440_1_0 -pt topic440_1_1 -u 0.0008571096959633651 > ./result_8chains/node440_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_2_1 -p 305 -st topic440_2_0 -pt topic440_2_1 -u 0.0101753275635727 > ./result_8chains/node440_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_3_1 -p 405 -st topic440_3_0 -pt topic440_3_1 -u 0.01813810821339623 > ./result_8chains/node440_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_4_1 -p 582 -st topic440_4_0 -pt topic440_4_1 -u 0.02756236567764847 > ./result_8chains/node440_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_5_1 -p 653 -st topic440_5_0 -pt topic440_5_1 -u 0.04291841575491542 > ./result_8chains/node440_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_6_1 -p 763 -st topic440_6_0 -pt topic440_6_1 -u 0.011107694454490356 > ./result_8chains/node440_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_7_1 -p 970 -st topic440_7_0 -pt topic440_7_1 -u 0.00045117387492768155 > ./result_8chains/node440_7_1.txt &
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
    "./result_8chains/node440_0_1.txt 90"
    "./result_8chains/node440_1_1.txt 89"
    "./result_8chains/node440_2_1.txt 88"
    "./result_8chains/node440_3_1.txt 87"
    "./result_8chains/node440_4_1.txt 86"
    "./result_8chains/node440_5_1.txt 85"
    "./result_8chains/node440_6_1.txt 84"
    "./result_8chains/node440_7_1.txt 83"
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
