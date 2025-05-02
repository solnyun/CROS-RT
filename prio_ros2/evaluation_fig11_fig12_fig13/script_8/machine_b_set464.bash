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
ros2 run evaluation_3_randomdag uunifast_node -n node464_0_1 -p 30 -st topic464_0_0 -pt topic464_0_1 -u 0.04774059853059337 > ./result_8chains/node464_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_1_1 -p 133 -st topic464_1_0 -pt topic464_1_1 -u 0.0073470141501519315 > ./result_8chains/node464_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_2_1 -p 376 -st topic464_2_0 -pt topic464_2_1 -u 0.002747855896873097 > ./result_8chains/node464_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_3_1 -p 458 -st topic464_3_0 -pt topic464_3_1 -u 0.014126491275122388 > ./result_8chains/node464_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_4_1 -p 530 -st topic464_4_0 -pt topic464_4_1 -u 0.0059016413248313415 > ./result_8chains/node464_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_5_1 -p 567 -st topic464_5_0 -pt topic464_5_1 -u 0.004481695634924079 > ./result_8chains/node464_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_6_1 -p 594 -st topic464_6_0 -pt topic464_6_1 -u 0.021974153439191086 > ./result_8chains/node464_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_7_1 -p 978 -st topic464_7_0 -pt topic464_7_1 -u 0.00759491664154705 > ./result_8chains/node464_7_1.txt &
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
    "./result_8chains/node464_0_1.txt 90"
    "./result_8chains/node464_1_1.txt 89"
    "./result_8chains/node464_2_1.txt 88"
    "./result_8chains/node464_3_1.txt 87"
    "./result_8chains/node464_4_1.txt 86"
    "./result_8chains/node464_5_1.txt 85"
    "./result_8chains/node464_6_1.txt 84"
    "./result_8chains/node464_7_1.txt 83"
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
