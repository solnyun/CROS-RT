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
ros2 run evaluation_3_randomdag uunifast_node -n node71_0_1 -p 27 -st topic71_0_0 -pt topic71_0_1 -u 0.00920330531467417 > ./result_10chains/node71_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_1_1 -p 91 -st topic71_1_0 -pt topic71_1_1 -u 0.003086069056290608 > ./result_10chains/node71_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_2_1 -p 228 -st topic71_2_0 -pt topic71_2_1 -u 0.0024403898295536908 > ./result_10chains/node71_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_3_1 -p 265 -st topic71_3_0 -pt topic71_3_1 -u 0.01566640213969389 > ./result_10chains/node71_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_4_1 -p 421 -st topic71_4_0 -pt topic71_4_1 -u 0.02455305006415026 > ./result_10chains/node71_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_5_1 -p 533 -st topic71_5_0 -pt topic71_5_1 -u 0.017747445520585714 > ./result_10chains/node71_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_6_1 -p 583 -st topic71_6_0 -pt topic71_6_1 -u 0.026867753392255084 > ./result_10chains/node71_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_7_1 -p 598 -st topic71_7_0 -pt topic71_7_1 -u 0.017311391414617128 > ./result_10chains/node71_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_8_1 -p 619 -st topic71_8_0 -pt topic71_8_1 -u 0.02623822123924112 > ./result_10chains/node71_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_9_1 -p 763 -st topic71_9_0 -pt topic71_9_1 -u 0.026670615691557004 > ./result_10chains/node71_9_1.txt &
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
    "./result_10chains/node71_0_1.txt 90"
    "./result_10chains/node71_1_1.txt 89"
    "./result_10chains/node71_2_1.txt 88"
    "./result_10chains/node71_3_1.txt 87"
    "./result_10chains/node71_4_1.txt 86"
    "./result_10chains/node71_5_1.txt 85"
    "./result_10chains/node71_6_1.txt 84"
    "./result_10chains/node71_7_1.txt 83"
    "./result_10chains/node71_8_1.txt 82"
    "./result_10chains/node71_9_1.txt 81"
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
