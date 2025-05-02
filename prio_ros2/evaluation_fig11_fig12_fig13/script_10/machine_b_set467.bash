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
ros2 run evaluation_3_randomdag uunifast_node -n node467_0_1 -p 57 -st topic467_0_0 -pt topic467_0_1 -u 0.02508772642102647 > ./result_10chains/node467_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_1_1 -p 66 -st topic467_1_0 -pt topic467_1_1 -u 0.014126187717613092 > ./result_10chains/node467_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_2_1 -p 104 -st topic467_2_0 -pt topic467_2_1 -u 0.03111875509370804 > ./result_10chains/node467_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_3_1 -p 145 -st topic467_3_0 -pt topic467_3_1 -u 0.009330602538509092 > ./result_10chains/node467_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_4_1 -p 236 -st topic467_4_0 -pt topic467_4_1 -u 0.010608203183954806 > ./result_10chains/node467_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_5_1 -p 284 -st topic467_5_0 -pt topic467_5_1 -u 0.01394214830826393 > ./result_10chains/node467_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_6_1 -p 423 -st topic467_6_0 -pt topic467_6_1 -u 0.014993130262385301 > ./result_10chains/node467_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_7_1 -p 448 -st topic467_7_0 -pt topic467_7_1 -u 0.003093974297538632 > ./result_10chains/node467_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_8_1 -p 838 -st topic467_8_0 -pt topic467_8_1 -u 0.039594806083920304 > ./result_10chains/node467_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_9_1 -p 886 -st topic467_9_0 -pt topic467_9_1 -u 0.0021125198738701466 > ./result_10chains/node467_9_1.txt &
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
    "./result_10chains/node467_0_1.txt 90"
    "./result_10chains/node467_1_1.txt 89"
    "./result_10chains/node467_2_1.txt 88"
    "./result_10chains/node467_3_1.txt 87"
    "./result_10chains/node467_4_1.txt 86"
    "./result_10chains/node467_5_1.txt 85"
    "./result_10chains/node467_6_1.txt 84"
    "./result_10chains/node467_7_1.txt 83"
    "./result_10chains/node467_8_1.txt 82"
    "./result_10chains/node467_9_1.txt 81"
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
