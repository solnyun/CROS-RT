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
ros2 run evaluation_3_randomdag uunifast_node -n node19_0_1 -p 105 -st topic19_0_0 -pt topic19_0_1 -u 0.004293434025919474 > ./result_10chains/node19_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node19_1_1 -p 159 -st topic19_1_0 -pt topic19_1_1 -u 0.029808853283014247 > ./result_10chains/node19_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node19_2_1 -p 227 -st topic19_2_0 -pt topic19_2_1 -u 0.06173982636947978 > ./result_10chains/node19_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node19_3_1 -p 424 -st topic19_3_0 -pt topic19_3_1 -u 0.00024387455380309175 > ./result_10chains/node19_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node19_4_1 -p 486 -st topic19_4_0 -pt topic19_4_1 -u 0.02895935520072282 > ./result_10chains/node19_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node19_5_1 -p 644 -st topic19_5_0 -pt topic19_5_1 -u 0.007132965092901289 > ./result_10chains/node19_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node19_6_1 -p 685 -st topic19_6_0 -pt topic19_6_1 -u 0.015467007487582979 > ./result_10chains/node19_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node19_7_1 -p 693 -st topic19_7_0 -pt topic19_7_1 -u 0.013707820821158193 > ./result_10chains/node19_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node19_8_1 -p 845 -st topic19_8_0 -pt topic19_8_1 -u 0.0007721386369681782 > ./result_10chains/node19_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node19_9_1 -p 926 -st topic19_9_0 -pt topic19_9_1 -u 0.017031217115044732 > ./result_10chains/node19_9_1.txt &
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
    "./result_10chains/node19_0_1.txt 90"
    "./result_10chains/node19_1_1.txt 89"
    "./result_10chains/node19_2_1.txt 88"
    "./result_10chains/node19_3_1.txt 87"
    "./result_10chains/node19_4_1.txt 86"
    "./result_10chains/node19_5_1.txt 85"
    "./result_10chains/node19_6_1.txt 84"
    "./result_10chains/node19_7_1.txt 83"
    "./result_10chains/node19_8_1.txt 82"
    "./result_10chains/node19_9_1.txt 81"
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
