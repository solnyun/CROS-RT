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
ros2 run evaluation_3_randomdag uunifast_node -n node0_0_2 -p 30 -st topic0_0_1 -pt None -u 0.0006753070473262679 > ./result_8chains/node0_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_1_2 -p 81 -st topic0_1_1 -pt None -u 0.00803819718198795 > ./result_8chains/node0_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_2_2 -p 376 -st topic0_2_1 -pt None -u 0.02467456431476539 > ./result_8chains/node0_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_3_2 -p 434 -st topic0_3_1 -pt None -u 0.005587079345434731 > ./result_8chains/node0_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_4_2 -p 741 -st topic0_4_1 -pt None -u 0.017832896954859567 > ./result_8chains/node0_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_5_2 -p 804 -st topic0_5_1 -pt None -u 0.036898292343974695 > ./result_8chains/node0_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_6_2 -p 835 -st topic0_6_1 -pt None -u 0.02276616538183092 > ./result_8chains/node0_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_7_2 -p 954 -st topic0_7_1 -pt None -u 0.01984971036428014 > ./result_8chains/node0_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_0_0 -p 30 -st none -pt topic0_0_0 -u 0.04836438015769173 > ./result_8chains/node0_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_1_0 -p 81 -st none -pt topic0_1_0 -u 0.01702443265796011 > ./result_8chains/node0_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_2_0 -p 376 -st none -pt topic0_2_0 -u 0.007958110239068228 > ./result_8chains/node0_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_3_0 -p 434 -st none -pt topic0_3_0 -u 0.05918204744561101 > ./result_8chains/node0_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_4_0 -p 741 -st none -pt topic0_4_0 -u 0.00917135672829883 > ./result_8chains/node0_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_5_0 -p 804 -st none -pt topic0_5_0 -u 0.09008661257385084 > ./result_8chains/node0_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_6_0 -p 835 -st none -pt topic0_6_0 -u 0.023893395545850085 > ./result_8chains/node0_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_7_0 -p 954 -st none -pt topic0_7_0 -u 0.015188312569563812 > ./result_8chains/node0_7_0.txt &
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
    "./result_8chains/node0_0_0.txt 90"
    "./result_8chains/node0_0_2.txt 90"
    "./result_8chains/node0_1_0.txt 89"
    "./result_8chains/node0_1_2.txt 89"
    "./result_8chains/node0_2_0.txt 88"
    "./result_8chains/node0_2_2.txt 88"
    "./result_8chains/node0_3_0.txt 87"
    "./result_8chains/node0_3_2.txt 87"
    "./result_8chains/node0_4_0.txt 86"
    "./result_8chains/node0_4_2.txt 86"
    "./result_8chains/node0_5_0.txt 85"
    "./result_8chains/node0_5_2.txt 85"
    "./result_8chains/node0_6_0.txt 84"
    "./result_8chains/node0_6_2.txt 84"
    "./result_8chains/node0_7_0.txt 83"
    "./result_8chains/node0_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
