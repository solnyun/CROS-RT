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
ros2 run evaluation_3_randomdag uunifast_node -n node8_0_1 -p 11 -st topic8_0_0 -pt topic8_0_1 -u 0.017493658187493877 > ./result_10chains/node8_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node8_1_1 -p 24 -st topic8_1_0 -pt topic8_1_1 -u 0.008571686294907732 > ./result_10chains/node8_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node8_2_1 -p 59 -st topic8_2_0 -pt topic8_2_1 -u 0.0042454022760184396 > ./result_10chains/node8_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node8_3_1 -p 69 -st topic8_3_0 -pt topic8_3_1 -u 0.042719709757841784 > ./result_10chains/node8_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node8_4_1 -p 246 -st topic8_4_0 -pt topic8_4_1 -u 0.004641560969683045 > ./result_10chains/node8_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node8_5_1 -p 372 -st topic8_5_0 -pt topic8_5_1 -u 0.02003023291031153 > ./result_10chains/node8_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node8_6_1 -p 456 -st topic8_6_0 -pt topic8_6_1 -u 0.016815903005945196 > ./result_10chains/node8_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node8_7_1 -p 516 -st topic8_7_0 -pt topic8_7_1 -u 0.02723488980951045 > ./result_10chains/node8_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node8_8_1 -p 802 -st topic8_8_0 -pt topic8_8_1 -u 0.011683443150982416 > ./result_10chains/node8_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node8_9_1 -p 938 -st topic8_9_0 -pt topic8_9_1 -u 0.02106728710893098 > ./result_10chains/node8_9_1.txt &
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
    "./result_10chains/node8_0_1.txt 90"
    "./result_10chains/node8_1_1.txt 89"
    "./result_10chains/node8_2_1.txt 88"
    "./result_10chains/node8_3_1.txt 87"
    "./result_10chains/node8_4_1.txt 86"
    "./result_10chains/node8_5_1.txt 85"
    "./result_10chains/node8_6_1.txt 84"
    "./result_10chains/node8_7_1.txt 83"
    "./result_10chains/node8_8_1.txt 82"
    "./result_10chains/node8_9_1.txt 81"
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
