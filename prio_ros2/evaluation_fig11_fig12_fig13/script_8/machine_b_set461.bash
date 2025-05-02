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
ros2 run evaluation_3_randomdag uunifast_node -n node461_0_1 -p 169 -st topic461_0_0 -pt topic461_0_1 -u 0.023653059521273778 > ./result_8chains/node461_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_1_1 -p 277 -st topic461_1_0 -pt topic461_1_1 -u 0.02085331424606157 > ./result_8chains/node461_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_2_1 -p 452 -st topic461_2_0 -pt topic461_2_1 -u 0.007757785785465154 > ./result_8chains/node461_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_3_1 -p 517 -st topic461_3_0 -pt topic461_3_1 -u 0.013753304088043206 > ./result_8chains/node461_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_4_1 -p 548 -st topic461_4_0 -pt topic461_4_1 -u 0.07678010465612892 > ./result_8chains/node461_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_5_1 -p 580 -st topic461_5_0 -pt topic461_5_1 -u 0.04011040758475458 > ./result_8chains/node461_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_6_1 -p 759 -st topic461_6_0 -pt topic461_6_1 -u 0.008907295038793575 > ./result_8chains/node461_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_7_1 -p 786 -st topic461_7_0 -pt topic461_7_1 -u 0.04332799666540254 > ./result_8chains/node461_7_1.txt &
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
    "./result_8chains/node461_0_1.txt 90"
    "./result_8chains/node461_1_1.txt 89"
    "./result_8chains/node461_2_1.txt 88"
    "./result_8chains/node461_3_1.txt 87"
    "./result_8chains/node461_4_1.txt 86"
    "./result_8chains/node461_5_1.txt 85"
    "./result_8chains/node461_6_1.txt 84"
    "./result_8chains/node461_7_1.txt 83"
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
