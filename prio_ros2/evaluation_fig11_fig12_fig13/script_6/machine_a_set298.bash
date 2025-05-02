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
ros2 run evaluation_3_randomdag uunifast_node -n node298_0_2 -p 111 -st topic298_0_1 -pt None -u 0.025876648604235775 > ./result_6chains/node298_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_1_2 -p 177 -st topic298_1_1 -pt None -u 0.02902498950776744 > ./result_6chains/node298_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_2_2 -p 570 -st topic298_2_1 -pt None -u 0.027148877832580964 > ./result_6chains/node298_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_3_2 -p 701 -st topic298_3_1 -pt None -u 0.041237356323353375 > ./result_6chains/node298_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_4_2 -p 808 -st topic298_4_1 -pt None -u 0.037486651827954784 > ./result_6chains/node298_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_5_2 -p 967 -st topic298_5_1 -pt None -u 0.006258208255656119 > ./result_6chains/node298_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_0_0 -p 111 -st none -pt topic298_0_0 -u 0.0178427830379308 > ./result_6chains/node298_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_1_0 -p 177 -st none -pt topic298_1_0 -u 0.11592211073408498 > ./result_6chains/node298_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_2_0 -p 570 -st none -pt topic298_2_0 -u 0.0008275851325831307 > ./result_6chains/node298_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_3_0 -p 701 -st none -pt topic298_3_0 -u 0.0048544734656635335 > ./result_6chains/node298_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_4_0 -p 808 -st none -pt topic298_4_0 -u 0.0017955570869415682 > ./result_6chains/node298_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_5_0 -p 967 -st none -pt topic298_5_0 -u 0.03249130034768167 > ./result_6chains/node298_5_0.txt &
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
    "./result_6chains/node298_0_0.txt 90"
    "./result_6chains/node298_0_2.txt 90"
    "./result_6chains/node298_1_0.txt 89"
    "./result_6chains/node298_1_2.txt 89"
    "./result_6chains/node298_2_0.txt 88"
    "./result_6chains/node298_2_2.txt 88"
    "./result_6chains/node298_3_0.txt 87"
    "./result_6chains/node298_3_2.txt 87"
    "./result_6chains/node298_4_0.txt 86"
    "./result_6chains/node298_4_2.txt 86"
    "./result_6chains/node298_5_0.txt 85"
    "./result_6chains/node298_5_2.txt 85"
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
