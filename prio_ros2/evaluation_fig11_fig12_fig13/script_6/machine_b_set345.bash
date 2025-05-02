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
ros2 run evaluation_3_randomdag uunifast_node -n node345_0_1 -p 52 -st topic345_0_0 -pt topic345_0_1 -u 0.005066779399298782 > ./result_6chains/node345_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_1_1 -p 193 -st topic345_1_0 -pt topic345_1_1 -u 0.01688900051788822 > ./result_6chains/node345_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_2_1 -p 410 -st topic345_2_0 -pt topic345_2_1 -u 0.0037773993734768196 > ./result_6chains/node345_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_3_1 -p 643 -st topic345_3_0 -pt topic345_3_1 -u 0.03806280908104581 > ./result_6chains/node345_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_4_1 -p 790 -st topic345_4_0 -pt topic345_4_1 -u 0.05596175442550938 > ./result_6chains/node345_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_5_1 -p 937 -st topic345_5_0 -pt topic345_5_1 -u 0.011841009073234918 > ./result_6chains/node345_5_1.txt &
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
    "./result_6chains/node345_0_1.txt 90"
    "./result_6chains/node345_1_1.txt 89"
    "./result_6chains/node345_2_1.txt 88"
    "./result_6chains/node345_3_1.txt 87"
    "./result_6chains/node345_4_1.txt 86"
    "./result_6chains/node345_5_1.txt 85"
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
