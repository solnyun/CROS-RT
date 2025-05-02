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
ros2 run evaluation_3_randomdag uunifast_node -n node261_0_1 -p 72 -st topic261_0_0 -pt topic261_0_1 -u 0.03599813993093476 > ./result_10chains/node261_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_1_1 -p 103 -st topic261_1_0 -pt topic261_1_1 -u 0.00697571563978594 > ./result_10chains/node261_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_2_1 -p 133 -st topic261_2_0 -pt topic261_2_1 -u 0.015489551964019688 > ./result_10chains/node261_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_3_1 -p 142 -st topic261_3_0 -pt topic261_3_1 -u 0.016850357938762883 > ./result_10chains/node261_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_4_1 -p 211 -st topic261_4_0 -pt topic261_4_1 -u 0.024081862980049606 > ./result_10chains/node261_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_5_1 -p 299 -st topic261_5_0 -pt topic261_5_1 -u 0.006604391986380076 > ./result_10chains/node261_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_6_1 -p 393 -st topic261_6_0 -pt topic261_6_1 -u 0.027386717721899545 > ./result_10chains/node261_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_7_1 -p 534 -st topic261_7_0 -pt topic261_7_1 -u 0.00492842941168628 > ./result_10chains/node261_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_8_1 -p 678 -st topic261_8_0 -pt topic261_8_1 -u 0.019561250245401715 > ./result_10chains/node261_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_9_1 -p 691 -st topic261_9_0 -pt topic261_9_1 -u 0.005451076623918465 > ./result_10chains/node261_9_1.txt &
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
    "./result_10chains/node261_0_1.txt 90"
    "./result_10chains/node261_1_1.txt 89"
    "./result_10chains/node261_2_1.txt 88"
    "./result_10chains/node261_3_1.txt 87"
    "./result_10chains/node261_4_1.txt 86"
    "./result_10chains/node261_5_1.txt 85"
    "./result_10chains/node261_6_1.txt 84"
    "./result_10chains/node261_7_1.txt 83"
    "./result_10chains/node261_8_1.txt 82"
    "./result_10chains/node261_9_1.txt 81"
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
