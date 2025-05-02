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
ros2 run evaluation_3_randomdag uunifast_node -n node200_0_1 -p 69 -st topic200_0_0 -pt topic200_0_1 -u 0.012179897630069658 > ./result_10chains/node200_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_1_1 -p 74 -st topic200_1_0 -pt topic200_1_1 -u 0.03892031318548356 > ./result_10chains/node200_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_2_1 -p 97 -st topic200_2_0 -pt topic200_2_1 -u 0.05480174942247146 > ./result_10chains/node200_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_3_1 -p 113 -st topic200_3_0 -pt topic200_3_1 -u 0.0026341595956709263 > ./result_10chains/node200_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_4_1 -p 386 -st topic200_4_0 -pt topic200_4_1 -u 0.006616254415976686 > ./result_10chains/node200_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_5_1 -p 441 -st topic200_5_0 -pt topic200_5_1 -u 0.011641904886999122 > ./result_10chains/node200_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_6_1 -p 540 -st topic200_6_0 -pt topic200_6_1 -u 0.005028585835298693 > ./result_10chains/node200_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_7_1 -p 553 -st topic200_7_0 -pt topic200_7_1 -u 0.005946983051548421 > ./result_10chains/node200_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_8_1 -p 916 -st topic200_8_0 -pt topic200_8_1 -u 0.003664299063469323 > ./result_10chains/node200_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_9_1 -p 974 -st topic200_9_0 -pt topic200_9_1 -u 0.05948356111267663 > ./result_10chains/node200_9_1.txt &
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
    "./result_10chains/node200_0_1.txt 90"
    "./result_10chains/node200_1_1.txt 89"
    "./result_10chains/node200_2_1.txt 88"
    "./result_10chains/node200_3_1.txt 87"
    "./result_10chains/node200_4_1.txt 86"
    "./result_10chains/node200_5_1.txt 85"
    "./result_10chains/node200_6_1.txt 84"
    "./result_10chains/node200_7_1.txt 83"
    "./result_10chains/node200_8_1.txt 82"
    "./result_10chains/node200_9_1.txt 81"
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
