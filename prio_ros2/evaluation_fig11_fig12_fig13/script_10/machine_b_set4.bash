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
ros2 run evaluation_3_randomdag uunifast_node -n node4_0_1 -p 56 -st topic4_0_0 -pt topic4_0_1 -u 0.013977746664022905 > ./result_10chains/node4_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node4_1_1 -p 138 -st topic4_1_0 -pt topic4_1_1 -u 0.012987830432880376 > ./result_10chains/node4_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node4_2_1 -p 142 -st topic4_2_0 -pt topic4_2_1 -u 0.006858466960066367 > ./result_10chains/node4_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node4_3_1 -p 154 -st topic4_3_0 -pt topic4_3_1 -u 0.029510359173685052 > ./result_10chains/node4_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node4_4_1 -p 173 -st topic4_4_0 -pt topic4_4_1 -u 0.0027512909504263383 > ./result_10chains/node4_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node4_5_1 -p 272 -st topic4_5_0 -pt topic4_5_1 -u 0.01523538704949498 > ./result_10chains/node4_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node4_6_1 -p 474 -st topic4_6_0 -pt topic4_6_1 -u 0.008290716110607513 > ./result_10chains/node4_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node4_7_1 -p 646 -st topic4_7_0 -pt topic4_7_1 -u 0.00361341864700368 > ./result_10chains/node4_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node4_8_1 -p 680 -st topic4_8_0 -pt topic4_8_1 -u 0.0029411576784321297 > ./result_10chains/node4_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node4_9_1 -p 784 -st topic4_9_0 -pt topic4_9_1 -u 0.00893860753674959 > ./result_10chains/node4_9_1.txt &
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
    "./result_10chains/node4_0_1.txt 90"
    "./result_10chains/node4_1_1.txt 89"
    "./result_10chains/node4_2_1.txt 88"
    "./result_10chains/node4_3_1.txt 87"
    "./result_10chains/node4_4_1.txt 86"
    "./result_10chains/node4_5_1.txt 85"
    "./result_10chains/node4_6_1.txt 84"
    "./result_10chains/node4_7_1.txt 83"
    "./result_10chains/node4_8_1.txt 82"
    "./result_10chains/node4_9_1.txt 81"
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
