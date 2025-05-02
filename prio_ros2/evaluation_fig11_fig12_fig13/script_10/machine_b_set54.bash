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
ros2 run evaluation_3_randomdag uunifast_node -n node54_0_1 -p 12 -st topic54_0_0 -pt topic54_0_1 -u 0.026790297183400535 > ./result_10chains/node54_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_1_1 -p 16 -st topic54_1_0 -pt topic54_1_1 -u 0.012115288684500014 > ./result_10chains/node54_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_2_1 -p 319 -st topic54_2_0 -pt topic54_2_1 -u 0.001672849041635227 > ./result_10chains/node54_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_3_1 -p 374 -st topic54_3_0 -pt topic54_3_1 -u 0.015140481056275412 > ./result_10chains/node54_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_4_1 -p 399 -st topic54_4_0 -pt topic54_4_1 -u 0.061806426900527456 > ./result_10chains/node54_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_5_1 -p 555 -st topic54_5_0 -pt topic54_5_1 -u 0.012366390509641945 > ./result_10chains/node54_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_6_1 -p 623 -st topic54_6_0 -pt topic54_6_1 -u 0.02459912374626369 > ./result_10chains/node54_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_7_1 -p 709 -st topic54_7_0 -pt topic54_7_1 -u 0.016688169827104166 > ./result_10chains/node54_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_8_1 -p 848 -st topic54_8_0 -pt topic54_8_1 -u 0.00029142835098217024 > ./result_10chains/node54_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_9_1 -p 974 -st topic54_9_0 -pt topic54_9_1 -u 0.0057555968333878466 > ./result_10chains/node54_9_1.txt &
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
    "./result_10chains/node54_0_1.txt 90"
    "./result_10chains/node54_1_1.txt 89"
    "./result_10chains/node54_2_1.txt 88"
    "./result_10chains/node54_3_1.txt 87"
    "./result_10chains/node54_4_1.txt 86"
    "./result_10chains/node54_5_1.txt 85"
    "./result_10chains/node54_6_1.txt 84"
    "./result_10chains/node54_7_1.txt 83"
    "./result_10chains/node54_8_1.txt 82"
    "./result_10chains/node54_9_1.txt 81"
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
