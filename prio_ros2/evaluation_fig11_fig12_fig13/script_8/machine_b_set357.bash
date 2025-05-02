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
ros2 run evaluation_3_randomdag uunifast_node -n node357_0_1 -p 95 -st topic357_0_0 -pt topic357_0_1 -u 0.03830027585397 > ./result_8chains/node357_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_1_1 -p 264 -st topic357_1_0 -pt topic357_1_1 -u 0.027871005661017856 > ./result_8chains/node357_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_2_1 -p 618 -st topic357_2_0 -pt topic357_2_1 -u 0.020569184379148453 > ./result_8chains/node357_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_3_1 -p 637 -st topic357_3_0 -pt topic357_3_1 -u 0.008919514623535907 > ./result_8chains/node357_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_4_1 -p 803 -st topic357_4_0 -pt topic357_4_1 -u 0.04003375592321526 > ./result_8chains/node357_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_5_1 -p 805 -st topic357_5_0 -pt topic357_5_1 -u 0.0011499923239471077 > ./result_8chains/node357_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_6_1 -p 865 -st topic357_6_0 -pt topic357_6_1 -u 0.047218522594422704 > ./result_8chains/node357_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_7_1 -p 873 -st topic357_7_0 -pt topic357_7_1 -u 0.01418251284990239 > ./result_8chains/node357_7_1.txt &
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
    "./result_8chains/node357_0_1.txt 90"
    "./result_8chains/node357_1_1.txt 89"
    "./result_8chains/node357_2_1.txt 88"
    "./result_8chains/node357_3_1.txt 87"
    "./result_8chains/node357_4_1.txt 86"
    "./result_8chains/node357_5_1.txt 85"
    "./result_8chains/node357_6_1.txt 84"
    "./result_8chains/node357_7_1.txt 83"
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
