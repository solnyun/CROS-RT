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
ros2 run evaluation_3_randomdag uunifast_node -n node219_0_2 -p 185 -st topic219_0_1 -pt None -u 0.00991925223301171 > ./result_6chains/node219_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_1_2 -p 306 -st topic219_1_1 -pt None -u 0.017816155301059844 > ./result_6chains/node219_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_2_2 -p 514 -st topic219_2_1 -pt None -u 0.001905926289881399 > ./result_6chains/node219_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_3_2 -p 615 -st topic219_3_1 -pt None -u 0.04944249704067302 > ./result_6chains/node219_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_4_2 -p 655 -st topic219_4_1 -pt None -u 0.015866818560094725 > ./result_6chains/node219_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_5_2 -p 677 -st topic219_5_1 -pt None -u 0.03680252452875996 > ./result_6chains/node219_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_0_0 -p 185 -st none -pt topic219_0_0 -u 0.004205868846386185 > ./result_6chains/node219_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_1_0 -p 306 -st none -pt topic219_1_0 -u 0.03502422360803309 > ./result_6chains/node219_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_2_0 -p 514 -st none -pt topic219_2_0 -u 0.024805734761424558 > ./result_6chains/node219_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_3_0 -p 615 -st none -pt topic219_3_0 -u 0.010877605814061858 > ./result_6chains/node219_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_4_0 -p 655 -st none -pt topic219_4_0 -u 0.011781659285466428 > ./result_6chains/node219_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_5_0 -p 677 -st none -pt topic219_5_0 -u 0.04375201766665529 > ./result_6chains/node219_5_0.txt &
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
    "./result_6chains/node219_0_0.txt 90"
    "./result_6chains/node219_0_2.txt 90"
    "./result_6chains/node219_1_0.txt 89"
    "./result_6chains/node219_1_2.txt 89"
    "./result_6chains/node219_2_0.txt 88"
    "./result_6chains/node219_2_2.txt 88"
    "./result_6chains/node219_3_0.txt 87"
    "./result_6chains/node219_3_2.txt 87"
    "./result_6chains/node219_4_0.txt 86"
    "./result_6chains/node219_4_2.txt 86"
    "./result_6chains/node219_5_0.txt 85"
    "./result_6chains/node219_5_2.txt 85"
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
