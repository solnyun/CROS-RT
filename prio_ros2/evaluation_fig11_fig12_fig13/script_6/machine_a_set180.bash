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
ros2 run evaluation_3_randomdag uunifast_node -n node180_0_2 -p 162 -st topic180_0_1 -pt None -u 0.029416674609927584 > ./result_6chains/node180_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_1_2 -p 172 -st topic180_1_1 -pt None -u 0.005057578388666661 > ./result_6chains/node180_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_2_2 -p 563 -st topic180_2_1 -pt None -u 0.0210049921838803 > ./result_6chains/node180_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_3_2 -p 686 -st topic180_3_1 -pt None -u 0.008742349058752485 > ./result_6chains/node180_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_4_2 -p 739 -st topic180_4_1 -pt None -u 0.01696219680770629 > ./result_6chains/node180_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_5_2 -p 775 -st topic180_5_1 -pt None -u 0.016181231466683526 > ./result_6chains/node180_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_0_0 -p 162 -st none -pt topic180_0_0 -u 0.022332422498251403 > ./result_6chains/node180_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_1_0 -p 172 -st none -pt topic180_1_0 -u 0.09220745886996662 > ./result_6chains/node180_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_2_0 -p 563 -st none -pt topic180_2_0 -u 0.05839534849772604 > ./result_6chains/node180_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_3_0 -p 686 -st none -pt topic180_3_0 -u 0.028922543909161158 > ./result_6chains/node180_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_4_0 -p 739 -st none -pt topic180_4_0 -u 0.029672242868393747 > ./result_6chains/node180_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_5_0 -p 775 -st none -pt topic180_5_0 -u 0.019843869378662508 > ./result_6chains/node180_5_0.txt &
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
    "./result_6chains/node180_0_0.txt 90"
    "./result_6chains/node180_0_2.txt 90"
    "./result_6chains/node180_1_0.txt 89"
    "./result_6chains/node180_1_2.txt 89"
    "./result_6chains/node180_2_0.txt 88"
    "./result_6chains/node180_2_2.txt 88"
    "./result_6chains/node180_3_0.txt 87"
    "./result_6chains/node180_3_2.txt 87"
    "./result_6chains/node180_4_0.txt 86"
    "./result_6chains/node180_4_2.txt 86"
    "./result_6chains/node180_5_0.txt 85"
    "./result_6chains/node180_5_2.txt 85"
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
