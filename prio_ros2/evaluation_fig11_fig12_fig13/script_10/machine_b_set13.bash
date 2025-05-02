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
ros2 run evaluation_3_randomdag uunifast_node -n node13_0_1 -p 262 -st topic13_0_0 -pt topic13_0_1 -u 0.018472317685114203 > ./result_10chains/node13_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node13_1_1 -p 346 -st topic13_1_0 -pt topic13_1_1 -u 0.0189007624194506 > ./result_10chains/node13_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node13_2_1 -p 441 -st topic13_2_0 -pt topic13_2_1 -u 0.02578204409862689 > ./result_10chains/node13_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node13_3_1 -p 638 -st topic13_3_0 -pt topic13_3_1 -u 0.01491284933003062 > ./result_10chains/node13_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node13_4_1 -p 734 -st topic13_4_0 -pt topic13_4_1 -u 0.010056561882566373 > ./result_10chains/node13_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node13_5_1 -p 745 -st topic13_5_0 -pt topic13_5_1 -u 0.02328537771459918 > ./result_10chains/node13_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node13_6_1 -p 790 -st topic13_6_0 -pt topic13_6_1 -u 0.04931047862755833 > ./result_10chains/node13_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node13_7_1 -p 832 -st topic13_7_0 -pt topic13_7_1 -u 0.007765588950256724 > ./result_10chains/node13_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node13_8_1 -p 908 -st topic13_8_0 -pt topic13_8_1 -u 0.0300544266904947 > ./result_10chains/node13_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node13_9_1 -p 943 -st topic13_9_0 -pt topic13_9_1 -u 0.01443672074141367 > ./result_10chains/node13_9_1.txt &
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
    "./result_10chains/node13_0_1.txt 90"
    "./result_10chains/node13_1_1.txt 89"
    "./result_10chains/node13_2_1.txt 88"
    "./result_10chains/node13_3_1.txt 87"
    "./result_10chains/node13_4_1.txt 86"
    "./result_10chains/node13_5_1.txt 85"
    "./result_10chains/node13_6_1.txt 84"
    "./result_10chains/node13_7_1.txt 83"
    "./result_10chains/node13_8_1.txt 82"
    "./result_10chains/node13_9_1.txt 81"
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
