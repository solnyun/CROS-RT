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
ros2 run evaluation_3_randomdag uunifast_node -n node297_0_1 -p 60 -st topic297_0_0 -pt topic297_0_1 -u 0.024530535479415028 > ./result_8chains/node297_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_1_1 -p 166 -st topic297_1_0 -pt topic297_1_1 -u 0.017454173421584895 > ./result_8chains/node297_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_2_1 -p 297 -st topic297_2_0 -pt topic297_2_1 -u 0.08876549809542594 > ./result_8chains/node297_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_3_1 -p 431 -st topic297_3_0 -pt topic297_3_1 -u 0.003999898608305741 > ./result_8chains/node297_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_4_1 -p 454 -st topic297_4_0 -pt topic297_4_1 -u 0.027838030337098002 > ./result_8chains/node297_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_5_1 -p 582 -st topic297_5_0 -pt topic297_5_1 -u 0.01817151034141174 > ./result_8chains/node297_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_6_1 -p 619 -st topic297_6_0 -pt topic297_6_1 -u 0.0018049575834559878 > ./result_8chains/node297_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_7_1 -p 731 -st topic297_7_0 -pt topic297_7_1 -u 0.0014073382052088128 > ./result_8chains/node297_7_1.txt &
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
    "./result_8chains/node297_0_1.txt 90"
    "./result_8chains/node297_1_1.txt 89"
    "./result_8chains/node297_2_1.txt 88"
    "./result_8chains/node297_3_1.txt 87"
    "./result_8chains/node297_4_1.txt 86"
    "./result_8chains/node297_5_1.txt 85"
    "./result_8chains/node297_6_1.txt 84"
    "./result_8chains/node297_7_1.txt 83"
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
