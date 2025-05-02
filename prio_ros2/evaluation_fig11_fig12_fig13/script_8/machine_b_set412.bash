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
ros2 run evaluation_3_randomdag uunifast_node -n node412_0_1 -p 53 -st topic412_0_0 -pt topic412_0_1 -u 0.04721281504436703 > ./result_8chains/node412_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_1_1 -p 337 -st topic412_1_0 -pt topic412_1_1 -u 0.004748618986082642 > ./result_8chains/node412_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_2_1 -p 514 -st topic412_2_0 -pt topic412_2_1 -u 0.037396098071016126 > ./result_8chains/node412_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_3_1 -p 541 -st topic412_3_0 -pt topic412_3_1 -u 0.04524605556089595 > ./result_8chains/node412_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_4_1 -p 737 -st topic412_4_0 -pt topic412_4_1 -u 0.02763586877953067 > ./result_8chains/node412_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_5_1 -p 854 -st topic412_5_0 -pt topic412_5_1 -u 0.014465574463375958 > ./result_8chains/node412_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_6_1 -p 882 -st topic412_6_0 -pt topic412_6_1 -u 0.015647047845152584 > ./result_8chains/node412_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_7_1 -p 894 -st topic412_7_0 -pt topic412_7_1 -u 0.0419317209265026 > ./result_8chains/node412_7_1.txt &
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
    "./result_8chains/node412_0_1.txt 90"
    "./result_8chains/node412_1_1.txt 89"
    "./result_8chains/node412_2_1.txt 88"
    "./result_8chains/node412_3_1.txt 87"
    "./result_8chains/node412_4_1.txt 86"
    "./result_8chains/node412_5_1.txt 85"
    "./result_8chains/node412_6_1.txt 84"
    "./result_8chains/node412_7_1.txt 83"
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
