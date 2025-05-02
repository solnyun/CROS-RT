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
ros2 run evaluation_3_randomdag uunifast_node -n node301_0_1 -p 15 -st topic301_0_0 -pt topic301_0_1 -u 0.019113120973218323 > ./result_10chains/node301_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_1_1 -p 94 -st topic301_1_0 -pt topic301_1_1 -u 0.06294430985492655 > ./result_10chains/node301_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_2_1 -p 133 -st topic301_2_0 -pt topic301_2_1 -u 5.760239350671714e-06 > ./result_10chains/node301_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_3_1 -p 502 -st topic301_3_0 -pt topic301_3_1 -u 0.006948762424480559 > ./result_10chains/node301_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_4_1 -p 547 -st topic301_4_0 -pt topic301_4_1 -u 0.007511595720676778 > ./result_10chains/node301_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_5_1 -p 569 -st topic301_5_0 -pt topic301_5_1 -u 0.0058184848685635115 > ./result_10chains/node301_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_6_1 -p 682 -st topic301_6_0 -pt topic301_6_1 -u 0.0059649640504263746 > ./result_10chains/node301_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_7_1 -p 756 -st topic301_7_0 -pt topic301_7_1 -u 0.014435141758357695 > ./result_10chains/node301_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_8_1 -p 942 -st topic301_8_0 -pt topic301_8_1 -u 0.02784388408477552 > ./result_10chains/node301_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_9_1 -p 959 -st topic301_9_0 -pt topic301_9_1 -u 0.0036760943663491728 > ./result_10chains/node301_9_1.txt &
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
    "./result_10chains/node301_0_1.txt 90"
    "./result_10chains/node301_1_1.txt 89"
    "./result_10chains/node301_2_1.txt 88"
    "./result_10chains/node301_3_1.txt 87"
    "./result_10chains/node301_4_1.txt 86"
    "./result_10chains/node301_5_1.txt 85"
    "./result_10chains/node301_6_1.txt 84"
    "./result_10chains/node301_7_1.txt 83"
    "./result_10chains/node301_8_1.txt 82"
    "./result_10chains/node301_9_1.txt 81"
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
