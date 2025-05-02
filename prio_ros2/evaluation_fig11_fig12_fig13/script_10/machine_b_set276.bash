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
ros2 run evaluation_3_randomdag uunifast_node -n node276_0_1 -p 189 -st topic276_0_0 -pt topic276_0_1 -u 0.004268492185551642 > ./result_10chains/node276_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_1_1 -p 190 -st topic276_1_0 -pt topic276_1_1 -u 0.008206732276706652 > ./result_10chains/node276_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_2_1 -p 223 -st topic276_2_0 -pt topic276_2_1 -u 0.0033109856082533806 > ./result_10chains/node276_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_3_1 -p 246 -st topic276_3_0 -pt topic276_3_1 -u 0.010111250905983749 > ./result_10chains/node276_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_4_1 -p 295 -st topic276_4_0 -pt topic276_4_1 -u 0.044256609817523385 > ./result_10chains/node276_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_5_1 -p 470 -st topic276_5_0 -pt topic276_5_1 -u 0.015082778005370334 > ./result_10chains/node276_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_6_1 -p 670 -st topic276_6_0 -pt topic276_6_1 -u 0.005067422296667956 > ./result_10chains/node276_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_7_1 -p 737 -st topic276_7_0 -pt topic276_7_1 -u 0.027597537452274168 > ./result_10chains/node276_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_8_1 -p 822 -st topic276_8_0 -pt topic276_8_1 -u 0.0020238044404823213 > ./result_10chains/node276_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_9_1 -p 893 -st topic276_9_0 -pt topic276_9_1 -u 0.008662205263568222 > ./result_10chains/node276_9_1.txt &
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
    "./result_10chains/node276_0_1.txt 90"
    "./result_10chains/node276_1_1.txt 89"
    "./result_10chains/node276_2_1.txt 88"
    "./result_10chains/node276_3_1.txt 87"
    "./result_10chains/node276_4_1.txt 86"
    "./result_10chains/node276_5_1.txt 85"
    "./result_10chains/node276_6_1.txt 84"
    "./result_10chains/node276_7_1.txt 83"
    "./result_10chains/node276_8_1.txt 82"
    "./result_10chains/node276_9_1.txt 81"
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
