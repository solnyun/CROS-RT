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
ros2 run evaluation_3_randomdag uunifast_node -n node300_0_1 -p 274 -st topic300_0_0 -pt topic300_0_1 -u 0.015286435888232308 > ./result_8chains/node300_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_1_1 -p 389 -st topic300_1_0 -pt topic300_1_1 -u 0.004450897225819039 > ./result_8chains/node300_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_2_1 -p 563 -st topic300_2_0 -pt topic300_2_1 -u 0.0181571755659774 > ./result_8chains/node300_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_3_1 -p 719 -st topic300_3_0 -pt topic300_3_1 -u 0.010884922093703675 > ./result_8chains/node300_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_4_1 -p 756 -st topic300_4_0 -pt topic300_4_1 -u 0.027003472458720867 > ./result_8chains/node300_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_5_1 -p 811 -st topic300_5_0 -pt topic300_5_1 -u 0.05757360674634207 > ./result_8chains/node300_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_6_1 -p 868 -st topic300_6_0 -pt topic300_6_1 -u 0.021141359598657983 > ./result_8chains/node300_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_7_1 -p 961 -st topic300_7_0 -pt topic300_7_1 -u 0.01107796862343459 > ./result_8chains/node300_7_1.txt &
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
    "./result_8chains/node300_0_1.txt 90"
    "./result_8chains/node300_1_1.txt 89"
    "./result_8chains/node300_2_1.txt 88"
    "./result_8chains/node300_3_1.txt 87"
    "./result_8chains/node300_4_1.txt 86"
    "./result_8chains/node300_5_1.txt 85"
    "./result_8chains/node300_6_1.txt 84"
    "./result_8chains/node300_7_1.txt 83"
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
