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
ros2 run evaluation_3_randomdag uunifast_node -n node143_0_1 -p 167 -st topic143_0_0 -pt topic143_0_1 -u 0.0006154052065662774 > ./result_10chains/node143_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_1_1 -p 257 -st topic143_1_0 -pt topic143_1_1 -u 0.03268467273679915 > ./result_10chains/node143_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_2_1 -p 329 -st topic143_2_0 -pt topic143_2_1 -u 0.01466424893772561 > ./result_10chains/node143_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_3_1 -p 335 -st topic143_3_0 -pt topic143_3_1 -u 0.005656235270118715 > ./result_10chains/node143_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_4_1 -p 348 -st topic143_4_0 -pt topic143_4_1 -u 0.012894341535940962 > ./result_10chains/node143_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_5_1 -p 349 -st topic143_5_0 -pt topic143_5_1 -u 0.004524599776241173 > ./result_10chains/node143_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_6_1 -p 384 -st topic143_6_0 -pt topic143_6_1 -u 0.004063133807761132 > ./result_10chains/node143_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_7_1 -p 482 -st topic143_7_0 -pt topic143_7_1 -u 0.03745471244273102 > ./result_10chains/node143_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_8_1 -p 708 -st topic143_8_0 -pt topic143_8_1 -u 0.00028276880863982445 > ./result_10chains/node143_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_9_1 -p 906 -st topic143_9_0 -pt topic143_9_1 -u 0.01607483968969154 > ./result_10chains/node143_9_1.txt &
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
    "./result_10chains/node143_0_1.txt 90"
    "./result_10chains/node143_1_1.txt 89"
    "./result_10chains/node143_2_1.txt 88"
    "./result_10chains/node143_3_1.txt 87"
    "./result_10chains/node143_4_1.txt 86"
    "./result_10chains/node143_5_1.txt 85"
    "./result_10chains/node143_6_1.txt 84"
    "./result_10chains/node143_7_1.txt 83"
    "./result_10chains/node143_8_1.txt 82"
    "./result_10chains/node143_9_1.txt 81"
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
