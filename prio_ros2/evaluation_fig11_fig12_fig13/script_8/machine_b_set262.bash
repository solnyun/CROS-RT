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
ros2 run evaluation_3_randomdag uunifast_node -n node262_0_1 -p 73 -st topic262_0_0 -pt topic262_0_1 -u 0.006013539426995063 > ./result_8chains/node262_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_1_1 -p 144 -st topic262_1_0 -pt topic262_1_1 -u 0.04451953030623623 > ./result_8chains/node262_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_2_1 -p 167 -st topic262_2_0 -pt topic262_2_1 -u 0.0010701855041702624 > ./result_8chains/node262_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_3_1 -p 264 -st topic262_3_0 -pt topic262_3_1 -u 0.009930163109724666 > ./result_8chains/node262_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_4_1 -p 409 -st topic262_4_0 -pt topic262_4_1 -u 0.013337758074327022 > ./result_8chains/node262_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_5_1 -p 457 -st topic262_5_0 -pt topic262_5_1 -u 0.025166497232153973 > ./result_8chains/node262_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_6_1 -p 591 -st topic262_6_0 -pt topic262_6_1 -u 0.08930317932977574 > ./result_8chains/node262_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_7_1 -p 749 -st topic262_7_0 -pt topic262_7_1 -u 0.009754051861700495 > ./result_8chains/node262_7_1.txt &
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
    "./result_8chains/node262_0_1.txt 90"
    "./result_8chains/node262_1_1.txt 89"
    "./result_8chains/node262_2_1.txt 88"
    "./result_8chains/node262_3_1.txt 87"
    "./result_8chains/node262_4_1.txt 86"
    "./result_8chains/node262_5_1.txt 85"
    "./result_8chains/node262_6_1.txt 84"
    "./result_8chains/node262_7_1.txt 83"
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
