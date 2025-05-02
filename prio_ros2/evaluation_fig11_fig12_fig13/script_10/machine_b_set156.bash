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
ros2 run evaluation_3_randomdag uunifast_node -n node156_0_1 -p 123 -st topic156_0_0 -pt topic156_0_1 -u 0.05796832926406853 > ./result_10chains/node156_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_1_1 -p 203 -st topic156_1_0 -pt topic156_1_1 -u 0.004698889681930718 > ./result_10chains/node156_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_2_1 -p 352 -st topic156_2_0 -pt topic156_2_1 -u 0.00014209919332391907 > ./result_10chains/node156_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_3_1 -p 366 -st topic156_3_0 -pt topic156_3_1 -u 0.022836468827068135 > ./result_10chains/node156_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_4_1 -p 424 -st topic156_4_0 -pt topic156_4_1 -u 0.00873181170097792 > ./result_10chains/node156_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_5_1 -p 523 -st topic156_5_0 -pt topic156_5_1 -u 0.006342087926544171 > ./result_10chains/node156_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_6_1 -p 616 -st topic156_6_0 -pt topic156_6_1 -u 0.015414103241141758 > ./result_10chains/node156_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_7_1 -p 617 -st topic156_7_0 -pt topic156_7_1 -u 0.025983614642097655 > ./result_10chains/node156_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_8_1 -p 901 -st topic156_8_0 -pt topic156_8_1 -u 0.0006426133855877703 > ./result_10chains/node156_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_9_1 -p 999 -st topic156_9_0 -pt topic156_9_1 -u 0.0057089951609257394 > ./result_10chains/node156_9_1.txt &
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
    "./result_10chains/node156_0_1.txt 90"
    "./result_10chains/node156_1_1.txt 89"
    "./result_10chains/node156_2_1.txt 88"
    "./result_10chains/node156_3_1.txt 87"
    "./result_10chains/node156_4_1.txt 86"
    "./result_10chains/node156_5_1.txt 85"
    "./result_10chains/node156_6_1.txt 84"
    "./result_10chains/node156_7_1.txt 83"
    "./result_10chains/node156_8_1.txt 82"
    "./result_10chains/node156_9_1.txt 81"
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
