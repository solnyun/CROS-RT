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
ros2 run evaluation_3_randomdag uunifast_node -n node56_0_1 -p 12 -st topic56_0_0 -pt topic56_0_1 -u 0.010371224341076346 > ./result_10chains/node56_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_1_1 -p 41 -st topic56_1_0 -pt topic56_1_1 -u 0.0025678990107431687 > ./result_10chains/node56_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_2_1 -p 131 -st topic56_2_0 -pt topic56_2_1 -u 0.005158913292323819 > ./result_10chains/node56_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_3_1 -p 180 -st topic56_3_0 -pt topic56_3_1 -u 0.013447828427968711 > ./result_10chains/node56_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_4_1 -p 181 -st topic56_4_0 -pt topic56_4_1 -u 0.01319174286755842 > ./result_10chains/node56_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_5_1 -p 419 -st topic56_5_0 -pt topic56_5_1 -u 0.019075035866196688 > ./result_10chains/node56_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_6_1 -p 640 -st topic56_6_0 -pt topic56_6_1 -u 0.07022392489197143 > ./result_10chains/node56_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_7_1 -p 688 -st topic56_7_0 -pt topic56_7_1 -u 0.014646796325761574 > ./result_10chains/node56_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_8_1 -p 775 -st topic56_8_0 -pt topic56_8_1 -u 0.039224503929221485 > ./result_10chains/node56_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_9_1 -p 854 -st topic56_9_0 -pt topic56_9_1 -u 0.02026504402030349 > ./result_10chains/node56_9_1.txt &
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
    "./result_10chains/node56_0_1.txt 90"
    "./result_10chains/node56_1_1.txt 89"
    "./result_10chains/node56_2_1.txt 88"
    "./result_10chains/node56_3_1.txt 87"
    "./result_10chains/node56_4_1.txt 86"
    "./result_10chains/node56_5_1.txt 85"
    "./result_10chains/node56_6_1.txt 84"
    "./result_10chains/node56_7_1.txt 83"
    "./result_10chains/node56_8_1.txt 82"
    "./result_10chains/node56_9_1.txt 81"
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
