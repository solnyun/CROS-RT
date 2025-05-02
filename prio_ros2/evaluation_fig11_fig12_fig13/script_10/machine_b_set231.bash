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
ros2 run evaluation_3_randomdag uunifast_node -n node231_0_1 -p 92 -st topic231_0_0 -pt topic231_0_1 -u 0.002965004086591727 > ./result_10chains/node231_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_1_1 -p 184 -st topic231_1_0 -pt topic231_1_1 -u 0.010950356072211676 > ./result_10chains/node231_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_2_1 -p 219 -st topic231_2_0 -pt topic231_2_1 -u 0.06555314945488766 > ./result_10chains/node231_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_3_1 -p 563 -st topic231_3_0 -pt topic231_3_1 -u 0.019570417993929834 > ./result_10chains/node231_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_4_1 -p 674 -st topic231_4_0 -pt topic231_4_1 -u 0.0011182819054916249 > ./result_10chains/node231_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_5_1 -p 724 -st topic231_5_0 -pt topic231_5_1 -u 0.029745275745390543 > ./result_10chains/node231_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_6_1 -p 754 -st topic231_6_0 -pt topic231_6_1 -u 0.009092505431580689 > ./result_10chains/node231_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_7_1 -p 825 -st topic231_7_0 -pt topic231_7_1 -u 0.028664229401458186 > ./result_10chains/node231_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_8_1 -p 914 -st topic231_8_0 -pt topic231_8_1 -u 0.042232638985788315 > ./result_10chains/node231_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_9_1 -p 992 -st topic231_9_0 -pt topic231_9_1 -u 0.04785124998373981 > ./result_10chains/node231_9_1.txt &
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
    "./result_10chains/node231_0_1.txt 90"
    "./result_10chains/node231_1_1.txt 89"
    "./result_10chains/node231_2_1.txt 88"
    "./result_10chains/node231_3_1.txt 87"
    "./result_10chains/node231_4_1.txt 86"
    "./result_10chains/node231_5_1.txt 85"
    "./result_10chains/node231_6_1.txt 84"
    "./result_10chains/node231_7_1.txt 83"
    "./result_10chains/node231_8_1.txt 82"
    "./result_10chains/node231_9_1.txt 81"
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
