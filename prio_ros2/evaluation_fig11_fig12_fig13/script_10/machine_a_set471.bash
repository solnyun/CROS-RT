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
ros2 run evaluation_3_randomdag uunifast_node -n node471_0_2 -p 199 -st topic471_0_1 -pt None -u 0.001437688132801096 > ./result_10chains/node471_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_1_2 -p 221 -st topic471_1_1 -pt None -u 0.005696431756482545 > ./result_10chains/node471_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_2_2 -p 316 -st topic471_2_1 -pt None -u 0.057240660938251586 > ./result_10chains/node471_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_3_2 -p 491 -st topic471_3_1 -pt None -u 0.02275210527274446 > ./result_10chains/node471_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_4_2 -p 572 -st topic471_4_1 -pt None -u 0.02463843778303959 > ./result_10chains/node471_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_5_2 -p 578 -st topic471_5_1 -pt None -u 0.03195568949184521 > ./result_10chains/node471_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_6_2 -p 632 -st topic471_6_1 -pt None -u 0.018235573840773955 > ./result_10chains/node471_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_7_2 -p 689 -st topic471_7_1 -pt None -u 0.014875610975583473 > ./result_10chains/node471_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_8_2 -p 708 -st topic471_8_1 -pt None -u 0.05392091227906222 > ./result_10chains/node471_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_9_2 -p 809 -st topic471_9_1 -pt None -u 0.024106338653305557 > ./result_10chains/node471_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_0_0 -p 199 -st none -pt topic471_0_0 -u 0.01453402229573536 > ./result_10chains/node471_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_1_0 -p 221 -st none -pt topic471_1_0 -u 0.007407121424833518 > ./result_10chains/node471_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_2_0 -p 316 -st none -pt topic471_2_0 -u 0.05443897770256495 > ./result_10chains/node471_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_3_0 -p 491 -st none -pt topic471_3_0 -u 0.015878452461185688 > ./result_10chains/node471_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_4_0 -p 572 -st none -pt topic471_4_0 -u 0.008558229090272873 > ./result_10chains/node471_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_5_0 -p 578 -st none -pt topic471_5_0 -u 0.005285901622080008 > ./result_10chains/node471_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_6_0 -p 632 -st none -pt topic471_6_0 -u 0.006246321787031661 > ./result_10chains/node471_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_7_0 -p 689 -st none -pt topic471_7_0 -u 0.014873349239767242 > ./result_10chains/node471_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_8_0 -p 708 -st none -pt topic471_8_0 -u 0.024177527470787094 > ./result_10chains/node471_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_9_0 -p 809 -st none -pt topic471_9_0 -u 0.0061333658052390196 > ./result_10chains/node471_9_0.txt &
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
    "./result_10chains/node471_0_0.txt 90"
    "./result_10chains/node471_0_2.txt 90"
    "./result_10chains/node471_1_0.txt 89"
    "./result_10chains/node471_1_2.txt 89"
    "./result_10chains/node471_2_0.txt 88"
    "./result_10chains/node471_2_2.txt 88"
    "./result_10chains/node471_3_0.txt 87"
    "./result_10chains/node471_3_2.txt 87"
    "./result_10chains/node471_4_0.txt 86"
    "./result_10chains/node471_4_2.txt 86"
    "./result_10chains/node471_5_0.txt 85"
    "./result_10chains/node471_5_2.txt 85"
    "./result_10chains/node471_6_0.txt 84"
    "./result_10chains/node471_6_2.txt 84"
    "./result_10chains/node471_7_0.txt 83"
    "./result_10chains/node471_7_2.txt 83"
    "./result_10chains/node471_8_0.txt 82"
    "./result_10chains/node471_8_2.txt 82"
    "./result_10chains/node471_9_0.txt 81"
    "./result_10chains/node471_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
