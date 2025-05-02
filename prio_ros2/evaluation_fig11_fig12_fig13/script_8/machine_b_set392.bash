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
ros2 run evaluation_3_randomdag uunifast_node -n node392_0_1 -p 24 -st topic392_0_0 -pt topic392_0_1 -u 0.012741709716452998 > ./result_8chains/node392_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_1_1 -p 107 -st topic392_1_0 -pt topic392_1_1 -u 0.009804872649608165 > ./result_8chains/node392_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_2_1 -p 129 -st topic392_2_0 -pt topic392_2_1 -u 0.003347104156692371 > ./result_8chains/node392_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_3_1 -p 330 -st topic392_3_0 -pt topic392_3_1 -u 0.0015461382515124522 > ./result_8chains/node392_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_4_1 -p 332 -st topic392_4_0 -pt topic392_4_1 -u 0.0010236471229204958 > ./result_8chains/node392_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_5_1 -p 348 -st topic392_5_0 -pt topic392_5_1 -u 0.0014923832901294898 > ./result_8chains/node392_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_6_1 -p 382 -st topic392_6_0 -pt topic392_6_1 -u 0.004559312831382792 > ./result_8chains/node392_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_7_1 -p 401 -st topic392_7_0 -pt topic392_7_1 -u 0.01569495232480982 > ./result_8chains/node392_7_1.txt &
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
    "./result_8chains/node392_0_1.txt 90"
    "./result_8chains/node392_1_1.txt 89"
    "./result_8chains/node392_2_1.txt 88"
    "./result_8chains/node392_3_1.txt 87"
    "./result_8chains/node392_4_1.txt 86"
    "./result_8chains/node392_5_1.txt 85"
    "./result_8chains/node392_6_1.txt 84"
    "./result_8chains/node392_7_1.txt 83"
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
