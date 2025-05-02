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
ros2 run evaluation_3_randomdag uunifast_node -n node445_0_2 -p 393 -st topic445_0_1 -pt None -u 0.015105447847829634 > ./result_6chains/node445_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_1_2 -p 397 -st topic445_1_1 -pt None -u 0.0025534843736456647 > ./result_6chains/node445_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_2_2 -p 413 -st topic445_2_1 -pt None -u 0.08259896179916454 > ./result_6chains/node445_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_3_2 -p 457 -st topic445_3_1 -pt None -u 0.07762559800122715 > ./result_6chains/node445_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_4_2 -p 696 -st topic445_4_1 -pt None -u 0.0492413595570506 > ./result_6chains/node445_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_5_2 -p 904 -st topic445_5_1 -pt None -u 0.027105874525142487 > ./result_6chains/node445_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_0_0 -p 393 -st none -pt topic445_0_0 -u 0.0082537493662323 > ./result_6chains/node445_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_1_0 -p 397 -st none -pt topic445_1_0 -u 0.006441102380091324 > ./result_6chains/node445_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_2_0 -p 413 -st none -pt topic445_2_0 -u 0.005329247252489178 > ./result_6chains/node445_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_3_0 -p 457 -st none -pt topic445_3_0 -u 0.015140178288995387 > ./result_6chains/node445_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_4_0 -p 696 -st none -pt topic445_4_0 -u 0.060240955357582504 > ./result_6chains/node445_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_5_0 -p 904 -st none -pt topic445_5_0 -u 0.0031205773596432035 > ./result_6chains/node445_5_0.txt &
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
    "./result_6chains/node445_0_0.txt 90"
    "./result_6chains/node445_0_2.txt 90"
    "./result_6chains/node445_1_0.txt 89"
    "./result_6chains/node445_1_2.txt 89"
    "./result_6chains/node445_2_0.txt 88"
    "./result_6chains/node445_2_2.txt 88"
    "./result_6chains/node445_3_0.txt 87"
    "./result_6chains/node445_3_2.txt 87"
    "./result_6chains/node445_4_0.txt 86"
    "./result_6chains/node445_4_2.txt 86"
    "./result_6chains/node445_5_0.txt 85"
    "./result_6chains/node445_5_2.txt 85"
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
