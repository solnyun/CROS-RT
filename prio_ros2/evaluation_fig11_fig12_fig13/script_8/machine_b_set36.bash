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
ros2 run evaluation_3_randomdag uunifast_node -n node36_0_1 -p 35 -st topic36_0_0 -pt topic36_0_1 -u 0.014709182011274746 > ./result_8chains/node36_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node36_1_1 -p 125 -st topic36_1_0 -pt topic36_1_1 -u 0.034246879844326006 > ./result_8chains/node36_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node36_2_1 -p 177 -st topic36_2_0 -pt topic36_2_1 -u 0.011097910299610658 > ./result_8chains/node36_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node36_3_1 -p 233 -st topic36_3_0 -pt topic36_3_1 -u 0.01971054603921424 > ./result_8chains/node36_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node36_4_1 -p 460 -st topic36_4_0 -pt topic36_4_1 -u 0.015085662592018767 > ./result_8chains/node36_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node36_5_1 -p 798 -st topic36_5_0 -pt topic36_5_1 -u 0.0031018475846255195 > ./result_8chains/node36_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node36_6_1 -p 902 -st topic36_6_0 -pt topic36_6_1 -u 0.003021052475657853 > ./result_8chains/node36_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node36_7_1 -p 908 -st topic36_7_0 -pt topic36_7_1 -u 0.00901478097301746 > ./result_8chains/node36_7_1.txt &
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
    "./result_8chains/node36_0_1.txt 90"
    "./result_8chains/node36_1_1.txt 89"
    "./result_8chains/node36_2_1.txt 88"
    "./result_8chains/node36_3_1.txt 87"
    "./result_8chains/node36_4_1.txt 86"
    "./result_8chains/node36_5_1.txt 85"
    "./result_8chains/node36_6_1.txt 84"
    "./result_8chains/node36_7_1.txt 83"
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
