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
ros2 run evaluation_3_randomdag uunifast_node -n node108_0_1 -p 374 -st topic108_0_0 -pt topic108_0_1 -u 0.007228556006558029 > ./result_10chains/node108_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_1_1 -p 460 -st topic108_1_0 -pt topic108_1_1 -u 0.050074147337406005 > ./result_10chains/node108_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_2_1 -p 704 -st topic108_2_0 -pt topic108_2_1 -u 0.025757383575900683 > ./result_10chains/node108_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_3_1 -p 746 -st topic108_3_0 -pt topic108_3_1 -u 0.04997826058588162 > ./result_10chains/node108_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_4_1 -p 748 -st topic108_4_0 -pt topic108_4_1 -u 0.03613883172608884 > ./result_10chains/node108_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_5_1 -p 751 -st topic108_5_0 -pt topic108_5_1 -u 0.013656880439240626 > ./result_10chains/node108_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_6_1 -p 769 -st topic108_6_0 -pt topic108_6_1 -u 0.02376682032980479 > ./result_10chains/node108_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_7_1 -p 867 -st topic108_7_0 -pt topic108_7_1 -u 0.00425334631964186 > ./result_10chains/node108_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_8_1 -p 879 -st topic108_8_0 -pt topic108_8_1 -u 0.01261351740771778 > ./result_10chains/node108_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_9_1 -p 889 -st topic108_9_0 -pt topic108_9_1 -u 0.00974123493491888 > ./result_10chains/node108_9_1.txt &
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
    "./result_10chains/node108_0_1.txt 90"
    "./result_10chains/node108_1_1.txt 89"
    "./result_10chains/node108_2_1.txt 88"
    "./result_10chains/node108_3_1.txt 87"
    "./result_10chains/node108_4_1.txt 86"
    "./result_10chains/node108_5_1.txt 85"
    "./result_10chains/node108_6_1.txt 84"
    "./result_10chains/node108_7_1.txt 83"
    "./result_10chains/node108_8_1.txt 82"
    "./result_10chains/node108_9_1.txt 81"
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
