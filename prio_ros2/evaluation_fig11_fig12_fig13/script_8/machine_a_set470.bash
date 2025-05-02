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
ros2 run evaluation_3_randomdag uunifast_node -n node470_0_2 -p 25 -st topic470_0_1 -pt None -u 0.011310481482054768 > ./result_8chains/node470_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_1_2 -p 154 -st topic470_1_1 -pt None -u 0.0427942620334999 > ./result_8chains/node470_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_2_2 -p 166 -st topic470_2_1 -pt None -u 0.003509698047067411 > ./result_8chains/node470_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_3_2 -p 223 -st topic470_3_1 -pt None -u 0.08175321963408982 > ./result_8chains/node470_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_4_2 -p 334 -st topic470_4_1 -pt None -u 0.024158327426230863 > ./result_8chains/node470_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_5_2 -p 638 -st topic470_5_1 -pt None -u 0.0068431700633973525 > ./result_8chains/node470_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_6_2 -p 792 -st topic470_6_1 -pt None -u 0.02356227723174706 > ./result_8chains/node470_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_7_2 -p 847 -st topic470_7_1 -pt None -u 0.021666333554149084 > ./result_8chains/node470_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_0_0 -p 25 -st none -pt topic470_0_0 -u 0.0016136215427201006 > ./result_8chains/node470_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_1_0 -p 154 -st none -pt topic470_1_0 -u 0.027054658285771138 > ./result_8chains/node470_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_2_0 -p 166 -st none -pt topic470_2_0 -u 0.002529111069037804 > ./result_8chains/node470_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_3_0 -p 223 -st none -pt topic470_3_0 -u 0.029244061919628916 > ./result_8chains/node470_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_4_0 -p 334 -st none -pt topic470_4_0 -u 0.019022251546936597 > ./result_8chains/node470_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_5_0 -p 638 -st none -pt topic470_5_0 -u 0.006495868603525995 > ./result_8chains/node470_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_6_0 -p 792 -st none -pt topic470_6_0 -u 0.000930354814828227 > ./result_8chains/node470_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_7_0 -p 847 -st none -pt topic470_7_0 -u 0.059037681465002476 > ./result_8chains/node470_7_0.txt &
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
    "./result_8chains/node470_0_0.txt 90"
    "./result_8chains/node470_0_2.txt 90"
    "./result_8chains/node470_1_0.txt 89"
    "./result_8chains/node470_1_2.txt 89"
    "./result_8chains/node470_2_0.txt 88"
    "./result_8chains/node470_2_2.txt 88"
    "./result_8chains/node470_3_0.txt 87"
    "./result_8chains/node470_3_2.txt 87"
    "./result_8chains/node470_4_0.txt 86"
    "./result_8chains/node470_4_2.txt 86"
    "./result_8chains/node470_5_0.txt 85"
    "./result_8chains/node470_5_2.txt 85"
    "./result_8chains/node470_6_0.txt 84"
    "./result_8chains/node470_6_2.txt 84"
    "./result_8chains/node470_7_0.txt 83"
    "./result_8chains/node470_7_2.txt 83"
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
