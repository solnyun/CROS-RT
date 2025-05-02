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
ros2 run evaluation_3_randomdag uunifast_node -n node221_0_1 -p 36 -st topic221_0_0 -pt topic221_0_1 -u 0.01975228338274071 > ./result_8chains/node221_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_1_1 -p 69 -st topic221_1_0 -pt topic221_1_1 -u 0.03585034622100419 > ./result_8chains/node221_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_2_1 -p 180 -st topic221_2_0 -pt topic221_2_1 -u 0.06576154948877011 > ./result_8chains/node221_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_3_1 -p 212 -st topic221_3_0 -pt topic221_3_1 -u 0.025843533807030306 > ./result_8chains/node221_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_4_1 -p 394 -st topic221_4_0 -pt topic221_4_1 -u 0.002396052116498737 > ./result_8chains/node221_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_5_1 -p 456 -st topic221_5_0 -pt topic221_5_1 -u 0.009538808995297549 > ./result_8chains/node221_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_6_1 -p 488 -st topic221_6_0 -pt topic221_6_1 -u 0.006539050200946202 > ./result_8chains/node221_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_7_1 -p 686 -st topic221_7_0 -pt topic221_7_1 -u 0.009362680819324152 > ./result_8chains/node221_7_1.txt &
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
    "./result_8chains/node221_0_1.txt 90"
    "./result_8chains/node221_1_1.txt 89"
    "./result_8chains/node221_2_1.txt 88"
    "./result_8chains/node221_3_1.txt 87"
    "./result_8chains/node221_4_1.txt 86"
    "./result_8chains/node221_5_1.txt 85"
    "./result_8chains/node221_6_1.txt 84"
    "./result_8chains/node221_7_1.txt 83"
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
