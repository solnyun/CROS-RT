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
ros2 run evaluation_3_randomdag uunifast_node -n node252_0_1 -p 96 -st topic252_0_0 -pt topic252_0_1 -u 0.0034867143779768184 > ./result_10chains/node252_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_1_1 -p 161 -st topic252_1_0 -pt topic252_1_1 -u 0.007690217277827982 > ./result_10chains/node252_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_2_1 -p 164 -st topic252_2_0 -pt topic252_2_1 -u 0.026737515585601168 > ./result_10chains/node252_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_3_1 -p 381 -st topic252_3_0 -pt topic252_3_1 -u 0.0006785939684919029 > ./result_10chains/node252_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_4_1 -p 453 -st topic252_4_0 -pt topic252_4_1 -u 0.00842973166921085 > ./result_10chains/node252_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_5_1 -p 462 -st topic252_5_0 -pt topic252_5_1 -u 0.032661674716499695 > ./result_10chains/node252_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_6_1 -p 565 -st topic252_6_0 -pt topic252_6_1 -u 0.011688207436655301 > ./result_10chains/node252_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_7_1 -p 605 -st topic252_7_0 -pt topic252_7_1 -u 0.022161919197022373 > ./result_10chains/node252_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_8_1 -p 733 -st topic252_8_0 -pt topic252_8_1 -u 0.013295264351587108 > ./result_10chains/node252_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_9_1 -p 832 -st topic252_9_0 -pt topic252_9_1 -u 0.005561982185769398 > ./result_10chains/node252_9_1.txt &
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
    "./result_10chains/node252_0_1.txt 90"
    "./result_10chains/node252_1_1.txt 89"
    "./result_10chains/node252_2_1.txt 88"
    "./result_10chains/node252_3_1.txt 87"
    "./result_10chains/node252_4_1.txt 86"
    "./result_10chains/node252_5_1.txt 85"
    "./result_10chains/node252_6_1.txt 84"
    "./result_10chains/node252_7_1.txt 83"
    "./result_10chains/node252_8_1.txt 82"
    "./result_10chains/node252_9_1.txt 81"
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
