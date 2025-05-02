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
ros2 run evaluation_3_randomdag uunifast_node -n node316_0_1 -p 35 -st topic316_0_0 -pt topic316_0_1 -u 0.014810959472542573 > ./result_10chains/node316_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_1_1 -p 51 -st topic316_1_0 -pt topic316_1_1 -u 0.015623775478202817 > ./result_10chains/node316_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_2_1 -p 197 -st topic316_2_0 -pt topic316_2_1 -u 0.016225637120474756 > ./result_10chains/node316_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_3_1 -p 227 -st topic316_3_0 -pt topic316_3_1 -u 0.00816733169506173 > ./result_10chains/node316_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_4_1 -p 272 -st topic316_4_0 -pt topic316_4_1 -u 0.03784871482289942 > ./result_10chains/node316_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_5_1 -p 341 -st topic316_5_0 -pt topic316_5_1 -u 0.010992759895560728 > ./result_10chains/node316_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_6_1 -p 343 -st topic316_6_0 -pt topic316_6_1 -u 0.010557480133088382 > ./result_10chains/node316_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_7_1 -p 380 -st topic316_7_0 -pt topic316_7_1 -u 0.03739782176415413 > ./result_10chains/node316_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_8_1 -p 490 -st topic316_8_0 -pt topic316_8_1 -u 1.6100881249328514e-05 > ./result_10chains/node316_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_9_1 -p 662 -st topic316_9_0 -pt topic316_9_1 -u 0.013541508649911216 > ./result_10chains/node316_9_1.txt &
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
    "./result_10chains/node316_0_1.txt 90"
    "./result_10chains/node316_1_1.txt 89"
    "./result_10chains/node316_2_1.txt 88"
    "./result_10chains/node316_3_1.txt 87"
    "./result_10chains/node316_4_1.txt 86"
    "./result_10chains/node316_5_1.txt 85"
    "./result_10chains/node316_6_1.txt 84"
    "./result_10chains/node316_7_1.txt 83"
    "./result_10chains/node316_8_1.txt 82"
    "./result_10chains/node316_9_1.txt 81"
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
