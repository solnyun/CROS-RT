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
ros2 run evaluation_3_randomdag uunifast_node -n node49_0_1 -p 96 -st topic49_0_0 -pt topic49_0_1 -u 0.0023322671800293793 > ./result_8chains/node49_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node49_1_1 -p 201 -st topic49_1_0 -pt topic49_1_1 -u 0.03785975604911623 > ./result_8chains/node49_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node49_2_1 -p 355 -st topic49_2_0 -pt topic49_2_1 -u 0.01963330768991306 > ./result_8chains/node49_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node49_3_1 -p 536 -st topic49_3_0 -pt topic49_3_1 -u 0.015984654516507824 > ./result_8chains/node49_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node49_4_1 -p 625 -st topic49_4_0 -pt topic49_4_1 -u 0.006045210116317673 > ./result_8chains/node49_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node49_5_1 -p 810 -st topic49_5_0 -pt topic49_5_1 -u 0.02503178217477872 > ./result_8chains/node49_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node49_6_1 -p 836 -st topic49_6_0 -pt topic49_6_1 -u 0.04594943109194038 > ./result_8chains/node49_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node49_7_1 -p 990 -st topic49_7_0 -pt topic49_7_1 -u 0.002975532535679254 > ./result_8chains/node49_7_1.txt &
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
    "./result_8chains/node49_0_1.txt 90"
    "./result_8chains/node49_1_1.txt 89"
    "./result_8chains/node49_2_1.txt 88"
    "./result_8chains/node49_3_1.txt 87"
    "./result_8chains/node49_4_1.txt 86"
    "./result_8chains/node49_5_1.txt 85"
    "./result_8chains/node49_6_1.txt 84"
    "./result_8chains/node49_7_1.txt 83"
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
