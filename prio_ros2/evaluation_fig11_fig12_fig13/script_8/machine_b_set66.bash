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
ros2 run evaluation_3_randomdag uunifast_node -n node66_0_1 -p 307 -st topic66_0_0 -pt topic66_0_1 -u 0.04250400836585294 > ./result_8chains/node66_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_1_1 -p 358 -st topic66_1_0 -pt topic66_1_1 -u 0.008936614505542784 > ./result_8chains/node66_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_2_1 -p 391 -st topic66_2_0 -pt topic66_2_1 -u 0.028856573207922842 > ./result_8chains/node66_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_3_1 -p 415 -st topic66_3_0 -pt topic66_3_1 -u 0.005806537604737816 > ./result_8chains/node66_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_4_1 -p 429 -st topic66_4_0 -pt topic66_4_1 -u 0.00968031370893982 > ./result_8chains/node66_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_5_1 -p 675 -st topic66_5_0 -pt topic66_5_1 -u 0.0007919795191601298 > ./result_8chains/node66_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_6_1 -p 807 -st topic66_6_0 -pt topic66_6_1 -u 0.014856364696803459 > ./result_8chains/node66_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_7_1 -p 844 -st topic66_7_0 -pt topic66_7_1 -u 0.031716038939461746 > ./result_8chains/node66_7_1.txt &
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
    "./result_8chains/node66_0_1.txt 90"
    "./result_8chains/node66_1_1.txt 89"
    "./result_8chains/node66_2_1.txt 88"
    "./result_8chains/node66_3_1.txt 87"
    "./result_8chains/node66_4_1.txt 86"
    "./result_8chains/node66_5_1.txt 85"
    "./result_8chains/node66_6_1.txt 84"
    "./result_8chains/node66_7_1.txt 83"
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
