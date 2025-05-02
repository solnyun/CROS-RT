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
ros2 run evaluation_3_randomdag uunifast_node -n node291_0_1 -p 358 -st topic291_0_0 -pt topic291_0_1 -u 0.018757222287194675 > ./result_8chains/node291_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_1_1 -p 383 -st topic291_1_0 -pt topic291_1_1 -u 0.028057936236528302 > ./result_8chains/node291_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_2_1 -p 408 -st topic291_2_0 -pt topic291_2_1 -u 0.002859791801836098 > ./result_8chains/node291_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_3_1 -p 432 -st topic291_3_0 -pt topic291_3_1 -u 0.01382672198092505 > ./result_8chains/node291_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_4_1 -p 645 -st topic291_4_0 -pt topic291_4_1 -u 0.011960965133530066 > ./result_8chains/node291_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_5_1 -p 788 -st topic291_5_0 -pt topic291_5_1 -u 0.01023103013245441 > ./result_8chains/node291_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_6_1 -p 845 -st topic291_6_0 -pt topic291_6_1 -u 0.009122802846382172 > ./result_8chains/node291_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_7_1 -p 927 -st topic291_7_0 -pt topic291_7_1 -u 0.0076137690683544534 > ./result_8chains/node291_7_1.txt &
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
    "./result_8chains/node291_0_1.txt 90"
    "./result_8chains/node291_1_1.txt 89"
    "./result_8chains/node291_2_1.txt 88"
    "./result_8chains/node291_3_1.txt 87"
    "./result_8chains/node291_4_1.txt 86"
    "./result_8chains/node291_5_1.txt 85"
    "./result_8chains/node291_6_1.txt 84"
    "./result_8chains/node291_7_1.txt 83"
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
