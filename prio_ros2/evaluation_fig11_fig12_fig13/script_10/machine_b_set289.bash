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
ros2 run evaluation_3_randomdag uunifast_node -n node289_0_1 -p 50 -st topic289_0_0 -pt topic289_0_1 -u 0.0062327376963030034 > ./result_10chains/node289_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_1_1 -p 92 -st topic289_1_0 -pt topic289_1_1 -u 0.0033691864232966995 > ./result_10chains/node289_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_2_1 -p 260 -st topic289_2_0 -pt topic289_2_1 -u 0.015064081136679675 > ./result_10chains/node289_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_3_1 -p 279 -st topic289_3_0 -pt topic289_3_1 -u 0.01608189684764455 > ./result_10chains/node289_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_4_1 -p 580 -st topic289_4_0 -pt topic289_4_1 -u 0.00356604155024115 > ./result_10chains/node289_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_5_1 -p 661 -st topic289_5_0 -pt topic289_5_1 -u 0.09910508977590982 > ./result_10chains/node289_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_6_1 -p 717 -st topic289_6_0 -pt topic289_6_1 -u 0.010497250023500465 > ./result_10chains/node289_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_7_1 -p 864 -st topic289_7_0 -pt topic289_7_1 -u 0.011844820987454943 > ./result_10chains/node289_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_8_1 -p 924 -st topic289_8_0 -pt topic289_8_1 -u 0.005664786917640725 > ./result_10chains/node289_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_9_1 -p 973 -st topic289_9_0 -pt topic289_9_1 -u 0.02163004727595455 > ./result_10chains/node289_9_1.txt &
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
    "./result_10chains/node289_0_1.txt 90"
    "./result_10chains/node289_1_1.txt 89"
    "./result_10chains/node289_2_1.txt 88"
    "./result_10chains/node289_3_1.txt 87"
    "./result_10chains/node289_4_1.txt 86"
    "./result_10chains/node289_5_1.txt 85"
    "./result_10chains/node289_6_1.txt 84"
    "./result_10chains/node289_7_1.txt 83"
    "./result_10chains/node289_8_1.txt 82"
    "./result_10chains/node289_9_1.txt 81"
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
