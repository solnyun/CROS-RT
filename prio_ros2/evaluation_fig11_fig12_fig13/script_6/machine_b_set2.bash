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
ros2 run evaluation_3_randomdag uunifast_node -n node2_0_1 -p 14 -st topic2_0_0 -pt topic2_0_1 -u 0.020726401005928763 > ./result_6chains/node2_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node2_1_1 -p 273 -st topic2_1_0 -pt topic2_1_1 -u 0.0005981674345025834 > ./result_6chains/node2_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node2_2_1 -p 547 -st topic2_2_0 -pt topic2_2_1 -u 0.03183190401879901 > ./result_6chains/node2_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node2_3_1 -p 643 -st topic2_3_0 -pt topic2_3_1 -u 0.009776201987228117 > ./result_6chains/node2_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node2_4_1 -p 661 -st topic2_4_0 -pt topic2_4_1 -u 0.016436792030796107 > ./result_6chains/node2_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node2_5_1 -p 841 -st topic2_5_0 -pt topic2_5_1 -u 0.03568564748278433 > ./result_6chains/node2_5_1.txt &
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
    "./result_6chains/node2_0_1.txt 90"
    "./result_6chains/node2_1_1.txt 89"
    "./result_6chains/node2_2_1.txt 88"
    "./result_6chains/node2_3_1.txt 87"
    "./result_6chains/node2_4_1.txt 86"
    "./result_6chains/node2_5_1.txt 85"
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
