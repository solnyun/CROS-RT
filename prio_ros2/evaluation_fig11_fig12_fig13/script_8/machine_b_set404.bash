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
ros2 run evaluation_3_randomdag uunifast_node -n node404_0_1 -p 402 -st topic404_0_0 -pt topic404_0_1 -u 0.007261420303795507 > ./result_8chains/node404_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_1_1 -p 466 -st topic404_1_0 -pt topic404_1_1 -u 0.019519571021719195 > ./result_8chains/node404_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_2_1 -p 480 -st topic404_2_0 -pt topic404_2_1 -u 0.013982639976428235 > ./result_8chains/node404_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_3_1 -p 492 -st topic404_3_0 -pt topic404_3_1 -u 0.038726538149767065 > ./result_8chains/node404_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_4_1 -p 620 -st topic404_4_0 -pt topic404_4_1 -u 0.024951902007105037 > ./result_8chains/node404_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_5_1 -p 703 -st topic404_5_0 -pt topic404_5_1 -u 0.013134936921977702 > ./result_8chains/node404_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_6_1 -p 979 -st topic404_6_0 -pt topic404_6_1 -u 0.015654719132040938 > ./result_8chains/node404_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_7_1 -p 986 -st topic404_7_0 -pt topic404_7_1 -u 0.009028744337721748 > ./result_8chains/node404_7_1.txt &
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
    "./result_8chains/node404_0_1.txt 90"
    "./result_8chains/node404_1_1.txt 89"
    "./result_8chains/node404_2_1.txt 88"
    "./result_8chains/node404_3_1.txt 87"
    "./result_8chains/node404_4_1.txt 86"
    "./result_8chains/node404_5_1.txt 85"
    "./result_8chains/node404_6_1.txt 84"
    "./result_8chains/node404_7_1.txt 83"
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
