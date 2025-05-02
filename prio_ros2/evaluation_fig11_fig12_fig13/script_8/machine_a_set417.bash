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
ros2 run evaluation_3_randomdag uunifast_node -n node417_0_2 -p 186 -st topic417_0_1 -pt None -u 0.0012388304461065647 > ./result_8chains/node417_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_1_2 -p 190 -st topic417_1_1 -pt None -u 0.0016560459690577733 > ./result_8chains/node417_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_2_2 -p 281 -st topic417_2_1 -pt None -u 0.005462342733853376 > ./result_8chains/node417_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_3_2 -p 317 -st topic417_3_1 -pt None -u 0.0032553048479278535 > ./result_8chains/node417_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_4_2 -p 468 -st topic417_4_1 -pt None -u 0.010726197224146694 > ./result_8chains/node417_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_5_2 -p 643 -st topic417_5_1 -pt None -u 0.007498696404184296 > ./result_8chains/node417_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_6_2 -p 711 -st topic417_6_1 -pt None -u 0.008360643755373605 > ./result_8chains/node417_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_7_2 -p 789 -st topic417_7_1 -pt None -u 0.00880750719799211 > ./result_8chains/node417_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_0_0 -p 186 -st none -pt topic417_0_0 -u 0.008424123514384152 > ./result_8chains/node417_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_1_0 -p 190 -st none -pt topic417_1_0 -u 0.029451178817831936 > ./result_8chains/node417_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_2_0 -p 281 -st none -pt topic417_2_0 -u 0.0032168556440963503 > ./result_8chains/node417_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_3_0 -p 317 -st none -pt topic417_3_0 -u 0.0144227440780339 > ./result_8chains/node417_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_4_0 -p 468 -st none -pt topic417_4_0 -u 0.0009797494118587435 > ./result_8chains/node417_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_5_0 -p 643 -st none -pt topic417_5_0 -u 0.03480094367844905 > ./result_8chains/node417_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_6_0 -p 711 -st none -pt topic417_6_0 -u 0.09795773390566495 > ./result_8chains/node417_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_7_0 -p 789 -st none -pt topic417_7_0 -u 0.0063594001694609915 > ./result_8chains/node417_7_0.txt &
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
    "./result_8chains/node417_0_0.txt 90"
    "./result_8chains/node417_0_2.txt 90"
    "./result_8chains/node417_1_0.txt 89"
    "./result_8chains/node417_1_2.txt 89"
    "./result_8chains/node417_2_0.txt 88"
    "./result_8chains/node417_2_2.txt 88"
    "./result_8chains/node417_3_0.txt 87"
    "./result_8chains/node417_3_2.txt 87"
    "./result_8chains/node417_4_0.txt 86"
    "./result_8chains/node417_4_2.txt 86"
    "./result_8chains/node417_5_0.txt 85"
    "./result_8chains/node417_5_2.txt 85"
    "./result_8chains/node417_6_0.txt 84"
    "./result_8chains/node417_6_2.txt 84"
    "./result_8chains/node417_7_0.txt 83"
    "./result_8chains/node417_7_2.txt 83"
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
