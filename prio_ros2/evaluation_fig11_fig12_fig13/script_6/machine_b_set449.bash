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
ros2 run evaluation_3_randomdag uunifast_node -n node449_0_1 -p 34 -st topic449_0_0 -pt topic449_0_1 -u 0.04890309678007382 > ./result_6chains/node449_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_1_1 -p 63 -st topic449_1_0 -pt topic449_1_1 -u 0.022228136608712812 > ./result_6chains/node449_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_2_1 -p 304 -st topic449_2_0 -pt topic449_2_1 -u 0.0014046667620833952 > ./result_6chains/node449_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_3_1 -p 708 -st topic449_3_0 -pt topic449_3_1 -u 0.0690042143665035 > ./result_6chains/node449_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_4_1 -p 790 -st topic449_4_0 -pt topic449_4_1 -u 0.015945848112625477 > ./result_6chains/node449_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_5_1 -p 929 -st topic449_5_0 -pt topic449_5_1 -u 0.006865504822690945 > ./result_6chains/node449_5_1.txt &
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
    "./result_6chains/node449_0_1.txt 90"
    "./result_6chains/node449_1_1.txt 89"
    "./result_6chains/node449_2_1.txt 88"
    "./result_6chains/node449_3_1.txt 87"
    "./result_6chains/node449_4_1.txt 86"
    "./result_6chains/node449_5_1.txt 85"
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
