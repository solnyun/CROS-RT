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
ros2 run evaluation_3_randomdag uunifast_node -n node403_0_1 -p 91 -st topic403_0_0 -pt topic403_0_1 -u 0.012252108732746347 > ./result_8chains/node403_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_1_1 -p 156 -st topic403_1_0 -pt topic403_1_1 -u 0.03756936908838737 > ./result_8chains/node403_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_2_1 -p 357 -st topic403_2_0 -pt topic403_2_1 -u 0.010420162116524412 > ./result_8chains/node403_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_3_1 -p 495 -st topic403_3_0 -pt topic403_3_1 -u 0.03258225945075527 > ./result_8chains/node403_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_4_1 -p 520 -st topic403_4_0 -pt topic403_4_1 -u 0.04061935308758052 > ./result_8chains/node403_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_5_1 -p 551 -st topic403_5_0 -pt topic403_5_1 -u 0.015182616705717175 > ./result_8chains/node403_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_6_1 -p 895 -st topic403_6_0 -pt topic403_6_1 -u 0.010407391706276733 > ./result_8chains/node403_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_7_1 -p 906 -st topic403_7_0 -pt topic403_7_1 -u 0.013337960450519604 > ./result_8chains/node403_7_1.txt &
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
    "./result_8chains/node403_0_1.txt 90"
    "./result_8chains/node403_1_1.txt 89"
    "./result_8chains/node403_2_1.txt 88"
    "./result_8chains/node403_3_1.txt 87"
    "./result_8chains/node403_4_1.txt 86"
    "./result_8chains/node403_5_1.txt 85"
    "./result_8chains/node403_6_1.txt 84"
    "./result_8chains/node403_7_1.txt 83"
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
