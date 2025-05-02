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
ros2 run evaluation_3_randomdag uunifast_node -n node380_0_1 -p 49 -st topic380_0_0 -pt topic380_0_1 -u 0.023477769937258863 > ./result_10chains/node380_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_1_1 -p 108 -st topic380_1_0 -pt topic380_1_1 -u 0.021195534055155674 > ./result_10chains/node380_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_2_1 -p 176 -st topic380_2_0 -pt topic380_2_1 -u 0.013009798362524583 > ./result_10chains/node380_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_3_1 -p 214 -st topic380_3_0 -pt topic380_3_1 -u 0.02375411715006065 > ./result_10chains/node380_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_4_1 -p 321 -st topic380_4_0 -pt topic380_4_1 -u 0.037056740595974996 > ./result_10chains/node380_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_5_1 -p 364 -st topic380_5_0 -pt topic380_5_1 -u 0.0067297467498932395 > ./result_10chains/node380_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_6_1 -p 674 -st topic380_6_0 -pt topic380_6_1 -u 0.0010051494947268536 > ./result_10chains/node380_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_7_1 -p 753 -st topic380_7_0 -pt topic380_7_1 -u 0.011871573802260338 > ./result_10chains/node380_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_8_1 -p 881 -st topic380_8_0 -pt topic380_8_1 -u 0.001010462113040636 > ./result_10chains/node380_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_9_1 -p 908 -st topic380_9_0 -pt topic380_9_1 -u 0.02795864353894366 > ./result_10chains/node380_9_1.txt &
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
    "./result_10chains/node380_0_1.txt 90"
    "./result_10chains/node380_1_1.txt 89"
    "./result_10chains/node380_2_1.txt 88"
    "./result_10chains/node380_3_1.txt 87"
    "./result_10chains/node380_4_1.txt 86"
    "./result_10chains/node380_5_1.txt 85"
    "./result_10chains/node380_6_1.txt 84"
    "./result_10chains/node380_7_1.txt 83"
    "./result_10chains/node380_8_1.txt 82"
    "./result_10chains/node380_9_1.txt 81"
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
