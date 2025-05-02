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
ros2 run evaluation_3_randomdag uunifast_node -n node298_0_2 -p 22 -st topic298_0_1 -pt None -u 0.0062291149025213155 > ./result_10chains/node298_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_1_2 -p 86 -st topic298_1_1 -pt None -u 0.050298025560604476 > ./result_10chains/node298_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_2_2 -p 101 -st topic298_2_1 -pt None -u 0.003929317474077931 > ./result_10chains/node298_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_3_2 -p 136 -st topic298_3_1 -pt None -u 0.031292727798300224 > ./result_10chains/node298_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_4_2 -p 316 -st topic298_4_1 -pt None -u 0.01777057742934446 > ./result_10chains/node298_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_5_2 -p 321 -st topic298_5_1 -pt None -u 0.00015660133421910305 > ./result_10chains/node298_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_6_2 -p 351 -st topic298_6_1 -pt None -u 0.05759391356889018 > ./result_10chains/node298_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_7_2 -p 471 -st topic298_7_1 -pt None -u 0.034210649125302986 > ./result_10chains/node298_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_8_2 -p 535 -st topic298_8_1 -pt None -u 0.007493307845175379 > ./result_10chains/node298_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_9_2 -p 729 -st topic298_9_1 -pt None -u 0.03419237811211222 > ./result_10chains/node298_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_0_0 -p 22 -st none -pt topic298_0_0 -u 0.0061921377589755355 > ./result_10chains/node298_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_1_0 -p 86 -st none -pt topic298_1_0 -u 0.02016861315654983 > ./result_10chains/node298_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_2_0 -p 101 -st none -pt topic298_2_0 -u 0.02186062247225956 > ./result_10chains/node298_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_3_0 -p 136 -st none -pt topic298_3_0 -u 0.0010609043941740004 > ./result_10chains/node298_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_4_0 -p 316 -st none -pt topic298_4_0 -u 0.008513146406107341 > ./result_10chains/node298_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_5_0 -p 321 -st none -pt topic298_5_0 -u 0.007916478013843709 > ./result_10chains/node298_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_6_0 -p 351 -st none -pt topic298_6_0 -u 0.009335897378377672 > ./result_10chains/node298_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_7_0 -p 471 -st none -pt topic298_7_0 -u 0.021693598239591355 > ./result_10chains/node298_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_8_0 -p 535 -st none -pt topic298_8_0 -u 0.013588104705827025 > ./result_10chains/node298_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_9_0 -p 729 -st none -pt topic298_9_0 -u 0.020596621530178633 > ./result_10chains/node298_9_0.txt &
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
    "./result_10chains/node298_0_0.txt 90"
    "./result_10chains/node298_0_2.txt 90"
    "./result_10chains/node298_1_0.txt 89"
    "./result_10chains/node298_1_2.txt 89"
    "./result_10chains/node298_2_0.txt 88"
    "./result_10chains/node298_2_2.txt 88"
    "./result_10chains/node298_3_0.txt 87"
    "./result_10chains/node298_3_2.txt 87"
    "./result_10chains/node298_4_0.txt 86"
    "./result_10chains/node298_4_2.txt 86"
    "./result_10chains/node298_5_0.txt 85"
    "./result_10chains/node298_5_2.txt 85"
    "./result_10chains/node298_6_0.txt 84"
    "./result_10chains/node298_6_2.txt 84"
    "./result_10chains/node298_7_0.txt 83"
    "./result_10chains/node298_7_2.txt 83"
    "./result_10chains/node298_8_0.txt 82"
    "./result_10chains/node298_8_2.txt 82"
    "./result_10chains/node298_9_0.txt 81"
    "./result_10chains/node298_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
