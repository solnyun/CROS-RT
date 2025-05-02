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
ros2 run evaluation_3_randomdag uunifast_node -n node41_0_1 -p 90 -st topic41_0_0 -pt topic41_0_1 -u 0.0029215768989270807 > ./result_10chains/node41_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node41_1_1 -p 142 -st topic41_1_0 -pt topic41_1_1 -u 0.0085387448247628 > ./result_10chains/node41_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node41_2_1 -p 259 -st topic41_2_0 -pt topic41_2_1 -u 0.0009310873405979914 > ./result_10chains/node41_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node41_3_1 -p 391 -st topic41_3_0 -pt topic41_3_1 -u 0.025603418683485424 > ./result_10chains/node41_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node41_4_1 -p 477 -st topic41_4_0 -pt topic41_4_1 -u 0.03945394709565564 > ./result_10chains/node41_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node41_5_1 -p 700 -st topic41_5_0 -pt topic41_5_1 -u 0.016870487931379602 > ./result_10chains/node41_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node41_6_1 -p 796 -st topic41_6_0 -pt topic41_6_1 -u 0.004478471432123737 > ./result_10chains/node41_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node41_7_1 -p 891 -st topic41_7_0 -pt topic41_7_1 -u 0.016152443061084737 > ./result_10chains/node41_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node41_8_1 -p 912 -st topic41_8_0 -pt topic41_8_1 -u 0.0019908691898976316 > ./result_10chains/node41_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node41_9_1 -p 960 -st topic41_9_0 -pt topic41_9_1 -u 0.004671977581645736 > ./result_10chains/node41_9_1.txt &
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
    "./result_10chains/node41_0_1.txt 90"
    "./result_10chains/node41_1_1.txt 89"
    "./result_10chains/node41_2_1.txt 88"
    "./result_10chains/node41_3_1.txt 87"
    "./result_10chains/node41_4_1.txt 86"
    "./result_10chains/node41_5_1.txt 85"
    "./result_10chains/node41_6_1.txt 84"
    "./result_10chains/node41_7_1.txt 83"
    "./result_10chains/node41_8_1.txt 82"
    "./result_10chains/node41_9_1.txt 81"
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
