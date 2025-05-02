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
ros2 run evaluation_3_randomdag uunifast_node -n node98_0_1 -p 141 -st topic98_0_0 -pt topic98_0_1 -u 0.009599886801972046 > ./result_10chains/node98_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_1_1 -p 170 -st topic98_1_0 -pt topic98_1_1 -u 0.007216689001483756 > ./result_10chains/node98_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_2_1 -p 229 -st topic98_2_0 -pt topic98_2_1 -u 8.758011909021368e-05 > ./result_10chains/node98_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_3_1 -p 273 -st topic98_3_0 -pt topic98_3_1 -u 0.02617812488276139 > ./result_10chains/node98_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_4_1 -p 468 -st topic98_4_0 -pt topic98_4_1 -u 0.002943507610582874 > ./result_10chains/node98_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_5_1 -p 474 -st topic98_5_0 -pt topic98_5_1 -u 0.015982775431635787 > ./result_10chains/node98_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_6_1 -p 539 -st topic98_6_0 -pt topic98_6_1 -u 0.029842925946776316 > ./result_10chains/node98_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_7_1 -p 544 -st topic98_7_0 -pt topic98_7_1 -u 0.03269355429382123 > ./result_10chains/node98_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_8_1 -p 588 -st topic98_8_0 -pt topic98_8_1 -u 0.0020957306440783363 > ./result_10chains/node98_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_9_1 -p 895 -st topic98_9_0 -pt topic98_9_1 -u 0.011701315656202083 > ./result_10chains/node98_9_1.txt &
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
    "./result_10chains/node98_0_1.txt 90"
    "./result_10chains/node98_1_1.txt 89"
    "./result_10chains/node98_2_1.txt 88"
    "./result_10chains/node98_3_1.txt 87"
    "./result_10chains/node98_4_1.txt 86"
    "./result_10chains/node98_5_1.txt 85"
    "./result_10chains/node98_6_1.txt 84"
    "./result_10chains/node98_7_1.txt 83"
    "./result_10chains/node98_8_1.txt 82"
    "./result_10chains/node98_9_1.txt 81"
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
