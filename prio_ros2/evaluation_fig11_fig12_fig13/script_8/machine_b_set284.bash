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
ros2 run evaluation_3_randomdag uunifast_node -n node284_0_1 -p 39 -st topic284_0_0 -pt topic284_0_1 -u 0.010581727021024723 > ./result_8chains/node284_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_1_1 -p 58 -st topic284_1_0 -pt topic284_1_1 -u 0.015744471801460158 > ./result_8chains/node284_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_2_1 -p 133 -st topic284_2_0 -pt topic284_2_1 -u 0.0285126079053602 > ./result_8chains/node284_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_3_1 -p 174 -st topic284_3_0 -pt topic284_3_1 -u 0.0076129760784299505 > ./result_8chains/node284_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_4_1 -p 282 -st topic284_4_0 -pt topic284_4_1 -u 0.02680435144751414 > ./result_8chains/node284_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_5_1 -p 305 -st topic284_5_0 -pt topic284_5_1 -u 0.020344979690663928 > ./result_8chains/node284_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_6_1 -p 487 -st topic284_6_0 -pt topic284_6_1 -u 0.007465280036304839 > ./result_8chains/node284_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_7_1 -p 808 -st topic284_7_0 -pt topic284_7_1 -u 0.040677209761395446 > ./result_8chains/node284_7_1.txt &
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
    "./result_8chains/node284_0_1.txt 90"
    "./result_8chains/node284_1_1.txt 89"
    "./result_8chains/node284_2_1.txt 88"
    "./result_8chains/node284_3_1.txt 87"
    "./result_8chains/node284_4_1.txt 86"
    "./result_8chains/node284_5_1.txt 85"
    "./result_8chains/node284_6_1.txt 84"
    "./result_8chains/node284_7_1.txt 83"
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
