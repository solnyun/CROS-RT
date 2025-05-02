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
ros2 run evaluation_3_randomdag uunifast_node -n node432_0_1 -p 24 -st topic432_0_0 -pt topic432_0_1 -u 0.028726697419220015 > ./result_10chains/node432_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_1_1 -p 116 -st topic432_1_0 -pt topic432_1_1 -u 0.003566820726930542 > ./result_10chains/node432_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_2_1 -p 154 -st topic432_2_0 -pt topic432_2_1 -u 0.04453782051032601 > ./result_10chains/node432_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_3_1 -p 477 -st topic432_3_0 -pt topic432_3_1 -u 0.0027304308738868577 > ./result_10chains/node432_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_4_1 -p 493 -st topic432_4_0 -pt topic432_4_1 -u 0.034576184819713085 > ./result_10chains/node432_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_5_1 -p 502 -st topic432_5_0 -pt topic432_5_1 -u 0.02000966622890918 > ./result_10chains/node432_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_6_1 -p 604 -st topic432_6_0 -pt topic432_6_1 -u 0.005555440442137294 > ./result_10chains/node432_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_7_1 -p 731 -st topic432_7_0 -pt topic432_7_1 -u 0.0014721409121174756 > ./result_10chains/node432_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_8_1 -p 880 -st topic432_8_0 -pt topic432_8_1 -u 0.011590587123206039 > ./result_10chains/node432_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_9_1 -p 999 -st topic432_9_0 -pt topic432_9_1 -u 0.0004227066527172519 > ./result_10chains/node432_9_1.txt &
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
    "./result_10chains/node432_0_1.txt 90"
    "./result_10chains/node432_1_1.txt 89"
    "./result_10chains/node432_2_1.txt 88"
    "./result_10chains/node432_3_1.txt 87"
    "./result_10chains/node432_4_1.txt 86"
    "./result_10chains/node432_5_1.txt 85"
    "./result_10chains/node432_6_1.txt 84"
    "./result_10chains/node432_7_1.txt 83"
    "./result_10chains/node432_8_1.txt 82"
    "./result_10chains/node432_9_1.txt 81"
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
