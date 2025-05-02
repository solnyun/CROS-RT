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
ros2 run evaluation_3_randomdag uunifast_node -n node212_0_1 -p 101 -st topic212_0_0 -pt topic212_0_1 -u 0.0014656536753213656 > ./result_8chains/node212_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_1_1 -p 233 -st topic212_1_0 -pt topic212_1_1 -u 0.002123660111552239 > ./result_8chains/node212_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_2_1 -p 240 -st topic212_2_0 -pt topic212_2_1 -u 0.001349391766461816 > ./result_8chains/node212_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_3_1 -p 372 -st topic212_3_0 -pt topic212_3_1 -u 0.004626319604520424 > ./result_8chains/node212_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_4_1 -p 419 -st topic212_4_0 -pt topic212_4_1 -u 0.05732350315448456 > ./result_8chains/node212_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_5_1 -p 420 -st topic212_5_0 -pt topic212_5_1 -u 0.02242477818039479 > ./result_8chains/node212_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_6_1 -p 879 -st topic212_6_0 -pt topic212_6_1 -u 0.006705901943858755 > ./result_8chains/node212_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_7_1 -p 905 -st topic212_7_0 -pt topic212_7_1 -u 0.004893010763774623 > ./result_8chains/node212_7_1.txt &
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
    "./result_8chains/node212_0_1.txt 90"
    "./result_8chains/node212_1_1.txt 89"
    "./result_8chains/node212_2_1.txt 88"
    "./result_8chains/node212_3_1.txt 87"
    "./result_8chains/node212_4_1.txt 86"
    "./result_8chains/node212_5_1.txt 85"
    "./result_8chains/node212_6_1.txt 84"
    "./result_8chains/node212_7_1.txt 83"
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
