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
ros2 run evaluation_3_randomdag uunifast_node -n node298_0_1 -p 62 -st topic298_0_0 -pt topic298_0_1 -u 0.004846140510907149 > ./result_8chains/node298_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_1_1 -p 91 -st topic298_1_0 -pt topic298_1_1 -u 0.028655503794403125 > ./result_8chains/node298_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_2_1 -p 467 -st topic298_2_0 -pt topic298_2_1 -u 0.0049126177824525 > ./result_8chains/node298_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_3_1 -p 496 -st topic298_3_0 -pt topic298_3_1 -u 0.003067634205212333 > ./result_8chains/node298_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_4_1 -p 744 -st topic298_4_0 -pt topic298_4_1 -u 0.004853240643545337 > ./result_8chains/node298_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_5_1 -p 831 -st topic298_5_0 -pt topic298_5_1 -u 0.005797131292652163 > ./result_8chains/node298_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_6_1 -p 862 -st topic298_6_0 -pt topic298_6_1 -u 0.006783834045185719 > ./result_8chains/node298_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_7_1 -p 893 -st topic298_7_0 -pt topic298_7_1 -u 0.0007358273072157334 > ./result_8chains/node298_7_1.txt &
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
    "./result_8chains/node298_0_1.txt 90"
    "./result_8chains/node298_1_1.txt 89"
    "./result_8chains/node298_2_1.txt 88"
    "./result_8chains/node298_3_1.txt 87"
    "./result_8chains/node298_4_1.txt 86"
    "./result_8chains/node298_5_1.txt 85"
    "./result_8chains/node298_6_1.txt 84"
    "./result_8chains/node298_7_1.txt 83"
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
