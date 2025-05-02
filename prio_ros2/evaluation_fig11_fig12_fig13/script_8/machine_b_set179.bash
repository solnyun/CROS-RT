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
ros2 run evaluation_3_randomdag uunifast_node -n node179_0_1 -p 273 -st topic179_0_0 -pt topic179_0_1 -u 0.006394158475665601 > ./result_8chains/node179_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_1_1 -p 313 -st topic179_1_0 -pt topic179_1_1 -u 0.03728188028949925 > ./result_8chains/node179_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_2_1 -p 479 -st topic179_2_0 -pt topic179_2_1 -u 0.005586620388151997 > ./result_8chains/node179_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_3_1 -p 522 -st topic179_3_0 -pt topic179_3_1 -u 0.003073845551143095 > ./result_8chains/node179_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_4_1 -p 530 -st topic179_4_0 -pt topic179_4_1 -u 0.007684315727934432 > ./result_8chains/node179_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_5_1 -p 568 -st topic179_5_0 -pt topic179_5_1 -u 0.01722581754151381 > ./result_8chains/node179_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_6_1 -p 586 -st topic179_6_0 -pt topic179_6_1 -u 0.022785757972646863 > ./result_8chains/node179_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_7_1 -p 684 -st topic179_7_0 -pt topic179_7_1 -u 0.018862976711411114 > ./result_8chains/node179_7_1.txt &
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
    "./result_8chains/node179_0_1.txt 90"
    "./result_8chains/node179_1_1.txt 89"
    "./result_8chains/node179_2_1.txt 88"
    "./result_8chains/node179_3_1.txt 87"
    "./result_8chains/node179_4_1.txt 86"
    "./result_8chains/node179_5_1.txt 85"
    "./result_8chains/node179_6_1.txt 84"
    "./result_8chains/node179_7_1.txt 83"
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
