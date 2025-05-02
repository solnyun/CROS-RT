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
ros2 run evaluation_3_randomdag uunifast_node -n node253_0_1 -p 141 -st topic253_0_0 -pt topic253_0_1 -u 0.0043197180770231935 > ./result_6chains/node253_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_1_1 -p 330 -st topic253_1_0 -pt topic253_1_1 -u 0.017935438421688377 > ./result_6chains/node253_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_2_1 -p 372 -st topic253_2_0 -pt topic253_2_1 -u 0.024179901645437984 > ./result_6chains/node253_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_3_1 -p 500 -st topic253_3_0 -pt topic253_3_1 -u 0.015564466113287018 > ./result_6chains/node253_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_4_1 -p 550 -st topic253_4_0 -pt topic253_4_1 -u 0.04525678986861671 > ./result_6chains/node253_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_5_1 -p 803 -st topic253_5_0 -pt topic253_5_1 -u 0.05159695417143731 > ./result_6chains/node253_5_1.txt &
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
    "./result_6chains/node253_0_1.txt 90"
    "./result_6chains/node253_1_1.txt 89"
    "./result_6chains/node253_2_1.txt 88"
    "./result_6chains/node253_3_1.txt 87"
    "./result_6chains/node253_4_1.txt 86"
    "./result_6chains/node253_5_1.txt 85"
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
