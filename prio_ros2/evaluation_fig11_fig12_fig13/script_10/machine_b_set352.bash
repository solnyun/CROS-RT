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
ros2 run evaluation_3_randomdag uunifast_node -n node352_0_1 -p 192 -st topic352_0_0 -pt topic352_0_1 -u 0.005585008806327674 > ./result_10chains/node352_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_1_1 -p 233 -st topic352_1_0 -pt topic352_1_1 -u 0.0019109213712396045 > ./result_10chains/node352_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_2_1 -p 250 -st topic352_2_0 -pt topic352_2_1 -u 0.01785748358488015 > ./result_10chains/node352_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_3_1 -p 684 -st topic352_3_0 -pt topic352_3_1 -u 0.00793519507442858 > ./result_10chains/node352_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_4_1 -p 709 -st topic352_4_0 -pt topic352_4_1 -u 0.008521401284805163 > ./result_10chains/node352_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_5_1 -p 760 -st topic352_5_0 -pt topic352_5_1 -u 0.02259101041677869 > ./result_10chains/node352_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_6_1 -p 762 -st topic352_6_0 -pt topic352_6_1 -u 0.011333948892658624 > ./result_10chains/node352_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_7_1 -p 871 -st topic352_7_0 -pt topic352_7_1 -u 0.012810316895462137 > ./result_10chains/node352_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_8_1 -p 888 -st topic352_8_0 -pt topic352_8_1 -u 0.04950213487485661 > ./result_10chains/node352_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_9_1 -p 956 -st topic352_9_0 -pt topic352_9_1 -u 0.001071010355158844 > ./result_10chains/node352_9_1.txt &
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
    "./result_10chains/node352_0_1.txt 90"
    "./result_10chains/node352_1_1.txt 89"
    "./result_10chains/node352_2_1.txt 88"
    "./result_10chains/node352_3_1.txt 87"
    "./result_10chains/node352_4_1.txt 86"
    "./result_10chains/node352_5_1.txt 85"
    "./result_10chains/node352_6_1.txt 84"
    "./result_10chains/node352_7_1.txt 83"
    "./result_10chains/node352_8_1.txt 82"
    "./result_10chains/node352_9_1.txt 81"
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
