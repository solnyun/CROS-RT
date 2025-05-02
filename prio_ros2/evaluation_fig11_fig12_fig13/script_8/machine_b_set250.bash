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
ros2 run evaluation_3_randomdag uunifast_node -n node250_0_1 -p 161 -st topic250_0_0 -pt topic250_0_1 -u 0.012080900640687176 > ./result_8chains/node250_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_1_1 -p 197 -st topic250_1_0 -pt topic250_1_1 -u 0.007785482239968999 > ./result_8chains/node250_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_2_1 -p 285 -st topic250_2_0 -pt topic250_2_1 -u 0.01923269534327182 > ./result_8chains/node250_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_3_1 -p 295 -st topic250_3_0 -pt topic250_3_1 -u 0.03521895574085543 > ./result_8chains/node250_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_4_1 -p 572 -st topic250_4_0 -pt topic250_4_1 -u 0.002848968324555612 > ./result_8chains/node250_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_5_1 -p 631 -st topic250_5_0 -pt topic250_5_1 -u 0.023255678513434186 > ./result_8chains/node250_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_6_1 -p 887 -st topic250_6_0 -pt topic250_6_1 -u 0.01868956877011635 > ./result_8chains/node250_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_7_1 -p 977 -st topic250_7_0 -pt topic250_7_1 -u 0.07248015037407868 > ./result_8chains/node250_7_1.txt &
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
    "./result_8chains/node250_0_1.txt 90"
    "./result_8chains/node250_1_1.txt 89"
    "./result_8chains/node250_2_1.txt 88"
    "./result_8chains/node250_3_1.txt 87"
    "./result_8chains/node250_4_1.txt 86"
    "./result_8chains/node250_5_1.txt 85"
    "./result_8chains/node250_6_1.txt 84"
    "./result_8chains/node250_7_1.txt 83"
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
