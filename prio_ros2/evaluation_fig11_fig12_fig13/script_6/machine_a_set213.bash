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
ros2 run evaluation_3_randomdag uunifast_node -n node213_0_2 -p 48 -st topic213_0_1 -pt None -u 0.009486231331525596 > ./result_6chains/node213_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_1_2 -p 140 -st topic213_1_1 -pt None -u 0.013154643929109366 > ./result_6chains/node213_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_2_2 -p 206 -st topic213_2_1 -pt None -u 0.07451490637758673 > ./result_6chains/node213_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_3_2 -p 442 -st topic213_3_1 -pt None -u 0.04326614123150713 > ./result_6chains/node213_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_4_2 -p 926 -st topic213_4_1 -pt None -u 0.04086927377600172 > ./result_6chains/node213_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_5_2 -p 990 -st topic213_5_1 -pt None -u 0.03298126916754329 > ./result_6chains/node213_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_0_0 -p 48 -st none -pt topic213_0_0 -u 0.013318480125986909 > ./result_6chains/node213_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_1_0 -p 140 -st none -pt topic213_1_0 -u 0.03215894554353621 > ./result_6chains/node213_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_2_0 -p 206 -st none -pt topic213_2_0 -u 0.0510891836640292 > ./result_6chains/node213_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_3_0 -p 442 -st none -pt topic213_3_0 -u 0.006587071328042593 > ./result_6chains/node213_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_4_0 -p 926 -st none -pt topic213_4_0 -u 0.015383891731556881 > ./result_6chains/node213_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_5_0 -p 990 -st none -pt topic213_5_0 -u 0.05553630132530581 > ./result_6chains/node213_5_0.txt &
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
    "./result_6chains/node213_0_0.txt 90"
    "./result_6chains/node213_0_2.txt 90"
    "./result_6chains/node213_1_0.txt 89"
    "./result_6chains/node213_1_2.txt 89"
    "./result_6chains/node213_2_0.txt 88"
    "./result_6chains/node213_2_2.txt 88"
    "./result_6chains/node213_3_0.txt 87"
    "./result_6chains/node213_3_2.txt 87"
    "./result_6chains/node213_4_0.txt 86"
    "./result_6chains/node213_4_2.txt 86"
    "./result_6chains/node213_5_0.txt 85"
    "./result_6chains/node213_5_2.txt 85"
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
