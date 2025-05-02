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
ros2 run evaluation_3_randomdag uunifast_node -n node282_0_2 -p 152 -st topic282_0_1 -pt None -u 0.018987912073115898 > ./result_8chains/node282_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_1_2 -p 360 -st topic282_1_1 -pt None -u 0.016257028482885405 > ./result_8chains/node282_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_2_2 -p 450 -st topic282_2_1 -pt None -u 0.030673502723915946 > ./result_8chains/node282_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_3_2 -p 649 -st topic282_3_1 -pt None -u 0.007871534352404785 > ./result_8chains/node282_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_4_2 -p 651 -st topic282_4_1 -pt None -u 0.04346960937247771 > ./result_8chains/node282_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_5_2 -p 820 -st topic282_5_1 -pt None -u 0.023449524159180557 > ./result_8chains/node282_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_6_2 -p 869 -st topic282_6_1 -pt None -u 0.02240333647717723 > ./result_8chains/node282_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_7_2 -p 962 -st topic282_7_1 -pt None -u 0.0006076229429818852 > ./result_8chains/node282_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_0_0 -p 152 -st none -pt topic282_0_0 -u 0.012325025454293925 > ./result_8chains/node282_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_1_0 -p 360 -st none -pt topic282_1_0 -u 0.04461079795494283 > ./result_8chains/node282_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_2_0 -p 450 -st none -pt topic282_2_0 -u 0.0060645193079184034 > ./result_8chains/node282_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_3_0 -p 649 -st none -pt topic282_3_0 -u 0.04814065292086239 > ./result_8chains/node282_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_4_0 -p 651 -st none -pt topic282_4_0 -u 0.041450360739661546 > ./result_8chains/node282_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_5_0 -p 820 -st none -pt topic282_5_0 -u 0.021392925717487826 > ./result_8chains/node282_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node282_6_0 -p 869 -st none -pt topic282_6_0 -u 0.021591298682357776 > ./result_8chains/node282_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node282_7_0 -p 962 -st none -pt topic282_7_0 -u 0.02328172044435385 > ./result_8chains/node282_7_0.txt &
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
    "./result_8chains/node282_0_0.txt 90"
    "./result_8chains/node282_0_2.txt 90"
    "./result_8chains/node282_1_0.txt 89"
    "./result_8chains/node282_1_2.txt 89"
    "./result_8chains/node282_2_0.txt 88"
    "./result_8chains/node282_2_2.txt 88"
    "./result_8chains/node282_3_0.txt 87"
    "./result_8chains/node282_3_2.txt 87"
    "./result_8chains/node282_4_0.txt 86"
    "./result_8chains/node282_4_2.txt 86"
    "./result_8chains/node282_5_0.txt 85"
    "./result_8chains/node282_5_2.txt 85"
    "./result_8chains/node282_6_0.txt 84"
    "./result_8chains/node282_6_2.txt 84"
    "./result_8chains/node282_7_0.txt 83"
    "./result_8chains/node282_7_2.txt 83"
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
