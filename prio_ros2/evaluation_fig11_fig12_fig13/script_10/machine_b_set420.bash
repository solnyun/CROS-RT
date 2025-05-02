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
ros2 run evaluation_3_randomdag uunifast_node -n node420_0_1 -p 23 -st topic420_0_0 -pt topic420_0_1 -u 0.00757306214770842 > ./result_10chains/node420_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_1_1 -p 53 -st topic420_1_0 -pt topic420_1_1 -u 0.012597993634005877 > ./result_10chains/node420_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_2_1 -p 137 -st topic420_2_0 -pt topic420_2_1 -u 0.04651857891934419 > ./result_10chains/node420_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_3_1 -p 153 -st topic420_3_0 -pt topic420_3_1 -u 0.0008240386348801199 > ./result_10chains/node420_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_4_1 -p 196 -st topic420_4_0 -pt topic420_4_1 -u 0.02826742170456209 > ./result_10chains/node420_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_5_1 -p 315 -st topic420_5_0 -pt topic420_5_1 -u 0.036063783203829025 > ./result_10chains/node420_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_6_1 -p 340 -st topic420_6_0 -pt topic420_6_1 -u 0.039669692276259605 > ./result_10chains/node420_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_7_1 -p 791 -st topic420_7_0 -pt topic420_7_1 -u 0.03082211590216405 > ./result_10chains/node420_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_8_1 -p 793 -st topic420_8_0 -pt topic420_8_1 -u 0.0049811800693143615 > ./result_10chains/node420_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_9_1 -p 983 -st topic420_9_0 -pt topic420_9_1 -u 0.0013320024602399704 > ./result_10chains/node420_9_1.txt &
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
    "./result_10chains/node420_0_1.txt 90"
    "./result_10chains/node420_1_1.txt 89"
    "./result_10chains/node420_2_1.txt 88"
    "./result_10chains/node420_3_1.txt 87"
    "./result_10chains/node420_4_1.txt 86"
    "./result_10chains/node420_5_1.txt 85"
    "./result_10chains/node420_6_1.txt 84"
    "./result_10chains/node420_7_1.txt 83"
    "./result_10chains/node420_8_1.txt 82"
    "./result_10chains/node420_9_1.txt 81"
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
