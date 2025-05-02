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
ros2 run evaluation_3_randomdag uunifast_node -n node59_0_2 -p 14 -st topic59_0_1 -pt None -u 0.021700815151478425 > ./result_8chains/node59_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_1_2 -p 77 -st topic59_1_1 -pt None -u 0.010330586831553912 > ./result_8chains/node59_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_2_2 -p 360 -st topic59_2_1 -pt None -u 0.006214497598651558 > ./result_8chains/node59_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_3_2 -p 546 -st topic59_3_1 -pt None -u 0.008108702087910424 > ./result_8chains/node59_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_4_2 -p 557 -st topic59_4_1 -pt None -u 0.010523543028905291 > ./result_8chains/node59_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_5_2 -p 880 -st topic59_5_1 -pt None -u 0.01791455288558272 > ./result_8chains/node59_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_6_2 -p 926 -st topic59_6_1 -pt None -u 0.037577721249565044 > ./result_8chains/node59_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_7_2 -p 967 -st topic59_7_1 -pt None -u 0.11652696513965871 > ./result_8chains/node59_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_0_0 -p 14 -st none -pt topic59_0_0 -u 0.08531181259607362 > ./result_8chains/node59_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_1_0 -p 77 -st none -pt topic59_1_0 -u 0.016067434209672216 > ./result_8chains/node59_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_2_0 -p 360 -st none -pt topic59_2_0 -u 0.0027257644495122246 > ./result_8chains/node59_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_3_0 -p 546 -st none -pt topic59_3_0 -u 0.006893164533388285 > ./result_8chains/node59_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_4_0 -p 557 -st none -pt topic59_4_0 -u 0.010840439345127018 > ./result_8chains/node59_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_5_0 -p 880 -st none -pt topic59_5_0 -u 0.002307288028765231 > ./result_8chains/node59_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_6_0 -p 926 -st none -pt topic59_6_0 -u 0.0016172466846293976 > ./result_8chains/node59_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_7_0 -p 967 -st none -pt topic59_7_0 -u 0.0026659403326980136 > ./result_8chains/node59_7_0.txt &
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
    "./result_8chains/node59_0_0.txt 90"
    "./result_8chains/node59_0_2.txt 90"
    "./result_8chains/node59_1_0.txt 89"
    "./result_8chains/node59_1_2.txt 89"
    "./result_8chains/node59_2_0.txt 88"
    "./result_8chains/node59_2_2.txt 88"
    "./result_8chains/node59_3_0.txt 87"
    "./result_8chains/node59_3_2.txt 87"
    "./result_8chains/node59_4_0.txt 86"
    "./result_8chains/node59_4_2.txt 86"
    "./result_8chains/node59_5_0.txt 85"
    "./result_8chains/node59_5_2.txt 85"
    "./result_8chains/node59_6_0.txt 84"
    "./result_8chains/node59_6_2.txt 84"
    "./result_8chains/node59_7_0.txt 83"
    "./result_8chains/node59_7_2.txt 83"
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
