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
ros2 run evaluation_3_randomdag uunifast_node -n node430_0_1 -p 29 -st topic430_0_0 -pt topic430_0_1 -u 0.019448021486888456 > ./result_8chains/node430_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_1_1 -p 259 -st topic430_1_0 -pt topic430_1_1 -u 0.008415517979465215 > ./result_8chains/node430_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_2_1 -p 426 -st topic430_2_0 -pt topic430_2_1 -u 0.010750785471325408 > ./result_8chains/node430_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_3_1 -p 497 -st topic430_3_0 -pt topic430_3_1 -u 0.015463463204446304 > ./result_8chains/node430_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_4_1 -p 554 -st topic430_4_0 -pt topic430_4_1 -u 0.0012765327145966565 > ./result_8chains/node430_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_5_1 -p 626 -st topic430_5_0 -pt topic430_5_1 -u 0.01820718081714412 > ./result_8chains/node430_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_6_1 -p 798 -st topic430_6_0 -pt topic430_6_1 -u 0.00520658732281154 > ./result_8chains/node430_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_7_1 -p 837 -st topic430_7_0 -pt topic430_7_1 -u 0.09908232742908893 > ./result_8chains/node430_7_1.txt &
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
    "./result_8chains/node430_0_1.txt 90"
    "./result_8chains/node430_1_1.txt 89"
    "./result_8chains/node430_2_1.txt 88"
    "./result_8chains/node430_3_1.txt 87"
    "./result_8chains/node430_4_1.txt 86"
    "./result_8chains/node430_5_1.txt 85"
    "./result_8chains/node430_6_1.txt 84"
    "./result_8chains/node430_7_1.txt 83"
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
