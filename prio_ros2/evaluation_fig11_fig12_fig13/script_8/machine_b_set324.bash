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
ros2 run evaluation_3_randomdag uunifast_node -n node324_0_1 -p 57 -st topic324_0_0 -pt topic324_0_1 -u 0.036690186868154395 > ./result_8chains/node324_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_1_1 -p 206 -st topic324_1_0 -pt topic324_1_1 -u 0.011397219507832845 > ./result_8chains/node324_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_2_1 -p 259 -st topic324_2_0 -pt topic324_2_1 -u 0.007328901912851349 > ./result_8chains/node324_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_3_1 -p 387 -st topic324_3_0 -pt topic324_3_1 -u 0.009538088206970607 > ./result_8chains/node324_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_4_1 -p 629 -st topic324_4_0 -pt topic324_4_1 -u 0.07218117638939928 > ./result_8chains/node324_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_5_1 -p 634 -st topic324_5_0 -pt topic324_5_1 -u 0.013136633060299607 > ./result_8chains/node324_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_6_1 -p 940 -st topic324_6_0 -pt topic324_6_1 -u 0.052333321085264145 > ./result_8chains/node324_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_7_1 -p 974 -st topic324_7_0 -pt topic324_7_1 -u 0.008911494228978412 > ./result_8chains/node324_7_1.txt &
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
    "./result_8chains/node324_0_1.txt 90"
    "./result_8chains/node324_1_1.txt 89"
    "./result_8chains/node324_2_1.txt 88"
    "./result_8chains/node324_3_1.txt 87"
    "./result_8chains/node324_4_1.txt 86"
    "./result_8chains/node324_5_1.txt 85"
    "./result_8chains/node324_6_1.txt 84"
    "./result_8chains/node324_7_1.txt 83"
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
