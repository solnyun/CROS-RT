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
ros2 run evaluation_3_randomdag uunifast_node -n node460_0_1 -p 109 -st topic460_0_0 -pt topic460_0_1 -u 0.037654456505356926 > ./result_10chains/node460_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_1_1 -p 159 -st topic460_1_0 -pt topic460_1_1 -u 0.002261615066841527 > ./result_10chains/node460_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_2_1 -p 278 -st topic460_2_0 -pt topic460_2_1 -u 0.024582686714969104 > ./result_10chains/node460_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_3_1 -p 389 -st topic460_3_0 -pt topic460_3_1 -u 0.02588249132496201 > ./result_10chains/node460_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_4_1 -p 504 -st topic460_4_0 -pt topic460_4_1 -u 0.033899704712799184 > ./result_10chains/node460_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_5_1 -p 505 -st topic460_5_0 -pt topic460_5_1 -u 0.018279457758102968 > ./result_10chains/node460_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_6_1 -p 645 -st topic460_6_0 -pt topic460_6_1 -u 0.005021764862479738 > ./result_10chains/node460_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_7_1 -p 847 -st topic460_7_0 -pt topic460_7_1 -u 0.027154699326308 > ./result_10chains/node460_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_8_1 -p 888 -st topic460_8_0 -pt topic460_8_1 -u 0.009109904442553725 > ./result_10chains/node460_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_9_1 -p 903 -st topic460_9_0 -pt topic460_9_1 -u 0.020008393785992475 > ./result_10chains/node460_9_1.txt &
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
    "./result_10chains/node460_0_1.txt 90"
    "./result_10chains/node460_1_1.txt 89"
    "./result_10chains/node460_2_1.txt 88"
    "./result_10chains/node460_3_1.txt 87"
    "./result_10chains/node460_4_1.txt 86"
    "./result_10chains/node460_5_1.txt 85"
    "./result_10chains/node460_6_1.txt 84"
    "./result_10chains/node460_7_1.txt 83"
    "./result_10chains/node460_8_1.txt 82"
    "./result_10chains/node460_9_1.txt 81"
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
