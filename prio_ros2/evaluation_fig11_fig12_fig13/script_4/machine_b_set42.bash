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
ros2 run evaluation_3_randomdag uunifast_node -n node42_0_1 -p 352 -st topic42_0_0 -pt topic42_0_1 -u 0.0836449777198931 > ./result_4chains/node42_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node42_1_1 -p 479 -st topic42_1_0 -pt topic42_1_1 -u 0.034562095046503066 > ./result_4chains/node42_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node42_2_1 -p 777 -st topic42_2_0 -pt topic42_2_1 -u 0.09232803427627027 > ./result_4chains/node42_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node42_3_1 -p 862 -st topic42_3_0 -pt topic42_3_1 -u 0.002480766302646563 > ./result_4chains/node42_3_1.txt &
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
    "./result_4chains/node42_0_1.txt 90"
    "./result_4chains/node42_1_1.txt 89"
    "./result_4chains/node42_2_1.txt 88"
    "./result_4chains/node42_3_1.txt 87"
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
