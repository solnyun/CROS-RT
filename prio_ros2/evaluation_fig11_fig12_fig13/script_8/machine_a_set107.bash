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
ros2 run evaluation_3_randomdag uunifast_node -n node107_0_2 -p 12 -st topic107_0_1 -pt None -u 0.0151891649616826 > ./result_8chains/node107_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_1_2 -p 25 -st topic107_1_1 -pt None -u 0.0020606904302820084 > ./result_8chains/node107_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_2_2 -p 99 -st topic107_2_1 -pt None -u 0.004715787652991799 > ./result_8chains/node107_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_3_2 -p 484 -st topic107_3_1 -pt None -u 0.021759103209810726 > ./result_8chains/node107_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_4_2 -p 511 -st topic107_4_1 -pt None -u 0.025051421257457435 > ./result_8chains/node107_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_5_2 -p 554 -st topic107_5_1 -pt None -u 0.0017240183139885512 > ./result_8chains/node107_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_6_2 -p 661 -st topic107_6_1 -pt None -u 0.018000492741497454 > ./result_8chains/node107_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_7_2 -p 774 -st topic107_7_1 -pt None -u 0.00502636343554309 > ./result_8chains/node107_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_0_0 -p 12 -st none -pt topic107_0_0 -u 0.002169335106351866 > ./result_8chains/node107_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_1_0 -p 25 -st none -pt topic107_1_0 -u 0.022960767946100358 > ./result_8chains/node107_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_2_0 -p 99 -st none -pt topic107_2_0 -u 0.028463165076634045 > ./result_8chains/node107_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_3_0 -p 484 -st none -pt topic107_3_0 -u 0.03636777392971635 > ./result_8chains/node107_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_4_0 -p 511 -st none -pt topic107_4_0 -u 0.027551908029139538 > ./result_8chains/node107_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_5_0 -p 554 -st none -pt topic107_5_0 -u 0.05781383398023182 > ./result_8chains/node107_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_6_0 -p 661 -st none -pt topic107_6_0 -u 0.04287675774192033 > ./result_8chains/node107_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_7_0 -p 774 -st none -pt topic107_7_0 -u 0.06049732172709901 > ./result_8chains/node107_7_0.txt &
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
    "./result_8chains/node107_0_0.txt 90"
    "./result_8chains/node107_0_2.txt 90"
    "./result_8chains/node107_1_0.txt 89"
    "./result_8chains/node107_1_2.txt 89"
    "./result_8chains/node107_2_0.txt 88"
    "./result_8chains/node107_2_2.txt 88"
    "./result_8chains/node107_3_0.txt 87"
    "./result_8chains/node107_3_2.txt 87"
    "./result_8chains/node107_4_0.txt 86"
    "./result_8chains/node107_4_2.txt 86"
    "./result_8chains/node107_5_0.txt 85"
    "./result_8chains/node107_5_2.txt 85"
    "./result_8chains/node107_6_0.txt 84"
    "./result_8chains/node107_6_2.txt 84"
    "./result_8chains/node107_7_0.txt 83"
    "./result_8chains/node107_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
