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
ros2 run evaluation_3_randomdag uunifast_node -n node221_0_1 -p 154 -st topic221_0_0 -pt topic221_0_1 -u 0.0024063555311611418 > ./result_10chains/node221_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_1_1 -p 163 -st topic221_1_0 -pt topic221_1_1 -u 0.012434092360021909 > ./result_10chains/node221_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_2_1 -p 222 -st topic221_2_0 -pt topic221_2_1 -u 0.012465956454419669 > ./result_10chains/node221_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_3_1 -p 272 -st topic221_3_0 -pt topic221_3_1 -u 0.020109707534559096 > ./result_10chains/node221_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_4_1 -p 298 -st topic221_4_0 -pt topic221_4_1 -u 0.0309009144518691 > ./result_10chains/node221_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_5_1 -p 375 -st topic221_5_0 -pt topic221_5_1 -u 0.0015215109073370148 > ./result_10chains/node221_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_6_1 -p 384 -st topic221_6_0 -pt topic221_6_1 -u 0.02903485536771991 > ./result_10chains/node221_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_7_1 -p 601 -st topic221_7_0 -pt topic221_7_1 -u 0.03633672837341151 > ./result_10chains/node221_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_8_1 -p 749 -st topic221_8_0 -pt topic221_8_1 -u 0.011674227117873595 > ./result_10chains/node221_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_9_1 -p 907 -st topic221_9_0 -pt topic221_9_1 -u 0.003488813752350592 > ./result_10chains/node221_9_1.txt &
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
    "./result_10chains/node221_0_1.txt 90"
    "./result_10chains/node221_1_1.txt 89"
    "./result_10chains/node221_2_1.txt 88"
    "./result_10chains/node221_3_1.txt 87"
    "./result_10chains/node221_4_1.txt 86"
    "./result_10chains/node221_5_1.txt 85"
    "./result_10chains/node221_6_1.txt 84"
    "./result_10chains/node221_7_1.txt 83"
    "./result_10chains/node221_8_1.txt 82"
    "./result_10chains/node221_9_1.txt 81"
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
