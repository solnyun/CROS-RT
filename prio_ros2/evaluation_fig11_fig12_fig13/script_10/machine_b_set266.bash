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
ros2 run evaluation_3_randomdag uunifast_node -n node266_0_1 -p 25 -st topic266_0_0 -pt topic266_0_1 -u 0.008351677360228849 > ./result_10chains/node266_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_1_1 -p 394 -st topic266_1_0 -pt topic266_1_1 -u 0.01055580220852792 > ./result_10chains/node266_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_2_1 -p 532 -st topic266_2_0 -pt topic266_2_1 -u 0.0012927980218663815 > ./result_10chains/node266_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_3_1 -p 601 -st topic266_3_0 -pt topic266_3_1 -u 0.0021854698089216473 > ./result_10chains/node266_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_4_1 -p 616 -st topic266_4_0 -pt topic266_4_1 -u 0.0033005803452928473 > ./result_10chains/node266_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_5_1 -p 683 -st topic266_5_0 -pt topic266_5_1 -u 0.0061891142499188034 > ./result_10chains/node266_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_6_1 -p 761 -st topic266_6_0 -pt topic266_6_1 -u 0.15180573201575162 > ./result_10chains/node266_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_7_1 -p 886 -st topic266_7_0 -pt topic266_7_1 -u 0.009998091886784508 > ./result_10chains/node266_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_8_1 -p 942 -st topic266_8_0 -pt topic266_8_1 -u 0.0042730998145185314 > ./result_10chains/node266_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_9_1 -p 968 -st topic266_9_0 -pt topic266_9_1 -u 0.022331245252445266 > ./result_10chains/node266_9_1.txt &
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
    "./result_10chains/node266_0_1.txt 90"
    "./result_10chains/node266_1_1.txt 89"
    "./result_10chains/node266_2_1.txt 88"
    "./result_10chains/node266_3_1.txt 87"
    "./result_10chains/node266_4_1.txt 86"
    "./result_10chains/node266_5_1.txt 85"
    "./result_10chains/node266_6_1.txt 84"
    "./result_10chains/node266_7_1.txt 83"
    "./result_10chains/node266_8_1.txt 82"
    "./result_10chains/node266_9_1.txt 81"
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
