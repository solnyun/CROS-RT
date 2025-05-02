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
ros2 run evaluation_3_randomdag uunifast_node -n node324_0_2 -p 57 -st topic324_0_1 -pt None -u 0.018368994196458266 > ./result_8chains/node324_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_1_2 -p 206 -st topic324_1_1 -pt None -u 0.0018768759895209097 > ./result_8chains/node324_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_2_2 -p 259 -st topic324_2_1 -pt None -u 0.015001817700617703 > ./result_8chains/node324_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_3_2 -p 387 -st topic324_3_1 -pt None -u 0.010959368387198687 > ./result_8chains/node324_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_4_2 -p 629 -st topic324_4_1 -pt None -u 0.011333363990279566 > ./result_8chains/node324_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_5_2 -p 634 -st topic324_5_1 -pt None -u 0.007707588898658302 > ./result_8chains/node324_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_6_2 -p 940 -st topic324_6_1 -pt None -u 0.027386097329910562 > ./result_8chains/node324_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_7_2 -p 974 -st topic324_7_1 -pt None -u 0.03154848115139229 > ./result_8chains/node324_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_0_0 -p 57 -st none -pt topic324_0_0 -u 0.051158030182968384 > ./result_8chains/node324_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_1_0 -p 206 -st none -pt topic324_1_0 -u 0.03831393549001111 > ./result_8chains/node324_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_2_0 -p 259 -st none -pt topic324_2_0 -u 0.0009663132607926617 > ./result_8chains/node324_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_3_0 -p 387 -st none -pt topic324_3_0 -u 0.007284056059164046 > ./result_8chains/node324_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_4_0 -p 629 -st none -pt topic324_4_0 -u 0.058151410855535185 > ./result_8chains/node324_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_5_0 -p 634 -st none -pt topic324_5_0 -u 0.0018757611966122023 > ./result_8chains/node324_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_6_0 -p 940 -st none -pt topic324_6_0 -u 0.0032807909573320526 > ./result_8chains/node324_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_7_0 -p 974 -st none -pt topic324_7_0 -u 0.003270093093797437 > ./result_8chains/node324_7_0.txt &
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
    "./result_8chains/node324_0_0.txt 90"
    "./result_8chains/node324_0_2.txt 90"
    "./result_8chains/node324_1_0.txt 89"
    "./result_8chains/node324_1_2.txt 89"
    "./result_8chains/node324_2_0.txt 88"
    "./result_8chains/node324_2_2.txt 88"
    "./result_8chains/node324_3_0.txt 87"
    "./result_8chains/node324_3_2.txt 87"
    "./result_8chains/node324_4_0.txt 86"
    "./result_8chains/node324_4_2.txt 86"
    "./result_8chains/node324_5_0.txt 85"
    "./result_8chains/node324_5_2.txt 85"
    "./result_8chains/node324_6_0.txt 84"
    "./result_8chains/node324_6_2.txt 84"
    "./result_8chains/node324_7_0.txt 83"
    "./result_8chains/node324_7_2.txt 83"
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
