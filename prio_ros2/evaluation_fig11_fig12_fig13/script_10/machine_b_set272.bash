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
ros2 run evaluation_3_randomdag uunifast_node -n node272_0_1 -p 75 -st topic272_0_0 -pt topic272_0_1 -u 0.013551863819475374 > ./result_10chains/node272_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_1_1 -p 80 -st topic272_1_0 -pt topic272_1_1 -u 0.013564810557960938 > ./result_10chains/node272_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_2_1 -p 151 -st topic272_2_0 -pt topic272_2_1 -u 0.02196776381353377 > ./result_10chains/node272_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_3_1 -p 217 -st topic272_3_0 -pt topic272_3_1 -u 0.00631587899474334 > ./result_10chains/node272_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_4_1 -p 227 -st topic272_4_0 -pt topic272_4_1 -u 0.008857378313936237 > ./result_10chains/node272_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_5_1 -p 253 -st topic272_5_0 -pt topic272_5_1 -u 0.01892417935582047 > ./result_10chains/node272_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_6_1 -p 473 -st topic272_6_0 -pt topic272_6_1 -u 0.04632577926141464 > ./result_10chains/node272_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_7_1 -p 523 -st topic272_7_0 -pt topic272_7_1 -u 0.024670287672886176 > ./result_10chains/node272_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_8_1 -p 749 -st topic272_8_0 -pt topic272_8_1 -u 0.0051571135249853794 > ./result_10chains/node272_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_9_1 -p 871 -st topic272_9_0 -pt topic272_9_1 -u 0.008325373059395562 > ./result_10chains/node272_9_1.txt &
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
    "./result_10chains/node272_0_1.txt 90"
    "./result_10chains/node272_1_1.txt 89"
    "./result_10chains/node272_2_1.txt 88"
    "./result_10chains/node272_3_1.txt 87"
    "./result_10chains/node272_4_1.txt 86"
    "./result_10chains/node272_5_1.txt 85"
    "./result_10chains/node272_6_1.txt 84"
    "./result_10chains/node272_7_1.txt 83"
    "./result_10chains/node272_8_1.txt 82"
    "./result_10chains/node272_9_1.txt 81"
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
