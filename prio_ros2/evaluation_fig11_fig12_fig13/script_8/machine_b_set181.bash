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
ros2 run evaluation_3_randomdag uunifast_node -n node181_0_1 -p 80 -st topic181_0_0 -pt topic181_0_1 -u 0.05906967205573793 > ./result_8chains/node181_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_1_1 -p 112 -st topic181_1_0 -pt topic181_1_1 -u 0.0036402889149450557 > ./result_8chains/node181_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_2_1 -p 427 -st topic181_2_0 -pt topic181_2_1 -u 0.0023302352922048297 > ./result_8chains/node181_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_3_1 -p 473 -st topic181_3_0 -pt topic181_3_1 -u 0.04825858144640083 > ./result_8chains/node181_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_4_1 -p 564 -st topic181_4_0 -pt topic181_4_1 -u 0.01711551329271202 > ./result_8chains/node181_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_5_1 -p 572 -st topic181_5_0 -pt topic181_5_1 -u 0.025685157999627867 > ./result_8chains/node181_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_6_1 -p 629 -st topic181_6_0 -pt topic181_6_1 -u 0.020825506916831313 > ./result_8chains/node181_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_7_1 -p 982 -st topic181_7_0 -pt topic181_7_1 -u 0.01848151502429643 > ./result_8chains/node181_7_1.txt &
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
    "./result_8chains/node181_0_1.txt 90"
    "./result_8chains/node181_1_1.txt 89"
    "./result_8chains/node181_2_1.txt 88"
    "./result_8chains/node181_3_1.txt 87"
    "./result_8chains/node181_4_1.txt 86"
    "./result_8chains/node181_5_1.txt 85"
    "./result_8chains/node181_6_1.txt 84"
    "./result_8chains/node181_7_1.txt 83"
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
