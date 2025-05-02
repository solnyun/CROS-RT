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
ros2 run evaluation_3_randomdag uunifast_node -n node227_0_1 -p 57 -st topic227_0_0 -pt topic227_0_1 -u 0.01641504360048096 > ./result_10chains/node227_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_1_1 -p 216 -st topic227_1_0 -pt topic227_1_1 -u 0.012292220036263013 > ./result_10chains/node227_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_2_1 -p 544 -st topic227_2_0 -pt topic227_2_1 -u 0.003089350899517229 > ./result_10chains/node227_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_3_1 -p 596 -st topic227_3_0 -pt topic227_3_1 -u 0.005211837684711229 > ./result_10chains/node227_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_4_1 -p 613 -st topic227_4_0 -pt topic227_4_1 -u 0.0070634823237070155 > ./result_10chains/node227_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_5_1 -p 753 -st topic227_5_0 -pt topic227_5_1 -u 0.009937181964407404 > ./result_10chains/node227_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_6_1 -p 783 -st topic227_6_0 -pt topic227_6_1 -u 2.0086483324854854e-05 > ./result_10chains/node227_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_7_1 -p 870 -st topic227_7_0 -pt topic227_7_1 -u 0.0037394782102556923 > ./result_10chains/node227_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_8_1 -p 910 -st topic227_8_0 -pt topic227_8_1 -u 0.00801441199441072 > ./result_10chains/node227_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_9_1 -p 974 -st topic227_9_0 -pt topic227_9_1 -u 0.024832857334815647 > ./result_10chains/node227_9_1.txt &
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
    "./result_10chains/node227_0_1.txt 90"
    "./result_10chains/node227_1_1.txt 89"
    "./result_10chains/node227_2_1.txt 88"
    "./result_10chains/node227_3_1.txt 87"
    "./result_10chains/node227_4_1.txt 86"
    "./result_10chains/node227_5_1.txt 85"
    "./result_10chains/node227_6_1.txt 84"
    "./result_10chains/node227_7_1.txt 83"
    "./result_10chains/node227_8_1.txt 82"
    "./result_10chains/node227_9_1.txt 81"
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
