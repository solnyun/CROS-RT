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
ros2 run evaluation_3_randomdag uunifast_node -n node436_0_2 -p 130 -st topic436_0_1 -pt None -u 0.0013695677308712684 > ./result_4chains/node436_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_1_2 -p 733 -st topic436_1_1 -pt None -u 0.07380713414320966 > ./result_4chains/node436_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_2_2 -p 736 -st topic436_2_1 -pt None -u 0.08091487826450511 > ./result_4chains/node436_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_3_2 -p 899 -st topic436_3_1 -pt None -u 0.038260023006766716 > ./result_4chains/node436_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_0_0 -p 130 -st none -pt topic436_0_0 -u 0.04639163602144386 > ./result_4chains/node436_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_1_0 -p 733 -st none -pt topic436_1_0 -u 0.006248744111456761 > ./result_4chains/node436_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_2_0 -p 736 -st none -pt topic436_2_0 -u 0.10506079304734631 > ./result_4chains/node436_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_3_0 -p 899 -st none -pt topic436_3_0 -u 0.06290555561570942 > ./result_4chains/node436_3_0.txt &
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
    "./result_4chains/node436_0_0.txt 90"
    "./result_4chains/node436_0_2.txt 90"
    "./result_4chains/node436_1_0.txt 89"
    "./result_4chains/node436_1_2.txt 89"
    "./result_4chains/node436_2_0.txt 88"
    "./result_4chains/node436_2_2.txt 88"
    "./result_4chains/node436_3_0.txt 87"
    "./result_4chains/node436_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
