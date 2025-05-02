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
ros2 run evaluation_3_randomdag uunifast_node -n node362_0_1 -p 58 -st topic362_0_0 -pt topic362_0_1 -u 0.0005839663587517419 > ./result_10chains/node362_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_1_1 -p 80 -st topic362_1_0 -pt topic362_1_1 -u 0.0037033587398634937 > ./result_10chains/node362_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_2_1 -p 164 -st topic362_2_0 -pt topic362_2_1 -u 0.018804809679884182 > ./result_10chains/node362_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_3_1 -p 226 -st topic362_3_0 -pt topic362_3_1 -u 0.02457070736850725 > ./result_10chains/node362_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_4_1 -p 356 -st topic362_4_0 -pt topic362_4_1 -u 0.0002731699477527272 > ./result_10chains/node362_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_5_1 -p 483 -st topic362_5_0 -pt topic362_5_1 -u 0.0016798777034342516 > ./result_10chains/node362_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_6_1 -p 713 -st topic362_6_0 -pt topic362_6_1 -u 0.018177718003263704 > ./result_10chains/node362_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_7_1 -p 757 -st topic362_7_0 -pt topic362_7_1 -u 0.00011665170966412841 > ./result_10chains/node362_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_8_1 -p 758 -st topic362_8_0 -pt topic362_8_1 -u 0.0315364018289422 > ./result_10chains/node362_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_9_1 -p 861 -st topic362_9_0 -pt topic362_9_1 -u 0.01147005447402334 > ./result_10chains/node362_9_1.txt &
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
    "./result_10chains/node362_0_1.txt 90"
    "./result_10chains/node362_1_1.txt 89"
    "./result_10chains/node362_2_1.txt 88"
    "./result_10chains/node362_3_1.txt 87"
    "./result_10chains/node362_4_1.txt 86"
    "./result_10chains/node362_5_1.txt 85"
    "./result_10chains/node362_6_1.txt 84"
    "./result_10chains/node362_7_1.txt 83"
    "./result_10chains/node362_8_1.txt 82"
    "./result_10chains/node362_9_1.txt 81"
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
