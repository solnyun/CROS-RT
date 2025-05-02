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
ros2 run evaluation_3_randomdag uunifast_node -n node417_0_1 -p 186 -st topic417_0_0 -pt topic417_0_1 -u 0.006690731581014631 > ./result_8chains/node417_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_1_1 -p 190 -st topic417_1_0 -pt topic417_1_1 -u 0.005345256269746412 > ./result_8chains/node417_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_2_1 -p 281 -st topic417_2_0 -pt topic417_2_1 -u 0.02324919861241387 > ./result_8chains/node417_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_3_1 -p 317 -st topic417_3_0 -pt topic417_3_1 -u 0.008484585761831254 > ./result_8chains/node417_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_4_1 -p 468 -st topic417_4_0 -pt topic417_4_1 -u 0.06304625722191731 > ./result_8chains/node417_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_5_1 -p 643 -st topic417_5_0 -pt topic417_5_1 -u 0.03304787002094614 > ./result_8chains/node417_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_6_1 -p 711 -st topic417_6_0 -pt topic417_6_1 -u 0.09890135104286937 > ./result_8chains/node417_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_7_1 -p 789 -st topic417_7_0 -pt topic417_7_1 -u 0.018616451690838656 > ./result_8chains/node417_7_1.txt &
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
    "./result_8chains/node417_0_1.txt 90"
    "./result_8chains/node417_1_1.txt 89"
    "./result_8chains/node417_2_1.txt 88"
    "./result_8chains/node417_3_1.txt 87"
    "./result_8chains/node417_4_1.txt 86"
    "./result_8chains/node417_5_1.txt 85"
    "./result_8chains/node417_6_1.txt 84"
    "./result_8chains/node417_7_1.txt 83"
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
