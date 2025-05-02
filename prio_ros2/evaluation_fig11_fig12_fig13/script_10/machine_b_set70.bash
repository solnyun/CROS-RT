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
ros2 run evaluation_3_randomdag uunifast_node -n node70_0_1 -p 96 -st topic70_0_0 -pt topic70_0_1 -u 0.020486944095757242 > ./result_10chains/node70_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_1_1 -p 184 -st topic70_1_0 -pt topic70_1_1 -u 0.013040074598038798 > ./result_10chains/node70_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_2_1 -p 407 -st topic70_2_0 -pt topic70_2_1 -u 0.015548417170288653 > ./result_10chains/node70_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_3_1 -p 413 -st topic70_3_0 -pt topic70_3_1 -u 0.07351171748122237 > ./result_10chains/node70_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_4_1 -p 446 -st topic70_4_0 -pt topic70_4_1 -u 0.006310824756495748 > ./result_10chains/node70_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_5_1 -p 472 -st topic70_5_0 -pt topic70_5_1 -u 0.007915613071858951 > ./result_10chains/node70_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_6_1 -p 513 -st topic70_6_0 -pt topic70_6_1 -u 0.020268630150841904 > ./result_10chains/node70_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_7_1 -p 719 -st topic70_7_0 -pt topic70_7_1 -u 0.011297828777888846 > ./result_10chains/node70_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_8_1 -p 858 -st topic70_8_0 -pt topic70_8_1 -u 0.0025809476124714487 > ./result_10chains/node70_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_9_1 -p 966 -st topic70_9_0 -pt topic70_9_1 -u 0.0011298577627530948 > ./result_10chains/node70_9_1.txt &
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
    "./result_10chains/node70_0_1.txt 90"
    "./result_10chains/node70_1_1.txt 89"
    "./result_10chains/node70_2_1.txt 88"
    "./result_10chains/node70_3_1.txt 87"
    "./result_10chains/node70_4_1.txt 86"
    "./result_10chains/node70_5_1.txt 85"
    "./result_10chains/node70_6_1.txt 84"
    "./result_10chains/node70_7_1.txt 83"
    "./result_10chains/node70_8_1.txt 82"
    "./result_10chains/node70_9_1.txt 81"
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
