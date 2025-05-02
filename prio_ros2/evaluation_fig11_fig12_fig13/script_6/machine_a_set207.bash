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
ros2 run evaluation_3_randomdag uunifast_node -n node207_0_2 -p 265 -st topic207_0_1 -pt None -u 0.008813069993326095 > ./result_6chains/node207_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_1_2 -p 313 -st topic207_1_1 -pt None -u 0.013543825846847879 > ./result_6chains/node207_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_2_2 -p 335 -st topic207_2_1 -pt None -u 0.04332784758234415 > ./result_6chains/node207_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_3_2 -p 465 -st topic207_3_1 -pt None -u 0.027934088912514032 > ./result_6chains/node207_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_4_2 -p 670 -st topic207_4_1 -pt None -u 0.004251437425191795 > ./result_6chains/node207_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_5_2 -p 970 -st topic207_5_1 -pt None -u 0.057297194413885554 > ./result_6chains/node207_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_0_0 -p 265 -st none -pt topic207_0_0 -u 0.008376373117402247 > ./result_6chains/node207_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_1_0 -p 313 -st none -pt topic207_1_0 -u 0.009106526018193062 > ./result_6chains/node207_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_2_0 -p 335 -st none -pt topic207_2_0 -u 0.0009665782960607272 > ./result_6chains/node207_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_3_0 -p 465 -st none -pt topic207_3_0 -u 0.030286352038400355 > ./result_6chains/node207_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_4_0 -p 670 -st none -pt topic207_4_0 -u 0.07898852418156124 > ./result_6chains/node207_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_5_0 -p 970 -st none -pt topic207_5_0 -u 0.015551959554713501 > ./result_6chains/node207_5_0.txt &
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
    "./result_6chains/node207_0_0.txt 90"
    "./result_6chains/node207_0_2.txt 90"
    "./result_6chains/node207_1_0.txt 89"
    "./result_6chains/node207_1_2.txt 89"
    "./result_6chains/node207_2_0.txt 88"
    "./result_6chains/node207_2_2.txt 88"
    "./result_6chains/node207_3_0.txt 87"
    "./result_6chains/node207_3_2.txt 87"
    "./result_6chains/node207_4_0.txt 86"
    "./result_6chains/node207_4_2.txt 86"
    "./result_6chains/node207_5_0.txt 85"
    "./result_6chains/node207_5_2.txt 85"
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
