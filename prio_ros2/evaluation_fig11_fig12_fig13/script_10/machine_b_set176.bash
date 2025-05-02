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
ros2 run evaluation_3_randomdag uunifast_node -n node176_0_1 -p 230 -st topic176_0_0 -pt topic176_0_1 -u 0.01069803979311773 > ./result_10chains/node176_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_1_1 -p 268 -st topic176_1_0 -pt topic176_1_1 -u 0.019349780905991987 > ./result_10chains/node176_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_2_1 -p 420 -st topic176_2_0 -pt topic176_2_1 -u 0.010660530655837552 > ./result_10chains/node176_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_3_1 -p 437 -st topic176_3_0 -pt topic176_3_1 -u 0.007894114422812182 > ./result_10chains/node176_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_4_1 -p 609 -st topic176_4_0 -pt topic176_4_1 -u 0.01012398122098207 > ./result_10chains/node176_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_5_1 -p 647 -st topic176_5_0 -pt topic176_5_1 -u 0.022715662473417525 > ./result_10chains/node176_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_6_1 -p 832 -st topic176_6_0 -pt topic176_6_1 -u 0.01801534880589975 > ./result_10chains/node176_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_7_1 -p 842 -st topic176_7_0 -pt topic176_7_1 -u 0.05613225194287709 > ./result_10chains/node176_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_8_1 -p 950 -st topic176_8_0 -pt topic176_8_1 -u 0.0036501171593349008 > ./result_10chains/node176_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_9_1 -p 967 -st topic176_9_0 -pt topic176_9_1 -u 0.007262480375540906 > ./result_10chains/node176_9_1.txt &
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
    "./result_10chains/node176_0_1.txt 90"
    "./result_10chains/node176_1_1.txt 89"
    "./result_10chains/node176_2_1.txt 88"
    "./result_10chains/node176_3_1.txt 87"
    "./result_10chains/node176_4_1.txt 86"
    "./result_10chains/node176_5_1.txt 85"
    "./result_10chains/node176_6_1.txt 84"
    "./result_10chains/node176_7_1.txt 83"
    "./result_10chains/node176_8_1.txt 82"
    "./result_10chains/node176_9_1.txt 81"
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
