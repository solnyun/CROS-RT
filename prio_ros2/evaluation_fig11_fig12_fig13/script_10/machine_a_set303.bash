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
ros2 run evaluation_3_randomdag uunifast_node -n node303_0_2 -p 49 -st topic303_0_1 -pt None -u 0.022237352132640886 > ./result_10chains/node303_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_1_2 -p 70 -st topic303_1_1 -pt None -u 0.006252167233656014 > ./result_10chains/node303_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_2_2 -p 163 -st topic303_2_1 -pt None -u 0.006594257363148115 > ./result_10chains/node303_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_3_2 -p 246 -st topic303_3_1 -pt None -u 0.026585522909779002 > ./result_10chains/node303_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_4_2 -p 491 -st topic303_4_1 -pt None -u 0.009245871729724714 > ./result_10chains/node303_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_5_2 -p 505 -st topic303_5_1 -pt None -u 0.003469981776673431 > ./result_10chains/node303_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_6_2 -p 512 -st topic303_6_1 -pt None -u 0.02108666453429464 > ./result_10chains/node303_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_7_2 -p 599 -st topic303_7_1 -pt None -u 0.005052243224543812 > ./result_10chains/node303_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_8_2 -p 703 -st topic303_8_1 -pt None -u 0.011304866038516825 > ./result_10chains/node303_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_9_2 -p 806 -st topic303_9_1 -pt None -u 0.03933627315719901 > ./result_10chains/node303_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_0_0 -p 49 -st none -pt topic303_0_0 -u 0.06610441473224499 > ./result_10chains/node303_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_1_0 -p 70 -st none -pt topic303_1_0 -u 0.005613132960620548 > ./result_10chains/node303_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_2_0 -p 163 -st none -pt topic303_2_0 -u 0.008722500972634883 > ./result_10chains/node303_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_3_0 -p 246 -st none -pt topic303_3_0 -u 0.009704538360408632 > ./result_10chains/node303_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_4_0 -p 491 -st none -pt topic303_4_0 -u 0.010080842632317871 > ./result_10chains/node303_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_5_0 -p 505 -st none -pt topic303_5_0 -u 0.003641274932656119 > ./result_10chains/node303_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_6_0 -p 512 -st none -pt topic303_6_0 -u 0.01311771421133548 > ./result_10chains/node303_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_7_0 -p 599 -st none -pt topic303_7_0 -u 0.0010462368304931108 > ./result_10chains/node303_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_8_0 -p 703 -st none -pt topic303_8_0 -u 0.01862550030913368 > ./result_10chains/node303_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_9_0 -p 806 -st none -pt topic303_9_0 -u 0.006562945159287202 > ./result_10chains/node303_9_0.txt &
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
    "./result_10chains/node303_0_0.txt 90"
    "./result_10chains/node303_0_2.txt 90"
    "./result_10chains/node303_1_0.txt 89"
    "./result_10chains/node303_1_2.txt 89"
    "./result_10chains/node303_2_0.txt 88"
    "./result_10chains/node303_2_2.txt 88"
    "./result_10chains/node303_3_0.txt 87"
    "./result_10chains/node303_3_2.txt 87"
    "./result_10chains/node303_4_0.txt 86"
    "./result_10chains/node303_4_2.txt 86"
    "./result_10chains/node303_5_0.txt 85"
    "./result_10chains/node303_5_2.txt 85"
    "./result_10chains/node303_6_0.txt 84"
    "./result_10chains/node303_6_2.txt 84"
    "./result_10chains/node303_7_0.txt 83"
    "./result_10chains/node303_7_2.txt 83"
    "./result_10chains/node303_8_0.txt 82"
    "./result_10chains/node303_8_2.txt 82"
    "./result_10chains/node303_9_0.txt 81"
    "./result_10chains/node303_9_2.txt 81"
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
