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
ros2 run evaluation_3_randomdag uunifast_node -n node219_0_1 -p 52 -st topic219_0_0 -pt topic219_0_1 -u 0.011730256080412504 > ./result_8chains/node219_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_1_1 -p 320 -st topic219_1_0 -pt topic219_1_1 -u 0.023090647026222655 > ./result_8chains/node219_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_2_1 -p 438 -st topic219_2_0 -pt topic219_2_1 -u 0.0034873210270526256 > ./result_8chains/node219_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_3_1 -p 655 -st topic219_3_0 -pt topic219_3_1 -u 0.0027485051937649885 > ./result_8chains/node219_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_4_1 -p 670 -st topic219_4_0 -pt topic219_4_1 -u 0.009336078001405262 > ./result_8chains/node219_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_5_1 -p 683 -st topic219_5_0 -pt topic219_5_1 -u 0.07152265824348848 > ./result_8chains/node219_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_6_1 -p 860 -st topic219_6_0 -pt topic219_6_1 -u 0.03687459005627286 > ./result_8chains/node219_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_7_1 -p 896 -st topic219_7_0 -pt topic219_7_1 -u 0.0011190616592032286 > ./result_8chains/node219_7_1.txt &
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
    "./result_8chains/node219_0_1.txt 90"
    "./result_8chains/node219_1_1.txt 89"
    "./result_8chains/node219_2_1.txt 88"
    "./result_8chains/node219_3_1.txt 87"
    "./result_8chains/node219_4_1.txt 86"
    "./result_8chains/node219_5_1.txt 85"
    "./result_8chains/node219_6_1.txt 84"
    "./result_8chains/node219_7_1.txt 83"
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
