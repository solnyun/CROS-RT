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
ros2 run evaluation_3_randomdag uunifast_node -n node262_0_1 -p 140 -st topic262_0_0 -pt topic262_0_1 -u 0.000693147272447403 > ./result_10chains/node262_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_1_1 -p 253 -st topic262_1_0 -pt topic262_1_1 -u 0.04101185983015265 > ./result_10chains/node262_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_2_1 -p 282 -st topic262_2_0 -pt topic262_2_1 -u 0.02425382721673408 > ./result_10chains/node262_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_3_1 -p 378 -st topic262_3_0 -pt topic262_3_1 -u 0.01749465205088524 > ./result_10chains/node262_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_4_1 -p 435 -st topic262_4_0 -pt topic262_4_1 -u 0.0016886223828664337 > ./result_10chains/node262_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_5_1 -p 675 -st topic262_5_0 -pt topic262_5_1 -u 0.012052294631322957 > ./result_10chains/node262_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_6_1 -p 689 -st topic262_6_0 -pt topic262_6_1 -u 0.02608912251827833 > ./result_10chains/node262_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_7_1 -p 709 -st topic262_7_0 -pt topic262_7_1 -u 0.027436326972198666 > ./result_10chains/node262_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_8_1 -p 780 -st topic262_8_0 -pt topic262_8_1 -u 0.029558800983225456 > ./result_10chains/node262_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_9_1 -p 860 -st topic262_9_0 -pt topic262_9_1 -u 0.003381179082930376 > ./result_10chains/node262_9_1.txt &
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
    "./result_10chains/node262_0_1.txt 90"
    "./result_10chains/node262_1_1.txt 89"
    "./result_10chains/node262_2_1.txt 88"
    "./result_10chains/node262_3_1.txt 87"
    "./result_10chains/node262_4_1.txt 86"
    "./result_10chains/node262_5_1.txt 85"
    "./result_10chains/node262_6_1.txt 84"
    "./result_10chains/node262_7_1.txt 83"
    "./result_10chains/node262_8_1.txt 82"
    "./result_10chains/node262_9_1.txt 81"
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
