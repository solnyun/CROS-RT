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
ros2 run evaluation_3_randomdag uunifast_node -n node213_0_1 -p 203 -st topic213_0_0 -pt topic213_0_1 -u 0.0010929987588517709 > ./result_10chains/node213_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_1_1 -p 347 -st topic213_1_0 -pt topic213_1_1 -u 0.0395729877729914 > ./result_10chains/node213_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_2_1 -p 431 -st topic213_2_0 -pt topic213_2_1 -u 0.02142574305252065 > ./result_10chains/node213_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_3_1 -p 508 -st topic213_3_0 -pt topic213_3_1 -u 0.0014973669214797258 > ./result_10chains/node213_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_4_1 -p 535 -st topic213_4_0 -pt topic213_4_1 -u 0.008857738193349785 > ./result_10chains/node213_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_5_1 -p 580 -st topic213_5_0 -pt topic213_5_1 -u 0.061771919630427635 > ./result_10chains/node213_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_6_1 -p 590 -st topic213_6_0 -pt topic213_6_1 -u 0.014280811379964037 > ./result_10chains/node213_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_7_1 -p 717 -st topic213_7_0 -pt topic213_7_1 -u 0.008612600876154203 > ./result_10chains/node213_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_8_1 -p 719 -st topic213_8_0 -pt topic213_8_1 -u 0.02643813543808394 > ./result_10chains/node213_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_9_1 -p 821 -st topic213_9_0 -pt topic213_9_1 -u 0.0038491759664538716 > ./result_10chains/node213_9_1.txt &
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
    "./result_10chains/node213_0_1.txt 90"
    "./result_10chains/node213_1_1.txt 89"
    "./result_10chains/node213_2_1.txt 88"
    "./result_10chains/node213_3_1.txt 87"
    "./result_10chains/node213_4_1.txt 86"
    "./result_10chains/node213_5_1.txt 85"
    "./result_10chains/node213_6_1.txt 84"
    "./result_10chains/node213_7_1.txt 83"
    "./result_10chains/node213_8_1.txt 82"
    "./result_10chains/node213_9_1.txt 81"
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
