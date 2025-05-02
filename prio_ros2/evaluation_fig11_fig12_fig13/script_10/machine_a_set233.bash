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
ros2 run evaluation_3_randomdag uunifast_node -n node233_0_2 -p 51 -st topic233_0_1 -pt None -u 0.03388272067822723 > ./result_10chains/node233_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_1_2 -p 70 -st topic233_1_1 -pt None -u 0.03801677683959587 > ./result_10chains/node233_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_2_2 -p 84 -st topic233_2_1 -pt None -u 0.011025335250024415 > ./result_10chains/node233_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_3_2 -p 122 -st topic233_3_1 -pt None -u 0.0026737358851572357 > ./result_10chains/node233_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_4_2 -p 394 -st topic233_4_1 -pt None -u 0.011483694267678812 > ./result_10chains/node233_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_5_2 -p 641 -st topic233_5_1 -pt None -u 0.024114384048065235 > ./result_10chains/node233_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_6_2 -p 677 -st topic233_6_1 -pt None -u 0.010738600589396435 > ./result_10chains/node233_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_7_2 -p 741 -st topic233_7_1 -pt None -u 0.01963177698884938 > ./result_10chains/node233_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_8_2 -p 913 -st topic233_8_1 -pt None -u 0.0026387520282094984 > ./result_10chains/node233_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_9_2 -p 983 -st topic233_9_1 -pt None -u 0.00876549982169415 > ./result_10chains/node233_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_0_0 -p 51 -st none -pt topic233_0_0 -u 0.000995061975443634 > ./result_10chains/node233_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_1_0 -p 70 -st none -pt topic233_1_0 -u 0.023037998868794207 > ./result_10chains/node233_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_2_0 -p 84 -st none -pt topic233_2_0 -u 0.0036477563037472516 > ./result_10chains/node233_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_3_0 -p 122 -st none -pt topic233_3_0 -u 0.009851513497196762 > ./result_10chains/node233_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_4_0 -p 394 -st none -pt topic233_4_0 -u 0.01746578540232957 > ./result_10chains/node233_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_5_0 -p 641 -st none -pt topic233_5_0 -u 0.014710824790764215 > ./result_10chains/node233_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_6_0 -p 677 -st none -pt topic233_6_0 -u 0.011437873892823996 > ./result_10chains/node233_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_7_0 -p 741 -st none -pt topic233_7_0 -u 0.0034942408547841974 > ./result_10chains/node233_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_8_0 -p 913 -st none -pt topic233_8_0 -u 0.023518098080269334 > ./result_10chains/node233_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_9_0 -p 983 -st none -pt topic233_9_0 -u 0.02627200056535209 > ./result_10chains/node233_9_0.txt &
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
    "./result_10chains/node233_0_0.txt 90"
    "./result_10chains/node233_0_2.txt 90"
    "./result_10chains/node233_1_0.txt 89"
    "./result_10chains/node233_1_2.txt 89"
    "./result_10chains/node233_2_0.txt 88"
    "./result_10chains/node233_2_2.txt 88"
    "./result_10chains/node233_3_0.txt 87"
    "./result_10chains/node233_3_2.txt 87"
    "./result_10chains/node233_4_0.txt 86"
    "./result_10chains/node233_4_2.txt 86"
    "./result_10chains/node233_5_0.txt 85"
    "./result_10chains/node233_5_2.txt 85"
    "./result_10chains/node233_6_0.txt 84"
    "./result_10chains/node233_6_2.txt 84"
    "./result_10chains/node233_7_0.txt 83"
    "./result_10chains/node233_7_2.txt 83"
    "./result_10chains/node233_8_0.txt 82"
    "./result_10chains/node233_8_2.txt 82"
    "./result_10chains/node233_9_0.txt 81"
    "./result_10chains/node233_9_2.txt 81"
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
