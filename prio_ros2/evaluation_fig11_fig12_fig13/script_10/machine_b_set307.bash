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
ros2 run evaluation_3_randomdag uunifast_node -n node307_0_1 -p 107 -st topic307_0_0 -pt topic307_0_1 -u 0.010210601123547547 > ./result_10chains/node307_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_1_1 -p 302 -st topic307_1_0 -pt topic307_1_1 -u 0.001585881252019472 > ./result_10chains/node307_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_2_1 -p 352 -st topic307_2_0 -pt topic307_2_1 -u 0.0031334147545469815 > ./result_10chains/node307_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_3_1 -p 463 -st topic307_3_0 -pt topic307_3_1 -u 0.0023115395565651564 > ./result_10chains/node307_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_4_1 -p 652 -st topic307_4_0 -pt topic307_4_1 -u 0.00868456600015538 > ./result_10chains/node307_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_5_1 -p 751 -st topic307_5_0 -pt topic307_5_1 -u 0.014800609379118812 > ./result_10chains/node307_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_6_1 -p 772 -st topic307_6_0 -pt topic307_6_1 -u 0.1268020957220977 > ./result_10chains/node307_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_7_1 -p 844 -st topic307_7_0 -pt topic307_7_1 -u 0.0448045856028088 > ./result_10chains/node307_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_8_1 -p 923 -st topic307_8_0 -pt topic307_8_1 -u 0.014374993690725209 > ./result_10chains/node307_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_9_1 -p 938 -st topic307_9_0 -pt topic307_9_1 -u 0.01239948214924719 > ./result_10chains/node307_9_1.txt &
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
    "./result_10chains/node307_0_1.txt 90"
    "./result_10chains/node307_1_1.txt 89"
    "./result_10chains/node307_2_1.txt 88"
    "./result_10chains/node307_3_1.txt 87"
    "./result_10chains/node307_4_1.txt 86"
    "./result_10chains/node307_5_1.txt 85"
    "./result_10chains/node307_6_1.txt 84"
    "./result_10chains/node307_7_1.txt 83"
    "./result_10chains/node307_8_1.txt 82"
    "./result_10chains/node307_9_1.txt 81"
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
