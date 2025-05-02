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
ros2 run evaluation_3_randomdag uunifast_node -n node440_0_1 -p 22 -st topic440_0_0 -pt topic440_0_1 -u 0.03295192632649541 > ./result_10chains/node440_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_1_1 -p 35 -st topic440_1_0 -pt topic440_1_1 -u 0.02392411586949067 > ./result_10chains/node440_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_2_1 -p 124 -st topic440_2_0 -pt topic440_2_1 -u 0.022900652480832173 > ./result_10chains/node440_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_3_1 -p 208 -st topic440_3_0 -pt topic440_3_1 -u 0.02449617317113173 > ./result_10chains/node440_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_4_1 -p 755 -st topic440_4_0 -pt topic440_4_1 -u 0.007515162686808713 > ./result_10chains/node440_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_5_1 -p 791 -st topic440_5_0 -pt topic440_5_1 -u 0.007146602192131535 > ./result_10chains/node440_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_6_1 -p 845 -st topic440_6_0 -pt topic440_6_1 -u 0.001482095223885982 > ./result_10chains/node440_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_7_1 -p 867 -st topic440_7_0 -pt topic440_7_1 -u 0.019949170290214147 > ./result_10chains/node440_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_8_1 -p 894 -st topic440_8_0 -pt topic440_8_1 -u 0.01192243027812876 > ./result_10chains/node440_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_9_1 -p 960 -st topic440_9_0 -pt topic440_9_1 -u 0.0033775490488214483 > ./result_10chains/node440_9_1.txt &
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
    "./result_10chains/node440_0_1.txt 90"
    "./result_10chains/node440_1_1.txt 89"
    "./result_10chains/node440_2_1.txt 88"
    "./result_10chains/node440_3_1.txt 87"
    "./result_10chains/node440_4_1.txt 86"
    "./result_10chains/node440_5_1.txt 85"
    "./result_10chains/node440_6_1.txt 84"
    "./result_10chains/node440_7_1.txt 83"
    "./result_10chains/node440_8_1.txt 82"
    "./result_10chains/node440_9_1.txt 81"
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
