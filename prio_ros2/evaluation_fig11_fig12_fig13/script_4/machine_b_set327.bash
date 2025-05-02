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
ros2 run evaluation_3_randomdag uunifast_node -n node327_0_1 -p 160 -st topic327_0_0 -pt topic327_0_1 -u 0.01474736259463627 > ./result_4chains/node327_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_1_1 -p 577 -st topic327_1_0 -pt topic327_1_1 -u 0.012148267601244295 > ./result_4chains/node327_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_2_1 -p 764 -st topic327_2_0 -pt topic327_2_1 -u 0.006186462443762558 > ./result_4chains/node327_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_3_1 -p 947 -st topic327_3_0 -pt topic327_3_1 -u 0.04992814576579396 > ./result_4chains/node327_3_1.txt &
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
    "./result_4chains/node327_0_1.txt 90"
    "./result_4chains/node327_1_1.txt 89"
    "./result_4chains/node327_2_1.txt 88"
    "./result_4chains/node327_3_1.txt 87"
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
