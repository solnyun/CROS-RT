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
ros2 run evaluation_3_randomdag uunifast_node -n node313_0_2 -p 92 -st topic313_0_1 -pt None -u 0.015711271979973074 > ./result_8chains/node313_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_1_2 -p 228 -st topic313_1_1 -pt None -u 0.011555303960052443 > ./result_8chains/node313_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_2_2 -p 334 -st topic313_2_1 -pt None -u 0.031963072946824767 > ./result_8chains/node313_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_3_2 -p 626 -st topic313_3_1 -pt None -u 0.022839092023059476 > ./result_8chains/node313_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_4_2 -p 840 -st topic313_4_1 -pt None -u 0.005787778713823605 > ./result_8chains/node313_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_5_2 -p 862 -st topic313_5_1 -pt None -u 0.004665674130203856 > ./result_8chains/node313_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_6_2 -p 869 -st topic313_6_1 -pt None -u 0.00474267524221391 > ./result_8chains/node313_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_7_2 -p 933 -st topic313_7_1 -pt None -u 0.013097424236425268 > ./result_8chains/node313_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_0_0 -p 92 -st none -pt topic313_0_0 -u 0.0042851340432978335 > ./result_8chains/node313_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_1_0 -p 228 -st none -pt topic313_1_0 -u 0.028958691540437398 > ./result_8chains/node313_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_2_0 -p 334 -st none -pt topic313_2_0 -u 0.03262458748311309 > ./result_8chains/node313_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_3_0 -p 626 -st none -pt topic313_3_0 -u 0.014777658456932685 > ./result_8chains/node313_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_4_0 -p 840 -st none -pt topic313_4_0 -u 0.022038937969268424 > ./result_8chains/node313_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_5_0 -p 862 -st none -pt topic313_5_0 -u 0.00882200500383154 > ./result_8chains/node313_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_6_0 -p 869 -st none -pt topic313_6_0 -u 0.009226530281170209 > ./result_8chains/node313_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_7_0 -p 933 -st none -pt topic313_7_0 -u 0.024707934192875414 > ./result_8chains/node313_7_0.txt &
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
    "./result_8chains/node313_0_0.txt 90"
    "./result_8chains/node313_0_2.txt 90"
    "./result_8chains/node313_1_0.txt 89"
    "./result_8chains/node313_1_2.txt 89"
    "./result_8chains/node313_2_0.txt 88"
    "./result_8chains/node313_2_2.txt 88"
    "./result_8chains/node313_3_0.txt 87"
    "./result_8chains/node313_3_2.txt 87"
    "./result_8chains/node313_4_0.txt 86"
    "./result_8chains/node313_4_2.txt 86"
    "./result_8chains/node313_5_0.txt 85"
    "./result_8chains/node313_5_2.txt 85"
    "./result_8chains/node313_6_0.txt 84"
    "./result_8chains/node313_6_2.txt 84"
    "./result_8chains/node313_7_0.txt 83"
    "./result_8chains/node313_7_2.txt 83"
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
