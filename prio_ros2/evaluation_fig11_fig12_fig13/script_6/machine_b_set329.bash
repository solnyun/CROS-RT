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
ros2 run evaluation_3_randomdag uunifast_node -n node329_0_1 -p 77 -st topic329_0_0 -pt topic329_0_1 -u 0.00940907312920325 > ./result_6chains/node329_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_1_1 -p 628 -st topic329_1_0 -pt topic329_1_1 -u 0.047988014928560196 > ./result_6chains/node329_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_2_1 -p 633 -st topic329_2_0 -pt topic329_2_1 -u 0.018330336760147947 > ./result_6chains/node329_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_3_1 -p 636 -st topic329_3_0 -pt topic329_3_1 -u 0.08675452531865585 > ./result_6chains/node329_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_4_1 -p 783 -st topic329_4_0 -pt topic329_4_1 -u 0.0020892683115582705 > ./result_6chains/node329_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_5_1 -p 894 -st topic329_5_0 -pt topic329_5_1 -u 0.032147021782630736 > ./result_6chains/node329_5_1.txt &
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
    "./result_6chains/node329_0_1.txt 90"
    "./result_6chains/node329_1_1.txt 89"
    "./result_6chains/node329_2_1.txt 88"
    "./result_6chains/node329_3_1.txt 87"
    "./result_6chains/node329_4_1.txt 86"
    "./result_6chains/node329_5_1.txt 85"
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
