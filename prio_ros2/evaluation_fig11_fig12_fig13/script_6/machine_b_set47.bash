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
ros2 run evaluation_3_randomdag uunifast_node -n node47_0_1 -p 32 -st topic47_0_0 -pt topic47_0_1 -u 0.038890328102145766 > ./result_6chains/node47_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node47_1_1 -p 118 -st topic47_1_0 -pt topic47_1_1 -u 0.013327611614300572 > ./result_6chains/node47_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node47_2_1 -p 182 -st topic47_2_0 -pt topic47_2_1 -u 0.06655458140317744 > ./result_6chains/node47_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node47_3_1 -p 270 -st topic47_3_0 -pt topic47_3_1 -u 0.0888864730198366 > ./result_6chains/node47_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node47_4_1 -p 427 -st topic47_4_0 -pt topic47_4_1 -u 0.0030257423851102055 > ./result_6chains/node47_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node47_5_1 -p 620 -st topic47_5_0 -pt topic47_5_1 -u 0.025010229662137624 > ./result_6chains/node47_5_1.txt &
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
    "./result_6chains/node47_0_1.txt 90"
    "./result_6chains/node47_1_1.txt 89"
    "./result_6chains/node47_2_1.txt 88"
    "./result_6chains/node47_3_1.txt 87"
    "./result_6chains/node47_4_1.txt 86"
    "./result_6chains/node47_5_1.txt 85"
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
