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
ros2 run evaluation_3_randomdag uunifast_node -n node5_0_1 -p 200 -st topic5_0_0 -pt topic5_0_1 -u 0.023955024958625892 > ./result_8chains/node5_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node5_1_1 -p 255 -st topic5_1_0 -pt topic5_1_1 -u 0.015037969375622573 > ./result_8chains/node5_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node5_2_1 -p 270 -st topic5_2_0 -pt topic5_2_1 -u 0.015105872938478704 > ./result_8chains/node5_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node5_3_1 -p 288 -st topic5_3_0 -pt topic5_3_1 -u 0.011717216159179367 > ./result_8chains/node5_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node5_4_1 -p 491 -st topic5_4_0 -pt topic5_4_1 -u 0.031396411741218044 > ./result_8chains/node5_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node5_5_1 -p 640 -st topic5_5_0 -pt topic5_5_1 -u 0.06693799246671331 > ./result_8chains/node5_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node5_6_1 -p 819 -st topic5_6_0 -pt topic5_6_1 -u 0.00774167546089214 > ./result_8chains/node5_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node5_7_1 -p 866 -st topic5_7_0 -pt topic5_7_1 -u 0.022142767530136442 > ./result_8chains/node5_7_1.txt &
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
    "./result_8chains/node5_0_1.txt 90"
    "./result_8chains/node5_1_1.txt 89"
    "./result_8chains/node5_2_1.txt 88"
    "./result_8chains/node5_3_1.txt 87"
    "./result_8chains/node5_4_1.txt 86"
    "./result_8chains/node5_5_1.txt 85"
    "./result_8chains/node5_6_1.txt 84"
    "./result_8chains/node5_7_1.txt 83"
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
