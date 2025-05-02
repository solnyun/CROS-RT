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
ros2 run evaluation_3_randomdag uunifast_node -n node210_0_2 -p 127 -st topic210_0_1 -pt None -u 0.017471529031051147 > ./result_6chains/node210_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_1_2 -p 260 -st topic210_1_1 -pt None -u 0.020746951418958437 > ./result_6chains/node210_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_2_2 -p 437 -st topic210_2_1 -pt None -u 0.009358967661869916 > ./result_6chains/node210_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_3_2 -p 692 -st topic210_3_1 -pt None -u 0.02046282834461713 > ./result_6chains/node210_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_4_2 -p 918 -st topic210_4_1 -pt None -u 0.01190346980126919 > ./result_6chains/node210_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_5_2 -p 941 -st topic210_5_1 -pt None -u 0.060485115364626175 > ./result_6chains/node210_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_0_0 -p 127 -st none -pt topic210_0_0 -u 0.013230480173041126 > ./result_6chains/node210_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_1_0 -p 260 -st none -pt topic210_1_0 -u 0.0025941617339649836 > ./result_6chains/node210_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_2_0 -p 437 -st none -pt topic210_2_0 -u 0.014742925751138586 > ./result_6chains/node210_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_3_0 -p 692 -st none -pt topic210_3_0 -u 0.006806338736521367 > ./result_6chains/node210_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_4_0 -p 918 -st none -pt topic210_4_0 -u 0.0015998397023154476 > ./result_6chains/node210_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_5_0 -p 941 -st none -pt topic210_5_0 -u 0.07909210352044171 > ./result_6chains/node210_5_0.txt &
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
    "./result_6chains/node210_0_0.txt 90"
    "./result_6chains/node210_0_2.txt 90"
    "./result_6chains/node210_1_0.txt 89"
    "./result_6chains/node210_1_2.txt 89"
    "./result_6chains/node210_2_0.txt 88"
    "./result_6chains/node210_2_2.txt 88"
    "./result_6chains/node210_3_0.txt 87"
    "./result_6chains/node210_3_2.txt 87"
    "./result_6chains/node210_4_0.txt 86"
    "./result_6chains/node210_4_2.txt 86"
    "./result_6chains/node210_5_0.txt 85"
    "./result_6chains/node210_5_2.txt 85"
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
