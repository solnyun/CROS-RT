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
ros2 run evaluation_3_randomdag uunifast_node -n node210_0_2 -p 158 -st topic210_0_1 -pt None -u 0.02685847826801313 > ./result_10chains/node210_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_1_2 -p 170 -st topic210_1_1 -pt None -u 0.02074148191665709 > ./result_10chains/node210_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_2_2 -p 183 -st topic210_2_1 -pt None -u 0.047097940472205946 > ./result_10chains/node210_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_3_2 -p 217 -st topic210_3_1 -pt None -u 0.0247161998292168 > ./result_10chains/node210_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_4_2 -p 293 -st topic210_4_1 -pt None -u 0.006739171880676714 > ./result_10chains/node210_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_5_2 -p 313 -st topic210_5_1 -pt None -u 0.008088440487601295 > ./result_10chains/node210_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_6_2 -p 495 -st topic210_6_1 -pt None -u 0.016589452645613845 > ./result_10chains/node210_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_7_2 -p 615 -st topic210_7_1 -pt None -u 0.0013405586677136955 > ./result_10chains/node210_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_8_2 -p 692 -st topic210_8_1 -pt None -u 0.028867779555341706 > ./result_10chains/node210_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_9_2 -p 759 -st topic210_9_1 -pt None -u 0.003119908414607922 > ./result_10chains/node210_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_0_0 -p 158 -st none -pt topic210_0_0 -u 0.007952302555949309 > ./result_10chains/node210_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_1_0 -p 170 -st none -pt topic210_1_0 -u 0.02403905613176227 > ./result_10chains/node210_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_2_0 -p 183 -st none -pt topic210_2_0 -u 0.0008557684862825488 > ./result_10chains/node210_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_3_0 -p 217 -st none -pt topic210_3_0 -u 0.0005664794575913068 > ./result_10chains/node210_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_4_0 -p 293 -st none -pt topic210_4_0 -u 0.008301458146172225 > ./result_10chains/node210_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_5_0 -p 313 -st none -pt topic210_5_0 -u 0.023762572772289603 > ./result_10chains/node210_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_6_0 -p 495 -st none -pt topic210_6_0 -u 0.05265553462402722 > ./result_10chains/node210_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_7_0 -p 615 -st none -pt topic210_7_0 -u 0.011374652092634913 > ./result_10chains/node210_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_8_0 -p 692 -st none -pt topic210_8_0 -u 0.03508538893914466 > ./result_10chains/node210_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node210_9_0 -p 759 -st none -pt topic210_9_0 -u 0.0033085907439333803 > ./result_10chains/node210_9_0.txt &
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
    "./result_10chains/node210_0_0.txt 90"
    "./result_10chains/node210_0_2.txt 90"
    "./result_10chains/node210_1_0.txt 89"
    "./result_10chains/node210_1_2.txt 89"
    "./result_10chains/node210_2_0.txt 88"
    "./result_10chains/node210_2_2.txt 88"
    "./result_10chains/node210_3_0.txt 87"
    "./result_10chains/node210_3_2.txt 87"
    "./result_10chains/node210_4_0.txt 86"
    "./result_10chains/node210_4_2.txt 86"
    "./result_10chains/node210_5_0.txt 85"
    "./result_10chains/node210_5_2.txt 85"
    "./result_10chains/node210_6_0.txt 84"
    "./result_10chains/node210_6_2.txt 84"
    "./result_10chains/node210_7_0.txt 83"
    "./result_10chains/node210_7_2.txt 83"
    "./result_10chains/node210_8_0.txt 82"
    "./result_10chains/node210_8_2.txt 82"
    "./result_10chains/node210_9_0.txt 81"
    "./result_10chains/node210_9_2.txt 81"
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
