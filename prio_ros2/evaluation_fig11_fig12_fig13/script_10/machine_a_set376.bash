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
ros2 run evaluation_3_randomdag uunifast_node -n node376_0_2 -p 48 -st topic376_0_1 -pt None -u 0.01760279789180913 > ./result_10chains/node376_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_1_2 -p 302 -st topic376_1_1 -pt None -u 0.0019102911478666162 > ./result_10chains/node376_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_2_2 -p 429 -st topic376_2_1 -pt None -u 0.0007692465928986758 > ./result_10chains/node376_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_3_2 -p 449 -st topic376_3_1 -pt None -u 0.03108674718614235 > ./result_10chains/node376_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_4_2 -p 470 -st topic376_4_1 -pt None -u 0.019968522541740308 > ./result_10chains/node376_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_5_2 -p 543 -st topic376_5_1 -pt None -u 0.04170482888180846 > ./result_10chains/node376_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_6_2 -p 627 -st topic376_6_1 -pt None -u 0.014038204571697244 > ./result_10chains/node376_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_7_2 -p 639 -st topic376_7_1 -pt None -u 0.0452518158538341 > ./result_10chains/node376_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_8_2 -p 805 -st topic376_8_1 -pt None -u 0.031720278595089774 > ./result_10chains/node376_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_9_2 -p 870 -st topic376_9_1 -pt None -u 0.019448920116049238 > ./result_10chains/node376_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_0_0 -p 48 -st none -pt topic376_0_0 -u 0.00030790757892740217 > ./result_10chains/node376_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_1_0 -p 302 -st none -pt topic376_1_0 -u 0.04468779098458997 > ./result_10chains/node376_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_2_0 -p 429 -st none -pt topic376_2_0 -u 0.007225694966951746 > ./result_10chains/node376_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_3_0 -p 449 -st none -pt topic376_3_0 -u 0.02356546749225813 > ./result_10chains/node376_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_4_0 -p 470 -st none -pt topic376_4_0 -u 0.003936240694112136 > ./result_10chains/node376_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_5_0 -p 543 -st none -pt topic376_5_0 -u 0.012635859058671983 > ./result_10chains/node376_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_6_0 -p 627 -st none -pt topic376_6_0 -u 0.015082662243752015 > ./result_10chains/node376_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_7_0 -p 639 -st none -pt topic376_7_0 -u 0.0008391812331703108 > ./result_10chains/node376_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_8_0 -p 805 -st none -pt topic376_8_0 -u 0.04563825450732303 > ./result_10chains/node376_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_9_0 -p 870 -st none -pt topic376_9_0 -u 0.003754414530696002 > ./result_10chains/node376_9_0.txt &
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
    "./result_10chains/node376_0_0.txt 90"
    "./result_10chains/node376_0_2.txt 90"
    "./result_10chains/node376_1_0.txt 89"
    "./result_10chains/node376_1_2.txt 89"
    "./result_10chains/node376_2_0.txt 88"
    "./result_10chains/node376_2_2.txt 88"
    "./result_10chains/node376_3_0.txt 87"
    "./result_10chains/node376_3_2.txt 87"
    "./result_10chains/node376_4_0.txt 86"
    "./result_10chains/node376_4_2.txt 86"
    "./result_10chains/node376_5_0.txt 85"
    "./result_10chains/node376_5_2.txt 85"
    "./result_10chains/node376_6_0.txt 84"
    "./result_10chains/node376_6_2.txt 84"
    "./result_10chains/node376_7_0.txt 83"
    "./result_10chains/node376_7_2.txt 83"
    "./result_10chains/node376_8_0.txt 82"
    "./result_10chains/node376_8_2.txt 82"
    "./result_10chains/node376_9_0.txt 81"
    "./result_10chains/node376_9_2.txt 81"
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
