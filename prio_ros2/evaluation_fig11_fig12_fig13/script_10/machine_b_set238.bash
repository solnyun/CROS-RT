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
ros2 run evaluation_3_randomdag uunifast_node -n node238_0_1 -p 183 -st topic238_0_0 -pt topic238_0_1 -u 0.0002663404662494595 > ./result_10chains/node238_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_1_1 -p 326 -st topic238_1_0 -pt topic238_1_1 -u 0.05231733302586766 > ./result_10chains/node238_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_2_1 -p 397 -st topic238_2_0 -pt topic238_2_1 -u 0.009470152216620176 > ./result_10chains/node238_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_3_1 -p 455 -st topic238_3_0 -pt topic238_3_1 -u 0.04137502806028909 > ./result_10chains/node238_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_4_1 -p 640 -st topic238_4_0 -pt topic238_4_1 -u 0.007104551229760392 > ./result_10chains/node238_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_5_1 -p 653 -st topic238_5_0 -pt topic238_5_1 -u 0.022569539398767713 > ./result_10chains/node238_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_6_1 -p 739 -st topic238_6_0 -pt topic238_6_1 -u 0.007503072682062434 > ./result_10chains/node238_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_7_1 -p 753 -st topic238_7_0 -pt topic238_7_1 -u 0.023775764306675717 > ./result_10chains/node238_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_8_1 -p 919 -st topic238_8_0 -pt topic238_8_1 -u 0.03365823477108719 > ./result_10chains/node238_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_9_1 -p 969 -st topic238_9_0 -pt topic238_9_1 -u 0.054821996294962115 > ./result_10chains/node238_9_1.txt &
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
    "./result_10chains/node238_0_1.txt 90"
    "./result_10chains/node238_1_1.txt 89"
    "./result_10chains/node238_2_1.txt 88"
    "./result_10chains/node238_3_1.txt 87"
    "./result_10chains/node238_4_1.txt 86"
    "./result_10chains/node238_5_1.txt 85"
    "./result_10chains/node238_6_1.txt 84"
    "./result_10chains/node238_7_1.txt 83"
    "./result_10chains/node238_8_1.txt 82"
    "./result_10chains/node238_9_1.txt 81"
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
