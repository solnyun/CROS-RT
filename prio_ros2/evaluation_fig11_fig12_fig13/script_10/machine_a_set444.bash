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
ros2 run evaluation_3_randomdag uunifast_node -n node444_0_2 -p 71 -st topic444_0_1 -pt None -u 0.017091476086815605 > ./result_10chains/node444_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_1_2 -p 146 -st topic444_1_1 -pt None -u 0.0022959190672968144 > ./result_10chains/node444_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_2_2 -p 261 -st topic444_2_1 -pt None -u 0.009565850311779145 > ./result_10chains/node444_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_3_2 -p 271 -st topic444_3_1 -pt None -u 0.009227750440892024 > ./result_10chains/node444_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_4_2 -p 280 -st topic444_4_1 -pt None -u 0.03133974121300892 > ./result_10chains/node444_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_5_2 -p 281 -st topic444_5_1 -pt None -u 0.0007801506888955034 > ./result_10chains/node444_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_6_2 -p 334 -st topic444_6_1 -pt None -u 0.015600865670973268 > ./result_10chains/node444_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_7_2 -p 476 -st topic444_7_1 -pt None -u 0.01559230721071167 > ./result_10chains/node444_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_8_2 -p 808 -st topic444_8_1 -pt None -u 0.05044838051934542 > ./result_10chains/node444_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_9_2 -p 827 -st topic444_9_1 -pt None -u 0.0006501631974009306 > ./result_10chains/node444_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_0_0 -p 71 -st none -pt topic444_0_0 -u 0.0008152613945474618 > ./result_10chains/node444_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_1_0 -p 146 -st none -pt topic444_1_0 -u 0.001207215617824886 > ./result_10chains/node444_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_2_0 -p 261 -st none -pt topic444_2_0 -u 0.0005141243901680137 > ./result_10chains/node444_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_3_0 -p 271 -st none -pt topic444_3_0 -u 0.004636081341999665 > ./result_10chains/node444_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_4_0 -p 280 -st none -pt topic444_4_0 -u 0.01599121668525949 > ./result_10chains/node444_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_5_0 -p 281 -st none -pt topic444_5_0 -u 0.018207236254901282 > ./result_10chains/node444_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_6_0 -p 334 -st none -pt topic444_6_0 -u 0.0022074746277570556 > ./result_10chains/node444_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_7_0 -p 476 -st none -pt topic444_7_0 -u 0.013182711387663248 > ./result_10chains/node444_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_8_0 -p 808 -st none -pt topic444_8_0 -u 0.014546727314202035 > ./result_10chains/node444_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_9_0 -p 827 -st none -pt topic444_9_0 -u 0.020445437449933726 > ./result_10chains/node444_9_0.txt &
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
    "./result_10chains/node444_0_0.txt 90"
    "./result_10chains/node444_0_2.txt 90"
    "./result_10chains/node444_1_0.txt 89"
    "./result_10chains/node444_1_2.txt 89"
    "./result_10chains/node444_2_0.txt 88"
    "./result_10chains/node444_2_2.txt 88"
    "./result_10chains/node444_3_0.txt 87"
    "./result_10chains/node444_3_2.txt 87"
    "./result_10chains/node444_4_0.txt 86"
    "./result_10chains/node444_4_2.txt 86"
    "./result_10chains/node444_5_0.txt 85"
    "./result_10chains/node444_5_2.txt 85"
    "./result_10chains/node444_6_0.txt 84"
    "./result_10chains/node444_6_2.txt 84"
    "./result_10chains/node444_7_0.txt 83"
    "./result_10chains/node444_7_2.txt 83"
    "./result_10chains/node444_8_0.txt 82"
    "./result_10chains/node444_8_2.txt 82"
    "./result_10chains/node444_9_0.txt 81"
    "./result_10chains/node444_9_2.txt 81"
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
