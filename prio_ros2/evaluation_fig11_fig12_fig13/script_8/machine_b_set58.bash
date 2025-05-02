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
ros2 run evaluation_3_randomdag uunifast_node -n node58_0_1 -p 44 -st topic58_0_0 -pt topic58_0_1 -u 0.00801319994703592 > ./result_8chains/node58_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_1_1 -p 74 -st topic58_1_0 -pt topic58_1_1 -u 0.0029129407581328093 > ./result_8chains/node58_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_2_1 -p 185 -st topic58_2_0 -pt topic58_2_1 -u 0.0049510609798743554 > ./result_8chains/node58_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_3_1 -p 347 -st topic58_3_0 -pt topic58_3_1 -u 0.043289947160228326 > ./result_8chains/node58_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_4_1 -p 378 -st topic58_4_0 -pt topic58_4_1 -u 0.0010611913149424224 > ./result_8chains/node58_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_5_1 -p 809 -st topic58_5_0 -pt topic58_5_1 -u 0.01049756991741782 > ./result_8chains/node58_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_6_1 -p 877 -st topic58_6_0 -pt topic58_6_1 -u 0.03945743718016499 > ./result_8chains/node58_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_7_1 -p 941 -st topic58_7_0 -pt topic58_7_1 -u 0.01202029701440628 > ./result_8chains/node58_7_1.txt &
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
    "./result_8chains/node58_0_1.txt 90"
    "./result_8chains/node58_1_1.txt 89"
    "./result_8chains/node58_2_1.txt 88"
    "./result_8chains/node58_3_1.txt 87"
    "./result_8chains/node58_4_1.txt 86"
    "./result_8chains/node58_5_1.txt 85"
    "./result_8chains/node58_6_1.txt 84"
    "./result_8chains/node58_7_1.txt 83"
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
