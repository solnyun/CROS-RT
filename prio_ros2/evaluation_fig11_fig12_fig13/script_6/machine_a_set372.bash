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
ros2 run evaluation_3_randomdag uunifast_node -n node372_0_2 -p 135 -st topic372_0_1 -pt None -u 0.03029030940006383 > ./result_6chains/node372_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_1_2 -p 300 -st topic372_1_1 -pt None -u 0.008653223768117724 > ./result_6chains/node372_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_2_2 -p 477 -st topic372_2_1 -pt None -u 0.03171806353631912 > ./result_6chains/node372_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_3_2 -p 697 -st topic372_3_1 -pt None -u 0.09527964161435123 > ./result_6chains/node372_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_4_2 -p 870 -st topic372_4_1 -pt None -u 0.03137811833443739 > ./result_6chains/node372_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_5_2 -p 885 -st topic372_5_1 -pt None -u 0.0041427619905027475 > ./result_6chains/node372_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_0_0 -p 135 -st none -pt topic372_0_0 -u 0.03688320131091932 > ./result_6chains/node372_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_1_0 -p 300 -st none -pt topic372_1_0 -u 0.07712862707861867 > ./result_6chains/node372_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_2_0 -p 477 -st none -pt topic372_2_0 -u 0.01861350091156533 > ./result_6chains/node372_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_3_0 -p 697 -st none -pt topic372_3_0 -u 0.006042695021029526 > ./result_6chains/node372_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_4_0 -p 870 -st none -pt topic372_4_0 -u 0.00041246776212677805 > ./result_6chains/node372_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_5_0 -p 885 -st none -pt topic372_5_0 -u 0.003799864331493156 > ./result_6chains/node372_5_0.txt &
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
    "./result_6chains/node372_0_0.txt 90"
    "./result_6chains/node372_0_2.txt 90"
    "./result_6chains/node372_1_0.txt 89"
    "./result_6chains/node372_1_2.txt 89"
    "./result_6chains/node372_2_0.txt 88"
    "./result_6chains/node372_2_2.txt 88"
    "./result_6chains/node372_3_0.txt 87"
    "./result_6chains/node372_3_2.txt 87"
    "./result_6chains/node372_4_0.txt 86"
    "./result_6chains/node372_4_2.txt 86"
    "./result_6chains/node372_5_0.txt 85"
    "./result_6chains/node372_5_2.txt 85"
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
