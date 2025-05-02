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
ros2 run evaluation_3_randomdag uunifast_node -n node160_0_1 -p 146 -st topic160_0_0 -pt topic160_0_1 -u 0.011619729008504387 > ./result_10chains/node160_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_1_1 -p 254 -st topic160_1_0 -pt topic160_1_1 -u 0.02541341140450304 > ./result_10chains/node160_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_2_1 -p 271 -st topic160_2_0 -pt topic160_2_1 -u 0.0165199120884848 > ./result_10chains/node160_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_3_1 -p 302 -st topic160_3_0 -pt topic160_3_1 -u 0.007239928175035437 > ./result_10chains/node160_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_4_1 -p 323 -st topic160_4_0 -pt topic160_4_1 -u 0.03549266532060702 > ./result_10chains/node160_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_5_1 -p 342 -st topic160_5_0 -pt topic160_5_1 -u 0.009711603841286942 > ./result_10chains/node160_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_6_1 -p 353 -st topic160_6_0 -pt topic160_6_1 -u 0.02202651533158978 > ./result_10chains/node160_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_7_1 -p 485 -st topic160_7_0 -pt topic160_7_1 -u 0.020616425225444157 > ./result_10chains/node160_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_8_1 -p 643 -st topic160_8_0 -pt topic160_8_1 -u 0.01796267831656076 > ./result_10chains/node160_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_9_1 -p 883 -st topic160_9_0 -pt topic160_9_1 -u 0.022679742428346708 > ./result_10chains/node160_9_1.txt &
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
    "./result_10chains/node160_0_1.txt 90"
    "./result_10chains/node160_1_1.txt 89"
    "./result_10chains/node160_2_1.txt 88"
    "./result_10chains/node160_3_1.txt 87"
    "./result_10chains/node160_4_1.txt 86"
    "./result_10chains/node160_5_1.txt 85"
    "./result_10chains/node160_6_1.txt 84"
    "./result_10chains/node160_7_1.txt 83"
    "./result_10chains/node160_8_1.txt 82"
    "./result_10chains/node160_9_1.txt 81"
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
