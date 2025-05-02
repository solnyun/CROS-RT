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
ros2 run evaluation_3_randomdag uunifast_node -n node48_0_2 -p 46 -st topic48_0_1 -pt None -u 0.008323805803359674 > ./result_8chains/node48_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_1_2 -p 291 -st topic48_1_1 -pt None -u 0.008872106937981517 > ./result_8chains/node48_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_2_2 -p 594 -st topic48_2_1 -pt None -u 0.06509284394398063 > ./result_8chains/node48_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_3_2 -p 603 -st topic48_3_1 -pt None -u 0.0009293330545481759 > ./result_8chains/node48_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_4_2 -p 619 -st topic48_4_1 -pt None -u 0.008275462332353378 > ./result_8chains/node48_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_5_2 -p 699 -st topic48_5_1 -pt None -u 0.04287472870989803 > ./result_8chains/node48_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_6_2 -p 752 -st topic48_6_1 -pt None -u 0.0042663929837900155 > ./result_8chains/node48_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_7_2 -p 875 -st topic48_7_1 -pt None -u 0.008564220838689284 > ./result_8chains/node48_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_0_0 -p 46 -st none -pt topic48_0_0 -u 0.013589139751653878 > ./result_8chains/node48_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_1_0 -p 291 -st none -pt topic48_1_0 -u 0.050485325504033396 > ./result_8chains/node48_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_2_0 -p 594 -st none -pt topic48_2_0 -u 0.02410742895161999 > ./result_8chains/node48_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_3_0 -p 603 -st none -pt topic48_3_0 -u 0.0023177837206417307 > ./result_8chains/node48_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_4_0 -p 619 -st none -pt topic48_4_0 -u 0.030121529095639143 > ./result_8chains/node48_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_5_0 -p 699 -st none -pt topic48_5_0 -u 0.029364363596268678 > ./result_8chains/node48_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_6_0 -p 752 -st none -pt topic48_6_0 -u 0.008278179027087725 > ./result_8chains/node48_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_7_0 -p 875 -st none -pt topic48_7_0 -u 0.03203290387064163 > ./result_8chains/node48_7_0.txt &
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
    "./result_8chains/node48_0_0.txt 90"
    "./result_8chains/node48_0_2.txt 90"
    "./result_8chains/node48_1_0.txt 89"
    "./result_8chains/node48_1_2.txt 89"
    "./result_8chains/node48_2_0.txt 88"
    "./result_8chains/node48_2_2.txt 88"
    "./result_8chains/node48_3_0.txt 87"
    "./result_8chains/node48_3_2.txt 87"
    "./result_8chains/node48_4_0.txt 86"
    "./result_8chains/node48_4_2.txt 86"
    "./result_8chains/node48_5_0.txt 85"
    "./result_8chains/node48_5_2.txt 85"
    "./result_8chains/node48_6_0.txt 84"
    "./result_8chains/node48_6_2.txt 84"
    "./result_8chains/node48_7_0.txt 83"
    "./result_8chains/node48_7_2.txt 83"
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
