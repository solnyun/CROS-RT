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
ros2 run evaluation_3_randomdag uunifast_node -n node81_0_1 -p 65 -st topic81_0_0 -pt topic81_0_1 -u 0.023164038027102984 > ./result_10chains/node81_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_1_1 -p 176 -st topic81_1_0 -pt topic81_1_1 -u 0.04064769637185073 > ./result_10chains/node81_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_2_1 -p 320 -st topic81_2_0 -pt topic81_2_1 -u 0.009372135309714313 > ./result_10chains/node81_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_3_1 -p 356 -st topic81_3_0 -pt topic81_3_1 -u 1.937093186732408e-05 > ./result_10chains/node81_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_4_1 -p 702 -st topic81_4_0 -pt topic81_4_1 -u 0.042940222892811186 > ./result_10chains/node81_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_5_1 -p 746 -st topic81_5_0 -pt topic81_5_1 -u 0.06121495615527581 > ./result_10chains/node81_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_6_1 -p 813 -st topic81_6_0 -pt topic81_6_1 -u 0.007746919209419695 > ./result_10chains/node81_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_7_1 -p 905 -st topic81_7_0 -pt topic81_7_1 -u 0.002268226030371197 > ./result_10chains/node81_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_8_1 -p 956 -st topic81_8_0 -pt topic81_8_1 -u 0.008415429938828378 > ./result_10chains/node81_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_9_1 -p 970 -st topic81_9_0 -pt topic81_9_1 -u 0.009347474010558101 > ./result_10chains/node81_9_1.txt &
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
    "./result_10chains/node81_0_1.txt 90"
    "./result_10chains/node81_1_1.txt 89"
    "./result_10chains/node81_2_1.txt 88"
    "./result_10chains/node81_3_1.txt 87"
    "./result_10chains/node81_4_1.txt 86"
    "./result_10chains/node81_5_1.txt 85"
    "./result_10chains/node81_6_1.txt 84"
    "./result_10chains/node81_7_1.txt 83"
    "./result_10chains/node81_8_1.txt 82"
    "./result_10chains/node81_9_1.txt 81"
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
