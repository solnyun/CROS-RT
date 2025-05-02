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
ros2 run evaluation_3_randomdag uunifast_node -n node200_0_1 -p 18 -st topic200_0_0 -pt topic200_0_1 -u 0.006961398883322478 > ./result_8chains/node200_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_1_1 -p 31 -st topic200_1_0 -pt topic200_1_1 -u 0.006911242983413224 > ./result_8chains/node200_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_2_1 -p 100 -st topic200_2_0 -pt topic200_2_1 -u 0.01177789089316883 > ./result_8chains/node200_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_3_1 -p 131 -st topic200_3_0 -pt topic200_3_1 -u 0.0072612295302811325 > ./result_8chains/node200_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_4_1 -p 327 -st topic200_4_0 -pt topic200_4_1 -u 0.04413700397089021 > ./result_8chains/node200_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_5_1 -p 366 -st topic200_5_0 -pt topic200_5_1 -u 0.007689776005665672 > ./result_8chains/node200_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_6_1 -p 484 -st topic200_6_0 -pt topic200_6_1 -u 0.10075904324034159 > ./result_8chains/node200_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_7_1 -p 953 -st topic200_7_0 -pt topic200_7_1 -u 0.029423427166898206 > ./result_8chains/node200_7_1.txt &
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
    "./result_8chains/node200_0_1.txt 90"
    "./result_8chains/node200_1_1.txt 89"
    "./result_8chains/node200_2_1.txt 88"
    "./result_8chains/node200_3_1.txt 87"
    "./result_8chains/node200_4_1.txt 86"
    "./result_8chains/node200_5_1.txt 85"
    "./result_8chains/node200_6_1.txt 84"
    "./result_8chains/node200_7_1.txt 83"
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
