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
ros2 run evaluation_3_randomdag uunifast_node -n node119_0_2 -p 274 -st topic119_0_1 -pt None -u 0.05519016295881474 > ./result_8chains/node119_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_1_2 -p 349 -st topic119_1_1 -pt None -u 0.03560892956238465 > ./result_8chains/node119_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_2_2 -p 405 -st topic119_2_1 -pt None -u 0.03384550148696083 > ./result_8chains/node119_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_3_2 -p 656 -st topic119_3_1 -pt None -u 0.00596423703577148 > ./result_8chains/node119_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_4_2 -p 672 -st topic119_4_1 -pt None -u 0.010001728594896259 > ./result_8chains/node119_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_5_2 -p 725 -st topic119_5_1 -pt None -u 0.009239206978986794 > ./result_8chains/node119_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_6_2 -p 764 -st topic119_6_1 -pt None -u 0.03189908658618438 > ./result_8chains/node119_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_7_2 -p 785 -st topic119_7_1 -pt None -u 0.0009305951517311971 > ./result_8chains/node119_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_0_0 -p 274 -st none -pt topic119_0_0 -u 0.04409104798063779 > ./result_8chains/node119_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_1_0 -p 349 -st none -pt topic119_1_0 -u 0.011016623325760588 > ./result_8chains/node119_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_2_0 -p 405 -st none -pt topic119_2_0 -u 0.00961281725156704 > ./result_8chains/node119_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_3_0 -p 656 -st none -pt topic119_3_0 -u 0.008546160620496956 > ./result_8chains/node119_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_4_0 -p 672 -st none -pt topic119_4_0 -u 0.00959816087721821 > ./result_8chains/node119_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_5_0 -p 725 -st none -pt topic119_5_0 -u 0.0038937269371263628 > ./result_8chains/node119_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_6_0 -p 764 -st none -pt topic119_6_0 -u 0.018736299603750797 > ./result_8chains/node119_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_7_0 -p 785 -st none -pt topic119_7_0 -u 0.04183258558357553 > ./result_8chains/node119_7_0.txt &
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
    "./result_8chains/node119_0_0.txt 90"
    "./result_8chains/node119_0_2.txt 90"
    "./result_8chains/node119_1_0.txt 89"
    "./result_8chains/node119_1_2.txt 89"
    "./result_8chains/node119_2_0.txt 88"
    "./result_8chains/node119_2_2.txt 88"
    "./result_8chains/node119_3_0.txt 87"
    "./result_8chains/node119_3_2.txt 87"
    "./result_8chains/node119_4_0.txt 86"
    "./result_8chains/node119_4_2.txt 86"
    "./result_8chains/node119_5_0.txt 85"
    "./result_8chains/node119_5_2.txt 85"
    "./result_8chains/node119_6_0.txt 84"
    "./result_8chains/node119_6_2.txt 84"
    "./result_8chains/node119_7_0.txt 83"
    "./result_8chains/node119_7_2.txt 83"
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
