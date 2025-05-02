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
ros2 run evaluation_3_randomdag uunifast_node -n node128_0_1 -p 15 -st topic128_0_0 -pt topic128_0_1 -u 0.02468992493982375 > ./result_10chains/node128_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_1_1 -p 228 -st topic128_1_0 -pt topic128_1_1 -u 0.00027326610793620976 > ./result_10chains/node128_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_2_1 -p 488 -st topic128_2_0 -pt topic128_2_1 -u 0.00016898623428562853 > ./result_10chains/node128_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_3_1 -p 508 -st topic128_3_0 -pt topic128_3_1 -u 0.012659143021968633 > ./result_10chains/node128_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_4_1 -p 524 -st topic128_4_0 -pt topic128_4_1 -u 0.07849698971318397 > ./result_10chains/node128_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_5_1 -p 545 -st topic128_5_0 -pt topic128_5_1 -u 0.02273491418598217 > ./result_10chains/node128_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_6_1 -p 799 -st topic128_6_0 -pt topic128_6_1 -u 0.05599084318173038 > ./result_10chains/node128_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_7_1 -p 827 -st topic128_7_0 -pt topic128_7_1 -u 0.004763512242638129 > ./result_10chains/node128_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_8_1 -p 830 -st topic128_8_0 -pt topic128_8_1 -u 0.0378020444333152 > ./result_10chains/node128_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_9_1 -p 860 -st topic128_9_0 -pt topic128_9_1 -u 0.009989699228132535 > ./result_10chains/node128_9_1.txt &
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
    "./result_10chains/node128_0_1.txt 90"
    "./result_10chains/node128_1_1.txt 89"
    "./result_10chains/node128_2_1.txt 88"
    "./result_10chains/node128_3_1.txt 87"
    "./result_10chains/node128_4_1.txt 86"
    "./result_10chains/node128_5_1.txt 85"
    "./result_10chains/node128_6_1.txt 84"
    "./result_10chains/node128_7_1.txt 83"
    "./result_10chains/node128_8_1.txt 82"
    "./result_10chains/node128_9_1.txt 81"
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
