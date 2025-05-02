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
ros2 run evaluation_3_randomdag uunifast_node -n node360_0_1 -p 49 -st topic360_0_0 -pt topic360_0_1 -u 0.0033966083387667045 > ./result_10chains/node360_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_1_1 -p 151 -st topic360_1_0 -pt topic360_1_1 -u 0.015119954543433456 > ./result_10chains/node360_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_2_1 -p 188 -st topic360_2_0 -pt topic360_2_1 -u 0.017615579665658743 > ./result_10chains/node360_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_3_1 -p 241 -st topic360_3_0 -pt topic360_3_1 -u 0.011782556261045574 > ./result_10chains/node360_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_4_1 -p 387 -st topic360_4_0 -pt topic360_4_1 -u 0.005662835084385476 > ./result_10chains/node360_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_5_1 -p 431 -st topic360_5_0 -pt topic360_5_1 -u 0.006055854098068358 > ./result_10chains/node360_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_6_1 -p 613 -st topic360_6_0 -pt topic360_6_1 -u 0.016870319536172435 > ./result_10chains/node360_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_7_1 -p 716 -st topic360_7_0 -pt topic360_7_1 -u 0.002139339954760122 > ./result_10chains/node360_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_8_1 -p 793 -st topic360_8_0 -pt topic360_8_1 -u 0.024383279953023126 > ./result_10chains/node360_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_9_1 -p 926 -st topic360_9_0 -pt topic360_9_1 -u 0.024079658332546407 > ./result_10chains/node360_9_1.txt &
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
    "./result_10chains/node360_0_1.txt 90"
    "./result_10chains/node360_1_1.txt 89"
    "./result_10chains/node360_2_1.txt 88"
    "./result_10chains/node360_3_1.txt 87"
    "./result_10chains/node360_4_1.txt 86"
    "./result_10chains/node360_5_1.txt 85"
    "./result_10chains/node360_6_1.txt 84"
    "./result_10chains/node360_7_1.txt 83"
    "./result_10chains/node360_8_1.txt 82"
    "./result_10chains/node360_9_1.txt 81"
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
