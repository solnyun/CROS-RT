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
ros2 run evaluation_3_randomdag uunifast_node -n node424_0_1 -p 93 -st topic424_0_0 -pt topic424_0_1 -u 0.00756916788199774 > ./result_8chains/node424_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_1_1 -p 277 -st topic424_1_0 -pt topic424_1_1 -u 0.03620965970876211 > ./result_8chains/node424_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_2_1 -p 474 -st topic424_2_0 -pt topic424_2_1 -u 0.01427461599546831 > ./result_8chains/node424_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_3_1 -p 486 -st topic424_3_0 -pt topic424_3_1 -u 0.01991658426843551 > ./result_8chains/node424_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_4_1 -p 554 -st topic424_4_0 -pt topic424_4_1 -u 0.009686989232000343 > ./result_8chains/node424_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_5_1 -p 768 -st topic424_5_0 -pt topic424_5_1 -u 0.018479135673013514 > ./result_8chains/node424_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_6_1 -p 886 -st topic424_6_0 -pt topic424_6_1 -u 0.019904603587135986 > ./result_8chains/node424_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_7_1 -p 902 -st topic424_7_0 -pt topic424_7_1 -u 0.01159701298877101 > ./result_8chains/node424_7_1.txt &
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
    "./result_8chains/node424_0_1.txt 90"
    "./result_8chains/node424_1_1.txt 89"
    "./result_8chains/node424_2_1.txt 88"
    "./result_8chains/node424_3_1.txt 87"
    "./result_8chains/node424_4_1.txt 86"
    "./result_8chains/node424_5_1.txt 85"
    "./result_8chains/node424_6_1.txt 84"
    "./result_8chains/node424_7_1.txt 83"
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
