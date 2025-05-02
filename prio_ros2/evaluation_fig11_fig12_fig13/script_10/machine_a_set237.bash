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
ros2 run evaluation_3_randomdag uunifast_node -n node237_0_2 -p 47 -st topic237_0_1 -pt None -u 0.014565596374861933 > ./result_10chains/node237_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_1_2 -p 72 -st topic237_1_1 -pt None -u 0.024149314159532198 > ./result_10chains/node237_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_2_2 -p 130 -st topic237_2_1 -pt None -u 0.00841323211989059 > ./result_10chains/node237_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_3_2 -p 220 -st topic237_3_1 -pt None -u 0.011799562991786527 > ./result_10chains/node237_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_4_2 -p 242 -st topic237_4_1 -pt None -u 0.016857287606103277 > ./result_10chains/node237_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_5_2 -p 271 -st topic237_5_1 -pt None -u 0.027424385879179003 > ./result_10chains/node237_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_6_2 -p 508 -st topic237_6_1 -pt None -u 0.01068148043119413 > ./result_10chains/node237_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_7_2 -p 516 -st topic237_7_1 -pt None -u 0.00018641449681436328 > ./result_10chains/node237_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_8_2 -p 881 -st topic237_8_1 -pt None -u 0.054784939590793946 > ./result_10chains/node237_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_9_2 -p 919 -st topic237_9_1 -pt None -u 0.02276376083410997 > ./result_10chains/node237_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_0_0 -p 47 -st none -pt topic237_0_0 -u 0.01033717565251907 > ./result_10chains/node237_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_1_0 -p 72 -st none -pt topic237_1_0 -u 0.0403653219253956 > ./result_10chains/node237_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_2_0 -p 130 -st none -pt topic237_2_0 -u 0.02164944676542313 > ./result_10chains/node237_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_3_0 -p 220 -st none -pt topic237_3_0 -u 0.020818465565554 > ./result_10chains/node237_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_4_0 -p 242 -st none -pt topic237_4_0 -u 0.0064822597113742275 > ./result_10chains/node237_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_5_0 -p 271 -st none -pt topic237_5_0 -u 0.019943958890382224 > ./result_10chains/node237_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_6_0 -p 508 -st none -pt topic237_6_0 -u 0.02804096181035945 > ./result_10chains/node237_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_7_0 -p 516 -st none -pt topic237_7_0 -u 0.007490406516691944 > ./result_10chains/node237_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_8_0 -p 881 -st none -pt topic237_8_0 -u 0.0005000527544491012 > ./result_10chains/node237_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_9_0 -p 919 -st none -pt topic237_9_0 -u 0.020414012682156125 > ./result_10chains/node237_9_0.txt &
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
    "./result_10chains/node237_0_0.txt 90"
    "./result_10chains/node237_0_2.txt 90"
    "./result_10chains/node237_1_0.txt 89"
    "./result_10chains/node237_1_2.txt 89"
    "./result_10chains/node237_2_0.txt 88"
    "./result_10chains/node237_2_2.txt 88"
    "./result_10chains/node237_3_0.txt 87"
    "./result_10chains/node237_3_2.txt 87"
    "./result_10chains/node237_4_0.txt 86"
    "./result_10chains/node237_4_2.txt 86"
    "./result_10chains/node237_5_0.txt 85"
    "./result_10chains/node237_5_2.txt 85"
    "./result_10chains/node237_6_0.txt 84"
    "./result_10chains/node237_6_2.txt 84"
    "./result_10chains/node237_7_0.txt 83"
    "./result_10chains/node237_7_2.txt 83"
    "./result_10chains/node237_8_0.txt 82"
    "./result_10chains/node237_8_2.txt 82"
    "./result_10chains/node237_9_0.txt 81"
    "./result_10chains/node237_9_2.txt 81"
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
