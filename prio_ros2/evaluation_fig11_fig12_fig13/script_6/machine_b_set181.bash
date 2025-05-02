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
ros2 run evaluation_3_randomdag uunifast_node -n node181_0_1 -p 35 -st topic181_0_0 -pt topic181_0_1 -u 0.0615217765683197 > ./result_6chains/node181_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_1_1 -p 410 -st topic181_1_0 -pt topic181_1_1 -u 0.014632952070609273 > ./result_6chains/node181_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_2_1 -p 499 -st topic181_2_0 -pt topic181_2_1 -u 0.054677404818143455 > ./result_6chains/node181_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_3_1 -p 566 -st topic181_3_0 -pt topic181_3_1 -u 0.023746135735138424 > ./result_6chains/node181_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_4_1 -p 807 -st topic181_4_0 -pt topic181_4_1 -u 0.018975356234079616 > ./result_6chains/node181_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_5_1 -p 918 -st topic181_5_0 -pt topic181_5_1 -u 0.0020973375873983707 > ./result_6chains/node181_5_1.txt &
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
    "./result_6chains/node181_0_1.txt 90"
    "./result_6chains/node181_1_1.txt 89"
    "./result_6chains/node181_2_1.txt 88"
    "./result_6chains/node181_3_1.txt 87"
    "./result_6chains/node181_4_1.txt 86"
    "./result_6chains/node181_5_1.txt 85"
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
