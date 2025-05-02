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
ros2 run evaluation_3_randomdag uunifast_node -n node94_0_1 -p 167 -st topic94_0_0 -pt topic94_0_1 -u 0.01517629155192124 > ./result_6chains/node94_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_1_1 -p 359 -st topic94_1_0 -pt topic94_1_1 -u 0.01336780298174628 > ./result_6chains/node94_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_2_1 -p 428 -st topic94_2_0 -pt topic94_2_1 -u 0.03570005330039122 > ./result_6chains/node94_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_3_1 -p 492 -st topic94_3_0 -pt topic94_3_1 -u 0.008656135381762187 > ./result_6chains/node94_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_4_1 -p 820 -st topic94_4_0 -pt topic94_4_1 -u 0.00944319704967203 > ./result_6chains/node94_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_5_1 -p 944 -st topic94_5_0 -pt topic94_5_1 -u 0.007321348280091372 > ./result_6chains/node94_5_1.txt &
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
    "./result_6chains/node94_0_1.txt 90"
    "./result_6chains/node94_1_1.txt 89"
    "./result_6chains/node94_2_1.txt 88"
    "./result_6chains/node94_3_1.txt 87"
    "./result_6chains/node94_4_1.txt 86"
    "./result_6chains/node94_5_1.txt 85"
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
