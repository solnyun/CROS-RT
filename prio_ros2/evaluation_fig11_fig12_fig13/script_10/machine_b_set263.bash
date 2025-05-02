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
ros2 run evaluation_3_randomdag uunifast_node -n node263_0_1 -p 35 -st topic263_0_0 -pt topic263_0_1 -u 0.000620618733155609 > ./result_10chains/node263_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_1_1 -p 153 -st topic263_1_0 -pt topic263_1_1 -u 0.019251935833970613 > ./result_10chains/node263_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_2_1 -p 175 -st topic263_2_0 -pt topic263_2_1 -u 0.0011753146141101345 > ./result_10chains/node263_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_3_1 -p 183 -st topic263_3_0 -pt topic263_3_1 -u 0.0006211241595050487 > ./result_10chains/node263_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_4_1 -p 424 -st topic263_4_0 -pt topic263_4_1 -u 0.009066138563057935 > ./result_10chains/node263_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_5_1 -p 572 -st topic263_5_0 -pt topic263_5_1 -u 0.008475787469027385 > ./result_10chains/node263_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_6_1 -p 596 -st topic263_6_0 -pt topic263_6_1 -u 0.002907145588323612 > ./result_10chains/node263_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_7_1 -p 640 -st topic263_7_0 -pt topic263_7_1 -u 0.01859384513226514 > ./result_10chains/node263_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_8_1 -p 883 -st topic263_8_0 -pt topic263_8_1 -u 0.0015340032023604955 > ./result_10chains/node263_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_9_1 -p 998 -st topic263_9_0 -pt topic263_9_1 -u 0.01368891937570997 > ./result_10chains/node263_9_1.txt &
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
    "./result_10chains/node263_0_1.txt 90"
    "./result_10chains/node263_1_1.txt 89"
    "./result_10chains/node263_2_1.txt 88"
    "./result_10chains/node263_3_1.txt 87"
    "./result_10chains/node263_4_1.txt 86"
    "./result_10chains/node263_5_1.txt 85"
    "./result_10chains/node263_6_1.txt 84"
    "./result_10chains/node263_7_1.txt 83"
    "./result_10chains/node263_8_1.txt 82"
    "./result_10chains/node263_9_1.txt 81"
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
