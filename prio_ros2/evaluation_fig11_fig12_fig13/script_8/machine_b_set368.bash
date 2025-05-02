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
ros2 run evaluation_3_randomdag uunifast_node -n node368_0_1 -p 253 -st topic368_0_0 -pt topic368_0_1 -u 0.020043415937116504 > ./result_8chains/node368_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_1_1 -p 329 -st topic368_1_0 -pt topic368_1_1 -u 0.007541816099992216 > ./result_8chains/node368_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_2_1 -p 402 -st topic368_2_0 -pt topic368_2_1 -u 0.028669760836650682 > ./result_8chains/node368_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_3_1 -p 466 -st topic368_3_0 -pt topic368_3_1 -u 0.015186651980726495 > ./result_8chains/node368_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_4_1 -p 556 -st topic368_4_0 -pt topic368_4_1 -u 0.0050654983227129136 > ./result_8chains/node368_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_5_1 -p 641 -st topic368_5_0 -pt topic368_5_1 -u 0.018231897251014123 > ./result_8chains/node368_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_6_1 -p 798 -st topic368_6_0 -pt topic368_6_1 -u 0.004200832105815233 > ./result_8chains/node368_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_7_1 -p 836 -st topic368_7_0 -pt topic368_7_1 -u 0.02420473186409413 > ./result_8chains/node368_7_1.txt &
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
    "./result_8chains/node368_0_1.txt 90"
    "./result_8chains/node368_1_1.txt 89"
    "./result_8chains/node368_2_1.txt 88"
    "./result_8chains/node368_3_1.txt 87"
    "./result_8chains/node368_4_1.txt 86"
    "./result_8chains/node368_5_1.txt 85"
    "./result_8chains/node368_6_1.txt 84"
    "./result_8chains/node368_7_1.txt 83"
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
