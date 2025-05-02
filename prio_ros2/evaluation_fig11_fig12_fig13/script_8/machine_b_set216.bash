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
ros2 run evaluation_3_randomdag uunifast_node -n node216_0_1 -p 58 -st topic216_0_0 -pt topic216_0_1 -u 0.04905297959594379 > ./result_8chains/node216_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_1_1 -p 71 -st topic216_1_0 -pt topic216_1_1 -u 0.012697714640260815 > ./result_8chains/node216_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_2_1 -p 133 -st topic216_2_0 -pt topic216_2_1 -u 0.00176793590900709 > ./result_8chains/node216_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_3_1 -p 238 -st topic216_3_0 -pt topic216_3_1 -u 0.01637591288021903 > ./result_8chains/node216_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_4_1 -p 442 -st topic216_4_0 -pt topic216_4_1 -u 0.004186610484563202 > ./result_8chains/node216_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_5_1 -p 487 -st topic216_5_0 -pt topic216_5_1 -u 0.024670775738455844 > ./result_8chains/node216_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_6_1 -p 602 -st topic216_6_0 -pt topic216_6_1 -u 0.001625520356101924 > ./result_8chains/node216_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_7_1 -p 605 -st topic216_7_0 -pt topic216_7_1 -u 0.019504738200399406 > ./result_8chains/node216_7_1.txt &
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
    "./result_8chains/node216_0_1.txt 90"
    "./result_8chains/node216_1_1.txt 89"
    "./result_8chains/node216_2_1.txt 88"
    "./result_8chains/node216_3_1.txt 87"
    "./result_8chains/node216_4_1.txt 86"
    "./result_8chains/node216_5_1.txt 85"
    "./result_8chains/node216_6_1.txt 84"
    "./result_8chains/node216_7_1.txt 83"
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
