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
ros2 run evaluation_3_randomdag uunifast_node -n node202_0_1 -p 330 -st topic202_0_0 -pt topic202_0_1 -u 0.004470280262144799 > ./result_4chains/node202_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_1_1 -p 343 -st topic202_1_0 -pt topic202_1_1 -u 0.03302360927448761 > ./result_4chains/node202_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_2_1 -p 505 -st topic202_2_0 -pt topic202_2_1 -u 0.004268160908638657 > ./result_4chains/node202_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_3_1 -p 869 -st topic202_3_0 -pt topic202_3_1 -u 0.0578084734030237 > ./result_4chains/node202_3_1.txt &
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
    "./result_4chains/node202_0_1.txt 90"
    "./result_4chains/node202_1_1.txt 89"
    "./result_4chains/node202_2_1.txt 88"
    "./result_4chains/node202_3_1.txt 87"
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
