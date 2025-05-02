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
ros2 run evaluation_3_randomdag uunifast_node -n node331_0_1 -p 14 -st topic331_0_0 -pt topic331_0_1 -u 0.00037281485195261865 > ./result_8chains/node331_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_1_1 -p 51 -st topic331_1_0 -pt topic331_1_1 -u 0.008140841150478806 > ./result_8chains/node331_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_2_1 -p 196 -st topic331_2_0 -pt topic331_2_1 -u 0.0023468986073015285 > ./result_8chains/node331_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_3_1 -p 255 -st topic331_3_0 -pt topic331_3_1 -u 0.034002081697472986 > ./result_8chains/node331_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_4_1 -p 483 -st topic331_4_0 -pt topic331_4_1 -u 0.011057842588165667 > ./result_8chains/node331_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_5_1 -p 526 -st topic331_5_0 -pt topic331_5_1 -u 0.015681585383381658 > ./result_8chains/node331_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_6_1 -p 590 -st topic331_6_0 -pt topic331_6_1 -u 0.05133058461066883 > ./result_8chains/node331_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_7_1 -p 671 -st topic331_7_0 -pt topic331_7_1 -u 0.002595514794414843 > ./result_8chains/node331_7_1.txt &
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
    "./result_8chains/node331_0_1.txt 90"
    "./result_8chains/node331_1_1.txt 89"
    "./result_8chains/node331_2_1.txt 88"
    "./result_8chains/node331_3_1.txt 87"
    "./result_8chains/node331_4_1.txt 86"
    "./result_8chains/node331_5_1.txt 85"
    "./result_8chains/node331_6_1.txt 84"
    "./result_8chains/node331_7_1.txt 83"
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
