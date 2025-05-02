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
ros2 run evaluation_3_randomdag uunifast_node -n node484_0_1 -p 155 -st topic484_0_0 -pt topic484_0_1 -u 0.018902158318709172 > ./result_8chains/node484_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_1_1 -p 181 -st topic484_1_0 -pt topic484_1_1 -u 0.01624943513503685 > ./result_8chains/node484_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_2_1 -p 373 -st topic484_2_0 -pt topic484_2_1 -u 0.061938645639518786 > ./result_8chains/node484_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_3_1 -p 379 -st topic484_3_0 -pt topic484_3_1 -u 0.026353571614132543 > ./result_8chains/node484_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_4_1 -p 432 -st topic484_4_0 -pt topic484_4_1 -u 0.06536095943411455 > ./result_8chains/node484_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_5_1 -p 478 -st topic484_5_0 -pt topic484_5_1 -u 0.015929966578866778 > ./result_8chains/node484_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_6_1 -p 527 -st topic484_6_0 -pt topic484_6_1 -u 0.016933366550991757 > ./result_8chains/node484_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_7_1 -p 984 -st topic484_7_0 -pt topic484_7_1 -u 0.006585908797540021 > ./result_8chains/node484_7_1.txt &
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
    "./result_8chains/node484_0_1.txt 90"
    "./result_8chains/node484_1_1.txt 89"
    "./result_8chains/node484_2_1.txt 88"
    "./result_8chains/node484_3_1.txt 87"
    "./result_8chains/node484_4_1.txt 86"
    "./result_8chains/node484_5_1.txt 85"
    "./result_8chains/node484_6_1.txt 84"
    "./result_8chains/node484_7_1.txt 83"
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
