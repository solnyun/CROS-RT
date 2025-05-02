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
ros2 run evaluation_3_randomdag uunifast_node -n node58_0_2 -p 48 -st topic58_0_1 -pt None -u 0.031540597769643464 > ./result_6chains/node58_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_1_2 -p 56 -st topic58_1_1 -pt None -u 0.005481145218459826 > ./result_6chains/node58_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_2_2 -p 61 -st topic58_2_1 -pt None -u 0.01908462021844709 > ./result_6chains/node58_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_3_2 -p 434 -st topic58_3_1 -pt None -u 0.005895095998370736 > ./result_6chains/node58_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_4_2 -p 576 -st topic58_4_1 -pt None -u 0.0685296911973354 > ./result_6chains/node58_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_5_2 -p 851 -st topic58_5_1 -pt None -u 0.045339329297396785 > ./result_6chains/node58_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_0_0 -p 48 -st none -pt topic58_0_0 -u 0.024427868265816777 > ./result_6chains/node58_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_1_0 -p 56 -st none -pt topic58_1_0 -u 0.027922991054394164 > ./result_6chains/node58_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_2_0 -p 61 -st none -pt topic58_2_0 -u 0.01621148257001298 > ./result_6chains/node58_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_3_0 -p 434 -st none -pt topic58_3_0 -u 0.018051276438991348 > ./result_6chains/node58_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_4_0 -p 576 -st none -pt topic58_4_0 -u 0.024453642546427456 > ./result_6chains/node58_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_5_0 -p 851 -st none -pt topic58_5_0 -u 0.02459464225664651 > ./result_6chains/node58_5_0.txt &
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
    "./result_6chains/node58_0_0.txt 90"
    "./result_6chains/node58_0_2.txt 90"
    "./result_6chains/node58_1_0.txt 89"
    "./result_6chains/node58_1_2.txt 89"
    "./result_6chains/node58_2_0.txt 88"
    "./result_6chains/node58_2_2.txt 88"
    "./result_6chains/node58_3_0.txt 87"
    "./result_6chains/node58_3_2.txt 87"
    "./result_6chains/node58_4_0.txt 86"
    "./result_6chains/node58_4_2.txt 86"
    "./result_6chains/node58_5_0.txt 85"
    "./result_6chains/node58_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
