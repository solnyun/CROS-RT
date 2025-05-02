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
ros2 run evaluation_3_randomdag uunifast_node -n node60_0_1 -p 274 -st topic60_0_0 -pt topic60_0_1 -u 0.008562699086072156 > ./result_8chains/node60_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_1_1 -p 583 -st topic60_1_0 -pt topic60_1_1 -u 0.004476595068602707 > ./result_8chains/node60_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_2_1 -p 702 -st topic60_2_0 -pt topic60_2_1 -u 0.005548083886358801 > ./result_8chains/node60_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_3_1 -p 735 -st topic60_3_0 -pt topic60_3_1 -u 0.006071812939485943 > ./result_8chains/node60_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_4_1 -p 809 -st topic60_4_0 -pt topic60_4_1 -u 0.007309067683589576 > ./result_8chains/node60_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_5_1 -p 883 -st topic60_5_0 -pt topic60_5_1 -u 0.046322475115618836 > ./result_8chains/node60_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_6_1 -p 908 -st topic60_6_0 -pt topic60_6_1 -u 0.0036447549501296347 > ./result_8chains/node60_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_7_1 -p 945 -st topic60_7_0 -pt topic60_7_1 -u 0.03450570180598529 > ./result_8chains/node60_7_1.txt &
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
    "./result_8chains/node60_0_1.txt 90"
    "./result_8chains/node60_1_1.txt 89"
    "./result_8chains/node60_2_1.txt 88"
    "./result_8chains/node60_3_1.txt 87"
    "./result_8chains/node60_4_1.txt 86"
    "./result_8chains/node60_5_1.txt 85"
    "./result_8chains/node60_6_1.txt 84"
    "./result_8chains/node60_7_1.txt 83"
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
