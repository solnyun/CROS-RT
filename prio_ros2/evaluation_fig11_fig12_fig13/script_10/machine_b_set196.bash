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
ros2 run evaluation_3_randomdag uunifast_node -n node196_0_1 -p 45 -st topic196_0_0 -pt topic196_0_1 -u 0.0005012940772080587 > ./result_10chains/node196_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_1_1 -p 162 -st topic196_1_0 -pt topic196_1_1 -u 0.018314911350365892 > ./result_10chains/node196_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_2_1 -p 179 -st topic196_2_0 -pt topic196_2_1 -u 0.010702187790273487 > ./result_10chains/node196_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_3_1 -p 228 -st topic196_3_0 -pt topic196_3_1 -u 0.019363451735249226 > ./result_10chains/node196_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_4_1 -p 288 -st topic196_4_0 -pt topic196_4_1 -u 0.011002492905866412 > ./result_10chains/node196_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_5_1 -p 381 -st topic196_5_0 -pt topic196_5_1 -u 0.0041382916266946845 > ./result_10chains/node196_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_6_1 -p 437 -st topic196_6_0 -pt topic196_6_1 -u 0.006561237135543574 > ./result_10chains/node196_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_7_1 -p 685 -st topic196_7_0 -pt topic196_7_1 -u 0.009137839765871986 > ./result_10chains/node196_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_8_1 -p 802 -st topic196_8_0 -pt topic196_8_1 -u 0.005045181653211786 > ./result_10chains/node196_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_9_1 -p 880 -st topic196_9_0 -pt topic196_9_1 -u 0.0038046756526716463 > ./result_10chains/node196_9_1.txt &
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
    "./result_10chains/node196_0_1.txt 90"
    "./result_10chains/node196_1_1.txt 89"
    "./result_10chains/node196_2_1.txt 88"
    "./result_10chains/node196_3_1.txt 87"
    "./result_10chains/node196_4_1.txt 86"
    "./result_10chains/node196_5_1.txt 85"
    "./result_10chains/node196_6_1.txt 84"
    "./result_10chains/node196_7_1.txt 83"
    "./result_10chains/node196_8_1.txt 82"
    "./result_10chains/node196_9_1.txt 81"
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
