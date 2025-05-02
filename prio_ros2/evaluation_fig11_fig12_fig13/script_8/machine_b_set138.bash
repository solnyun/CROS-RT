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
ros2 run evaluation_3_randomdag uunifast_node -n node138_0_1 -p 110 -st topic138_0_0 -pt topic138_0_1 -u 0.011230305707639332 > ./result_8chains/node138_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_1_1 -p 113 -st topic138_1_0 -pt topic138_1_1 -u 0.0061470677198773305 > ./result_8chains/node138_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_2_1 -p 427 -st topic138_2_0 -pt topic138_2_1 -u 0.030132578386893816 > ./result_8chains/node138_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_3_1 -p 533 -st topic138_3_0 -pt topic138_3_1 -u 0.050464491839748604 > ./result_8chains/node138_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_4_1 -p 581 -st topic138_4_0 -pt topic138_4_1 -u 0.0036539402377372687 > ./result_8chains/node138_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_5_1 -p 596 -st topic138_5_0 -pt topic138_5_1 -u 0.002968131443088745 > ./result_8chains/node138_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_6_1 -p 606 -st topic138_6_0 -pt topic138_6_1 -u 0.002735611537960675 > ./result_8chains/node138_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_7_1 -p 907 -st topic138_7_0 -pt topic138_7_1 -u 0.00938775494397203 > ./result_8chains/node138_7_1.txt &
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
    "./result_8chains/node138_0_1.txt 90"
    "./result_8chains/node138_1_1.txt 89"
    "./result_8chains/node138_2_1.txt 88"
    "./result_8chains/node138_3_1.txt 87"
    "./result_8chains/node138_4_1.txt 86"
    "./result_8chains/node138_5_1.txt 85"
    "./result_8chains/node138_6_1.txt 84"
    "./result_8chains/node138_7_1.txt 83"
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
