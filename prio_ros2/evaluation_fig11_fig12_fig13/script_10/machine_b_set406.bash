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
ros2 run evaluation_3_randomdag uunifast_node -n node406_0_1 -p 49 -st topic406_0_0 -pt topic406_0_1 -u 0.009155368116771256 > ./result_10chains/node406_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_1_1 -p 51 -st topic406_1_0 -pt topic406_1_1 -u 0.011080537702979232 > ./result_10chains/node406_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_2_1 -p 74 -st topic406_2_0 -pt topic406_2_1 -u 0.0068123960002867134 > ./result_10chains/node406_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_3_1 -p 96 -st topic406_3_0 -pt topic406_3_1 -u 0.02757569912915897 > ./result_10chains/node406_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_4_1 -p 299 -st topic406_4_0 -pt topic406_4_1 -u 0.021177791817173663 > ./result_10chains/node406_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_5_1 -p 513 -st topic406_5_0 -pt topic406_5_1 -u 0.003615929492842007 > ./result_10chains/node406_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_6_1 -p 514 -st topic406_6_0 -pt topic406_6_1 -u 0.027180022225733985 > ./result_10chains/node406_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_7_1 -p 614 -st topic406_7_0 -pt topic406_7_1 -u 0.04835491864595291 > ./result_10chains/node406_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_8_1 -p 657 -st topic406_8_0 -pt topic406_8_1 -u 0.007609989102709935 > ./result_10chains/node406_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_9_1 -p 703 -st topic406_9_0 -pt topic406_9_1 -u 0.01562432980702154 > ./result_10chains/node406_9_1.txt &
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
    "./result_10chains/node406_0_1.txt 90"
    "./result_10chains/node406_1_1.txt 89"
    "./result_10chains/node406_2_1.txt 88"
    "./result_10chains/node406_3_1.txt 87"
    "./result_10chains/node406_4_1.txt 86"
    "./result_10chains/node406_5_1.txt 85"
    "./result_10chains/node406_6_1.txt 84"
    "./result_10chains/node406_7_1.txt 83"
    "./result_10chains/node406_8_1.txt 82"
    "./result_10chains/node406_9_1.txt 81"
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
