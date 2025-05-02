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
ros2 run evaluation_3_randomdag uunifast_node -n node389_0_1 -p 16 -st topic389_0_0 -pt topic389_0_1 -u 0.0008886141562631233 > ./result_10chains/node389_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_1_1 -p 60 -st topic389_1_0 -pt topic389_1_1 -u 0.00017969898195635547 > ./result_10chains/node389_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_2_1 -p 209 -st topic389_2_0 -pt topic389_2_1 -u 0.024529415851447967 > ./result_10chains/node389_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_3_1 -p 411 -st topic389_3_0 -pt topic389_3_1 -u 0.027814497855512932 > ./result_10chains/node389_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_4_1 -p 508 -st topic389_4_0 -pt topic389_4_1 -u 0.0040705805551728425 > ./result_10chains/node389_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_5_1 -p 533 -st topic389_5_0 -pt topic389_5_1 -u 0.007962237291484875 > ./result_10chains/node389_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_6_1 -p 727 -st topic389_6_0 -pt topic389_6_1 -u 0.016847935884619553 > ./result_10chains/node389_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_7_1 -p 738 -st topic389_7_0 -pt topic389_7_1 -u 0.008257551324387102 > ./result_10chains/node389_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_8_1 -p 809 -st topic389_8_0 -pt topic389_8_1 -u 0.001794089307366964 > ./result_10chains/node389_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_9_1 -p 923 -st topic389_9_0 -pt topic389_9_1 -u 0.00337364643469705 > ./result_10chains/node389_9_1.txt &
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
    "./result_10chains/node389_0_1.txt 90"
    "./result_10chains/node389_1_1.txt 89"
    "./result_10chains/node389_2_1.txt 88"
    "./result_10chains/node389_3_1.txt 87"
    "./result_10chains/node389_4_1.txt 86"
    "./result_10chains/node389_5_1.txt 85"
    "./result_10chains/node389_6_1.txt 84"
    "./result_10chains/node389_7_1.txt 83"
    "./result_10chains/node389_8_1.txt 82"
    "./result_10chains/node389_9_1.txt 81"
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
