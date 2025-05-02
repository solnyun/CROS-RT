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
ros2 run evaluation_3_randomdag uunifast_node -n node213_0_1 -p 48 -st topic213_0_0 -pt topic213_0_1 -u 0.015032292714355133 > ./result_6chains/node213_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_1_1 -p 140 -st topic213_1_0 -pt topic213_1_1 -u 0.002795020935741188 > ./result_6chains/node213_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_2_1 -p 206 -st topic213_2_0 -pt topic213_2_1 -u 0.019903786638987175 > ./result_6chains/node213_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_3_1 -p 442 -st topic213_3_0 -pt topic213_3_1 -u 0.03858031261967243 > ./result_6chains/node213_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_4_1 -p 926 -st topic213_4_0 -pt topic213_4_1 -u 0.024722848605120945 > ./result_6chains/node213_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_5_1 -p 990 -st topic213_5_0 -pt topic213_5_1 -u 0.010619398954391686 > ./result_6chains/node213_5_1.txt &
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
    "./result_6chains/node213_0_1.txt 90"
    "./result_6chains/node213_1_1.txt 89"
    "./result_6chains/node213_2_1.txt 88"
    "./result_6chains/node213_3_1.txt 87"
    "./result_6chains/node213_4_1.txt 86"
    "./result_6chains/node213_5_1.txt 85"
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
