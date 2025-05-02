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
ros2 run evaluation_3_randomdag uunifast_node -n node76_0_2 -p 105 -st topic76_0_1 -pt None -u 0.02265373062195325 > ./result_6chains/node76_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_1_2 -p 202 -st topic76_1_1 -pt None -u 0.05180651290939464 > ./result_6chains/node76_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_2_2 -p 217 -st topic76_2_1 -pt None -u 0.001763782008317838 > ./result_6chains/node76_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_3_2 -p 309 -st topic76_3_1 -pt None -u 0.014275514154697105 > ./result_6chains/node76_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_4_2 -p 640 -st topic76_4_1 -pt None -u 0.002015646338130797 > ./result_6chains/node76_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_5_2 -p 751 -st topic76_5_1 -pt None -u 0.011549074796072634 > ./result_6chains/node76_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_0_0 -p 105 -st none -pt topic76_0_0 -u 0.03353477364619156 > ./result_6chains/node76_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_1_0 -p 202 -st none -pt topic76_1_0 -u 0.0057108482755659495 > ./result_6chains/node76_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_2_0 -p 217 -st none -pt topic76_2_0 -u 0.003746624200102411 > ./result_6chains/node76_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_3_0 -p 309 -st none -pt topic76_3_0 -u 0.013254817765583071 > ./result_6chains/node76_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_4_0 -p 640 -st none -pt topic76_4_0 -u 0.0734469840859342 > ./result_6chains/node76_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_5_0 -p 751 -st none -pt topic76_5_0 -u 0.07365302944121636 > ./result_6chains/node76_5_0.txt &
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
    "./result_6chains/node76_0_0.txt 90"
    "./result_6chains/node76_0_2.txt 90"
    "./result_6chains/node76_1_0.txt 89"
    "./result_6chains/node76_1_2.txt 89"
    "./result_6chains/node76_2_0.txt 88"
    "./result_6chains/node76_2_2.txt 88"
    "./result_6chains/node76_3_0.txt 87"
    "./result_6chains/node76_3_2.txt 87"
    "./result_6chains/node76_4_0.txt 86"
    "./result_6chains/node76_4_2.txt 86"
    "./result_6chains/node76_5_0.txt 85"
    "./result_6chains/node76_5_2.txt 85"
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
