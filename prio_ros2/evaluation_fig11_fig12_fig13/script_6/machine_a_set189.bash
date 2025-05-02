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
ros2 run evaluation_3_randomdag uunifast_node -n node189_0_2 -p 235 -st topic189_0_1 -pt None -u 0.01949238981345991 > ./result_6chains/node189_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_1_2 -p 337 -st topic189_1_1 -pt None -u 0.031664854675470255 > ./result_6chains/node189_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_2_2 -p 433 -st topic189_2_1 -pt None -u 0.015279179551481392 > ./result_6chains/node189_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_3_2 -p 471 -st topic189_3_1 -pt None -u 0.007488126318502375 > ./result_6chains/node189_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_4_2 -p 765 -st topic189_4_1 -pt None -u 0.004032180046046635 > ./result_6chains/node189_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_5_2 -p 802 -st topic189_5_1 -pt None -u 0.0033444764628212578 > ./result_6chains/node189_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_0_0 -p 235 -st none -pt topic189_0_0 -u 0.008995041887825905 > ./result_6chains/node189_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_1_0 -p 337 -st none -pt topic189_1_0 -u 0.036100070649945915 > ./result_6chains/node189_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_2_0 -p 433 -st none -pt topic189_2_0 -u 0.042982097118312745 > ./result_6chains/node189_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_3_0 -p 471 -st none -pt topic189_3_0 -u 0.004131418646913798 > ./result_6chains/node189_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_4_0 -p 765 -st none -pt topic189_4_0 -u 0.025388264740426186 > ./result_6chains/node189_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_5_0 -p 802 -st none -pt topic189_5_0 -u 0.1182732957020988 > ./result_6chains/node189_5_0.txt &
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
    "./result_6chains/node189_0_0.txt 90"
    "./result_6chains/node189_0_2.txt 90"
    "./result_6chains/node189_1_0.txt 89"
    "./result_6chains/node189_1_2.txt 89"
    "./result_6chains/node189_2_0.txt 88"
    "./result_6chains/node189_2_2.txt 88"
    "./result_6chains/node189_3_0.txt 87"
    "./result_6chains/node189_3_2.txt 87"
    "./result_6chains/node189_4_0.txt 86"
    "./result_6chains/node189_4_2.txt 86"
    "./result_6chains/node189_5_0.txt 85"
    "./result_6chains/node189_5_2.txt 85"
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
