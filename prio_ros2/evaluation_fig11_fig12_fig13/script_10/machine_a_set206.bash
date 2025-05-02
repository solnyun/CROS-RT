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
ros2 run evaluation_3_randomdag uunifast_node -n node206_0_2 -p 18 -st topic206_0_1 -pt None -u 0.030024446956801343 > ./result_10chains/node206_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node206_1_2 -p 378 -st topic206_1_1 -pt None -u 0.00442598104919445 > ./result_10chains/node206_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_2_2 -p 394 -st topic206_2_1 -pt None -u 0.0006923741231295022 > ./result_10chains/node206_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node206_3_2 -p 432 -st topic206_3_1 -pt None -u 0.025996303682885913 > ./result_10chains/node206_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_4_2 -p 472 -st topic206_4_1 -pt None -u 0.017993478869310187 > ./result_10chains/node206_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node206_5_2 -p 646 -st topic206_5_1 -pt None -u 0.022570041011930247 > ./result_10chains/node206_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_6_2 -p 761 -st topic206_6_1 -pt None -u 0.028242833659756272 > ./result_10chains/node206_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node206_7_2 -p 774 -st topic206_7_1 -pt None -u 0.0066057490132457874 > ./result_10chains/node206_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_8_2 -p 778 -st topic206_8_1 -pt None -u 0.02082635607171092 > ./result_10chains/node206_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node206_9_2 -p 802 -st topic206_9_1 -pt None -u 0.02166859007580639 > ./result_10chains/node206_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_0_0 -p 18 -st none -pt topic206_0_0 -u 0.008661308518517652 > ./result_10chains/node206_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node206_1_0 -p 378 -st none -pt topic206_1_0 -u 0.002332480264157555 > ./result_10chains/node206_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_2_0 -p 394 -st none -pt topic206_2_0 -u 0.021630923639634703 > ./result_10chains/node206_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node206_3_0 -p 432 -st none -pt topic206_3_0 -u 0.04937713202989025 > ./result_10chains/node206_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_4_0 -p 472 -st none -pt topic206_4_0 -u 0.03426678287463447 > ./result_10chains/node206_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node206_5_0 -p 646 -st none -pt topic206_5_0 -u 0.015627764990843285 > ./result_10chains/node206_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_6_0 -p 761 -st none -pt topic206_6_0 -u 0.011983172229651257 > ./result_10chains/node206_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node206_7_0 -p 774 -st none -pt topic206_7_0 -u 0.00438483893051872 > ./result_10chains/node206_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_8_0 -p 778 -st none -pt topic206_8_0 -u 0.04059651837526718 > ./result_10chains/node206_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node206_9_0 -p 802 -st none -pt topic206_9_0 -u 0.021682219760776916 > ./result_10chains/node206_9_0.txt &
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
    "./result_10chains/node206_0_0.txt 90"
    "./result_10chains/node206_0_2.txt 90"
    "./result_10chains/node206_1_0.txt 89"
    "./result_10chains/node206_1_2.txt 89"
    "./result_10chains/node206_2_0.txt 88"
    "./result_10chains/node206_2_2.txt 88"
    "./result_10chains/node206_3_0.txt 87"
    "./result_10chains/node206_3_2.txt 87"
    "./result_10chains/node206_4_0.txt 86"
    "./result_10chains/node206_4_2.txt 86"
    "./result_10chains/node206_5_0.txt 85"
    "./result_10chains/node206_5_2.txt 85"
    "./result_10chains/node206_6_0.txt 84"
    "./result_10chains/node206_6_2.txt 84"
    "./result_10chains/node206_7_0.txt 83"
    "./result_10chains/node206_7_2.txt 83"
    "./result_10chains/node206_8_0.txt 82"
    "./result_10chains/node206_8_2.txt 82"
    "./result_10chains/node206_9_0.txt 81"
    "./result_10chains/node206_9_2.txt 81"
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
