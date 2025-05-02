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
ros2 run evaluation_3_randomdag uunifast_node -n node67_0_1 -p 62 -st topic67_0_0 -pt topic67_0_1 -u 0.030960531376025724 > ./result_6chains/node67_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_1_1 -p 270 -st topic67_1_0 -pt topic67_1_1 -u 0.01685894416574185 > ./result_6chains/node67_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_2_1 -p 438 -st topic67_2_0 -pt topic67_2_1 -u 0.013428504570075883 > ./result_6chains/node67_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_3_1 -p 470 -st topic67_3_0 -pt topic67_3_1 -u 0.014567845034768212 > ./result_6chains/node67_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_4_1 -p 721 -st topic67_4_0 -pt topic67_4_1 -u 0.0982336651831458 > ./result_6chains/node67_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_5_1 -p 833 -st topic67_5_0 -pt topic67_5_1 -u 0.007669388203972956 > ./result_6chains/node67_5_1.txt &
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
    "./result_6chains/node67_0_1.txt 90"
    "./result_6chains/node67_1_1.txt 89"
    "./result_6chains/node67_2_1.txt 88"
    "./result_6chains/node67_3_1.txt 87"
    "./result_6chains/node67_4_1.txt 86"
    "./result_6chains/node67_5_1.txt 85"
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
