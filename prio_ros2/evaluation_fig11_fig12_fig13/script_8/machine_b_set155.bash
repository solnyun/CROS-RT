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
ros2 run evaluation_3_randomdag uunifast_node -n node155_0_1 -p 19 -st topic155_0_0 -pt topic155_0_1 -u 0.017468453854767862 > ./result_8chains/node155_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_1_1 -p 242 -st topic155_1_0 -pt topic155_1_1 -u 0.046731762241519426 > ./result_8chains/node155_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_2_1 -p 309 -st topic155_2_0 -pt topic155_2_1 -u 0.003294254939483765 > ./result_8chains/node155_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_3_1 -p 426 -st topic155_3_0 -pt topic155_3_1 -u 0.001404004177224416 > ./result_8chains/node155_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_4_1 -p 580 -st topic155_4_0 -pt topic155_4_1 -u 0.049112842805555 > ./result_8chains/node155_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_5_1 -p 724 -st topic155_5_0 -pt topic155_5_1 -u 0.0013810073833942504 > ./result_8chains/node155_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_6_1 -p 811 -st topic155_6_0 -pt topic155_6_1 -u 0.00895697688035725 > ./result_8chains/node155_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_7_1 -p 875 -st topic155_7_0 -pt topic155_7_1 -u 0.043729331505005166 > ./result_8chains/node155_7_1.txt &
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
    "./result_8chains/node155_0_1.txt 90"
    "./result_8chains/node155_1_1.txt 89"
    "./result_8chains/node155_2_1.txt 88"
    "./result_8chains/node155_3_1.txt 87"
    "./result_8chains/node155_4_1.txt 86"
    "./result_8chains/node155_5_1.txt 85"
    "./result_8chains/node155_6_1.txt 84"
    "./result_8chains/node155_7_1.txt 83"
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
