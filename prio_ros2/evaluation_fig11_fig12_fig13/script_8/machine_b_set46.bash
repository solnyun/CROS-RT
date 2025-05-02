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
ros2 run evaluation_3_randomdag uunifast_node -n node46_0_1 -p 45 -st topic46_0_0 -pt topic46_0_1 -u 0.02785577295084002 > ./result_8chains/node46_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node46_1_1 -p 253 -st topic46_1_0 -pt topic46_1_1 -u 0.034724090738706914 > ./result_8chains/node46_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node46_2_1 -p 424 -st topic46_2_0 -pt topic46_2_1 -u 0.011028075505495727 > ./result_8chains/node46_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node46_3_1 -p 484 -st topic46_3_0 -pt topic46_3_1 -u 0.001515666878395161 > ./result_8chains/node46_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node46_4_1 -p 500 -st topic46_4_0 -pt topic46_4_1 -u 0.03904217632692883 > ./result_8chains/node46_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node46_5_1 -p 621 -st topic46_5_0 -pt topic46_5_1 -u 0.024690527218897418 > ./result_8chains/node46_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node46_6_1 -p 931 -st topic46_6_0 -pt topic46_6_1 -u 0.05224006797285215 > ./result_8chains/node46_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node46_7_1 -p 961 -st topic46_7_0 -pt topic46_7_1 -u 0.03912477428354366 > ./result_8chains/node46_7_1.txt &
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
    "./result_8chains/node46_0_1.txt 90"
    "./result_8chains/node46_1_1.txt 89"
    "./result_8chains/node46_2_1.txt 88"
    "./result_8chains/node46_3_1.txt 87"
    "./result_8chains/node46_4_1.txt 86"
    "./result_8chains/node46_5_1.txt 85"
    "./result_8chains/node46_6_1.txt 84"
    "./result_8chains/node46_7_1.txt 83"
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
