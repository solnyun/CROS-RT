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
ros2 run evaluation_3_randomdag uunifast_node -n node39_0_2 -p 201 -st topic39_0_1 -pt None -u 0.014516503911691625 > ./result_6chains/node39_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_1_2 -p 512 -st topic39_1_1 -pt None -u 0.003736531572320123 > ./result_6chains/node39_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_2_2 -p 537 -st topic39_2_1 -pt None -u 0.03633390263145603 > ./result_6chains/node39_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_3_2 -p 782 -st topic39_3_1 -pt None -u 0.04828358317722434 > ./result_6chains/node39_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_4_2 -p 893 -st topic39_4_1 -pt None -u 0.010844431188856668 > ./result_6chains/node39_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_5_2 -p 934 -st topic39_5_1 -pt None -u 0.08049824660820797 > ./result_6chains/node39_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_0_0 -p 201 -st none -pt topic39_0_0 -u 0.018014144974466406 > ./result_6chains/node39_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_1_0 -p 512 -st none -pt topic39_1_0 -u 0.007861294156794207 > ./result_6chains/node39_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_2_0 -p 537 -st none -pt topic39_2_0 -u 0.013699832926115763 > ./result_6chains/node39_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_3_0 -p 782 -st none -pt topic39_3_0 -u 0.058905206879857896 > ./result_6chains/node39_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_4_0 -p 893 -st none -pt topic39_4_0 -u 0.006578316361047137 > ./result_6chains/node39_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_5_0 -p 934 -st none -pt topic39_5_0 -u 0.0384680787683499 > ./result_6chains/node39_5_0.txt &
sleep 10
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
    "./result_6chains/node39_0_0.txt 90"
    "./result_6chains/node39_0_2.txt 90"
    "./result_6chains/node39_1_0.txt 89"
    "./result_6chains/node39_1_2.txt 89"
    "./result_6chains/node39_2_0.txt 88"
    "./result_6chains/node39_2_2.txt 88"
    "./result_6chains/node39_3_0.txt 87"
    "./result_6chains/node39_3_2.txt 87"
    "./result_6chains/node39_4_0.txt 86"
    "./result_6chains/node39_4_2.txt 86"
    "./result_6chains/node39_5_0.txt 85"
    "./result_6chains/node39_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
