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
ros2 run evaluation_3_randomdag uunifast_node -n node162_0_1 -p 99 -st topic162_0_0 -pt topic162_0_1 -u 0.0313528657521584 > ./result_8chains/node162_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_1_1 -p 433 -st topic162_1_0 -pt topic162_1_1 -u 0.009109585440632617 > ./result_8chains/node162_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_2_1 -p 557 -st topic162_2_0 -pt topic162_2_1 -u 0.05561864205963851 > ./result_8chains/node162_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_3_1 -p 636 -st topic162_3_0 -pt topic162_3_1 -u 0.018023996456012326 > ./result_8chains/node162_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_4_1 -p 812 -st topic162_4_0 -pt topic162_4_1 -u 0.00858670995485844 > ./result_8chains/node162_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_5_1 -p 824 -st topic162_5_0 -pt topic162_5_1 -u 0.002711424862971795 > ./result_8chains/node162_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_6_1 -p 841 -st topic162_6_0 -pt topic162_6_1 -u 0.012122970550757034 > ./result_8chains/node162_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_7_1 -p 932 -st topic162_7_0 -pt topic162_7_1 -u 0.0013999160720390928 > ./result_8chains/node162_7_1.txt &
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
    "./result_8chains/node162_0_1.txt 90"
    "./result_8chains/node162_1_1.txt 89"
    "./result_8chains/node162_2_1.txt 88"
    "./result_8chains/node162_3_1.txt 87"
    "./result_8chains/node162_4_1.txt 86"
    "./result_8chains/node162_5_1.txt 85"
    "./result_8chains/node162_6_1.txt 84"
    "./result_8chains/node162_7_1.txt 83"
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
