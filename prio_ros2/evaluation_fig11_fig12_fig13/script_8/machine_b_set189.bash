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
ros2 run evaluation_3_randomdag uunifast_node -n node189_0_1 -p 75 -st topic189_0_0 -pt topic189_0_1 -u 0.004823750826220774 > ./result_8chains/node189_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_1_1 -p 150 -st topic189_1_0 -pt topic189_1_1 -u 0.004013470816026543 > ./result_8chains/node189_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_2_1 -p 277 -st topic189_2_0 -pt topic189_2_1 -u 0.01585046428272524 > ./result_8chains/node189_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_3_1 -p 307 -st topic189_3_0 -pt topic189_3_1 -u 0.024123103516957484 > ./result_8chains/node189_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_4_1 -p 324 -st topic189_4_0 -pt topic189_4_1 -u 0.08689726466569853 > ./result_8chains/node189_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_5_1 -p 357 -st topic189_5_0 -pt topic189_5_1 -u 0.013707542368765091 > ./result_8chains/node189_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_6_1 -p 565 -st topic189_6_0 -pt topic189_6_1 -u 0.01743454126640955 > ./result_8chains/node189_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_7_1 -p 707 -st topic189_7_0 -pt topic189_7_1 -u 0.0004056141995355776 > ./result_8chains/node189_7_1.txt &
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
    "./result_8chains/node189_0_1.txt 90"
    "./result_8chains/node189_1_1.txt 89"
    "./result_8chains/node189_2_1.txt 88"
    "./result_8chains/node189_3_1.txt 87"
    "./result_8chains/node189_4_1.txt 86"
    "./result_8chains/node189_5_1.txt 85"
    "./result_8chains/node189_6_1.txt 84"
    "./result_8chains/node189_7_1.txt 83"
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
