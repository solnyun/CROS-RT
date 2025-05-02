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
ros2 run evaluation_3_randomdag uunifast_node -n node375_0_1 -p 64 -st topic375_0_0 -pt topic375_0_1 -u 0.005853188145209798 > ./result_8chains/node375_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_1_1 -p 229 -st topic375_1_0 -pt topic375_1_1 -u 0.0026451410664194985 > ./result_8chains/node375_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_2_1 -p 243 -st topic375_2_0 -pt topic375_2_1 -u 0.021035680715511762 > ./result_8chains/node375_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_3_1 -p 257 -st topic375_3_0 -pt topic375_3_1 -u 0.0010256874838684982 > ./result_8chains/node375_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_4_1 -p 484 -st topic375_4_0 -pt topic375_4_1 -u 0.005764114369574913 > ./result_8chains/node375_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_5_1 -p 580 -st topic375_5_0 -pt topic375_5_1 -u 0.04232483997911374 > ./result_8chains/node375_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_6_1 -p 971 -st topic375_6_0 -pt topic375_6_1 -u 0.0009568171996060804 > ./result_8chains/node375_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_7_1 -p 985 -st topic375_7_0 -pt topic375_7_1 -u 0.0862513895244229 > ./result_8chains/node375_7_1.txt &
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
    "./result_8chains/node375_0_1.txt 90"
    "./result_8chains/node375_1_1.txt 89"
    "./result_8chains/node375_2_1.txt 88"
    "./result_8chains/node375_3_1.txt 87"
    "./result_8chains/node375_4_1.txt 86"
    "./result_8chains/node375_5_1.txt 85"
    "./result_8chains/node375_6_1.txt 84"
    "./result_8chains/node375_7_1.txt 83"
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
