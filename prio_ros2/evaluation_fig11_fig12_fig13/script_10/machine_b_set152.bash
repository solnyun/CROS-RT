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
ros2 run evaluation_3_randomdag uunifast_node -n node152_0_1 -p 79 -st topic152_0_0 -pt topic152_0_1 -u 0.022231142554014094 > ./result_10chains/node152_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_1_1 -p 199 -st topic152_1_0 -pt topic152_1_1 -u 0.012750484431990339 > ./result_10chains/node152_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_2_1 -p 347 -st topic152_2_0 -pt topic152_2_1 -u 0.04465740920940875 > ./result_10chains/node152_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_3_1 -p 456 -st topic152_3_0 -pt topic152_3_1 -u 0.0031383834380174225 > ./result_10chains/node152_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_4_1 -p 489 -st topic152_4_0 -pt topic152_4_1 -u 0.0078780581082461 > ./result_10chains/node152_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_5_1 -p 520 -st topic152_5_0 -pt topic152_5_1 -u 0.009656974507532029 > ./result_10chains/node152_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_6_1 -p 610 -st topic152_6_0 -pt topic152_6_1 -u 0.00921893838222615 > ./result_10chains/node152_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_7_1 -p 665 -st topic152_7_0 -pt topic152_7_1 -u 0.011722245866947867 > ./result_10chains/node152_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_8_1 -p 947 -st topic152_8_0 -pt topic152_8_1 -u 0.048703053867430644 > ./result_10chains/node152_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_9_1 -p 964 -st topic152_9_0 -pt topic152_9_1 -u 0.01509972300904632 > ./result_10chains/node152_9_1.txt &
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
    "./result_10chains/node152_0_1.txt 90"
    "./result_10chains/node152_1_1.txt 89"
    "./result_10chains/node152_2_1.txt 88"
    "./result_10chains/node152_3_1.txt 87"
    "./result_10chains/node152_4_1.txt 86"
    "./result_10chains/node152_5_1.txt 85"
    "./result_10chains/node152_6_1.txt 84"
    "./result_10chains/node152_7_1.txt 83"
    "./result_10chains/node152_8_1.txt 82"
    "./result_10chains/node152_9_1.txt 81"
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
