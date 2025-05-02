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
ros2 run evaluation_3_randomdag uunifast_node -n node270_0_1 -p 86 -st topic270_0_0 -pt topic270_0_1 -u 0.005575306574063854 > ./result_6chains/node270_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_1_1 -p 117 -st topic270_1_0 -pt topic270_1_1 -u 0.006598776107929416 > ./result_6chains/node270_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_2_1 -p 654 -st topic270_2_0 -pt topic270_2_1 -u 0.03878271511842357 > ./result_6chains/node270_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_3_1 -p 735 -st topic270_3_0 -pt topic270_3_1 -u 0.12373470556763486 > ./result_6chains/node270_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_4_1 -p 754 -st topic270_4_0 -pt topic270_4_1 -u 0.08254105707052843 > ./result_6chains/node270_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_5_1 -p 943 -st topic270_5_0 -pt topic270_5_1 -u 0.021331715145248013 > ./result_6chains/node270_5_1.txt &
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
    "./result_6chains/node270_0_1.txt 90"
    "./result_6chains/node270_1_1.txt 89"
    "./result_6chains/node270_2_1.txt 88"
    "./result_6chains/node270_3_1.txt 87"
    "./result_6chains/node270_4_1.txt 86"
    "./result_6chains/node270_5_1.txt 85"
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
