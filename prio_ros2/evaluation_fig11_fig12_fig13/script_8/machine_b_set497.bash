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
ros2 run evaluation_3_randomdag uunifast_node -n node497_0_1 -p 17 -st topic497_0_0 -pt topic497_0_1 -u 0.0159601664179731 > ./result_8chains/node497_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_1_1 -p 280 -st topic497_1_0 -pt topic497_1_1 -u 0.03077886687528475 > ./result_8chains/node497_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_2_1 -p 286 -st topic497_2_0 -pt topic497_2_1 -u 0.0025564314424236234 > ./result_8chains/node497_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_3_1 -p 292 -st topic497_3_0 -pt topic497_3_1 -u 0.0006581276348748832 > ./result_8chains/node497_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_4_1 -p 423 -st topic497_4_0 -pt topic497_4_1 -u 0.02255318290387956 > ./result_8chains/node497_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_5_1 -p 722 -st topic497_5_0 -pt topic497_5_1 -u 0.0015736073907341441 > ./result_8chains/node497_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_6_1 -p 866 -st topic497_6_0 -pt topic497_6_1 -u 0.036899421004770866 > ./result_8chains/node497_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_7_1 -p 971 -st topic497_7_0 -pt topic497_7_1 -u 0.011098518033291795 > ./result_8chains/node497_7_1.txt &
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
    "./result_8chains/node497_0_1.txt 90"
    "./result_8chains/node497_1_1.txt 89"
    "./result_8chains/node497_2_1.txt 88"
    "./result_8chains/node497_3_1.txt 87"
    "./result_8chains/node497_4_1.txt 86"
    "./result_8chains/node497_5_1.txt 85"
    "./result_8chains/node497_6_1.txt 84"
    "./result_8chains/node497_7_1.txt 83"
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
