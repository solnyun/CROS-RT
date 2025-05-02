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
ros2 run evaluation_3_randomdag uunifast_node -n node407_0_2 -p 18 -st topic407_0_1 -pt None -u 0.0013590301152680007 > ./result_6chains/node407_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_1_2 -p 21 -st topic407_1_1 -pt None -u 0.014925013598898862 > ./result_6chains/node407_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_2_2 -p 41 -st topic407_2_1 -pt None -u 0.03044680916896525 > ./result_6chains/node407_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_3_2 -p 271 -st topic407_3_1 -pt None -u 0.14121790163148612 > ./result_6chains/node407_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_4_2 -p 594 -st topic407_4_1 -pt None -u 0.0015677259456748083 > ./result_6chains/node407_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_5_2 -p 991 -st topic407_5_1 -pt None -u 0.0050161018911786676 > ./result_6chains/node407_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_0_0 -p 18 -st none -pt topic407_0_0 -u 0.007173320127507099 > ./result_6chains/node407_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_1_0 -p 21 -st none -pt topic407_1_0 -u 0.051119662909379415 > ./result_6chains/node407_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_2_0 -p 41 -st none -pt topic407_2_0 -u 0.008761279330657401 > ./result_6chains/node407_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_3_0 -p 271 -st none -pt topic407_3_0 -u 0.06746930859994485 > ./result_6chains/node407_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_4_0 -p 594 -st none -pt topic407_4_0 -u 0.024531835308489472 > ./result_6chains/node407_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_5_0 -p 991 -st none -pt topic407_5_0 -u 0.00738314438498546 > ./result_6chains/node407_5_0.txt &
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
    "./result_6chains/node407_0_0.txt 90"
    "./result_6chains/node407_0_2.txt 90"
    "./result_6chains/node407_1_0.txt 89"
    "./result_6chains/node407_1_2.txt 89"
    "./result_6chains/node407_2_0.txt 88"
    "./result_6chains/node407_2_2.txt 88"
    "./result_6chains/node407_3_0.txt 87"
    "./result_6chains/node407_3_2.txt 87"
    "./result_6chains/node407_4_0.txt 86"
    "./result_6chains/node407_4_2.txt 86"
    "./result_6chains/node407_5_0.txt 85"
    "./result_6chains/node407_5_2.txt 85"
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
