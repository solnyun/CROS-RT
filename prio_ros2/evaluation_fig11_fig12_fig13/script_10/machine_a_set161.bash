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
ros2 run evaluation_3_randomdag uunifast_node -n node161_0_2 -p 130 -st topic161_0_1 -pt None -u 0.03376753720346204 > ./result_10chains/node161_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node161_1_2 -p 210 -st topic161_1_1 -pt None -u 0.045628695726251056 > ./result_10chains/node161_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_2_2 -p 211 -st topic161_2_1 -pt None -u 0.035440875925446313 > ./result_10chains/node161_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node161_3_2 -p 294 -st topic161_3_1 -pt None -u 0.0092857757988844 > ./result_10chains/node161_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_4_2 -p 355 -st topic161_4_1 -pt None -u 0.008502203691050925 > ./result_10chains/node161_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node161_5_2 -p 522 -st topic161_5_1 -pt None -u 0.007388058477398429 > ./result_10chains/node161_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_6_2 -p 865 -st topic161_6_1 -pt None -u 0.023892356413017207 > ./result_10chains/node161_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node161_7_2 -p 878 -st topic161_7_1 -pt None -u 0.04148001260865644 > ./result_10chains/node161_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_8_2 -p 893 -st topic161_8_1 -pt None -u 0.03571315230034078 > ./result_10chains/node161_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node161_9_2 -p 970 -st topic161_9_1 -pt None -u 0.022307260522803227 > ./result_10chains/node161_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_0_0 -p 130 -st none -pt topic161_0_0 -u 0.012645158789142963 > ./result_10chains/node161_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node161_1_0 -p 210 -st none -pt topic161_1_0 -u 0.005467756186202044 > ./result_10chains/node161_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_2_0 -p 211 -st none -pt topic161_2_0 -u 0.0029809669850148768 > ./result_10chains/node161_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node161_3_0 -p 294 -st none -pt topic161_3_0 -u 0.005641067747762851 > ./result_10chains/node161_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_4_0 -p 355 -st none -pt topic161_4_0 -u 0.0170616907434728 > ./result_10chains/node161_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node161_5_0 -p 522 -st none -pt topic161_5_0 -u 0.0003196824315110369 > ./result_10chains/node161_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_6_0 -p 865 -st none -pt topic161_6_0 -u 0.01318212961795201 > ./result_10chains/node161_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node161_7_0 -p 878 -st none -pt topic161_7_0 -u 0.014778425965829983 > ./result_10chains/node161_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_8_0 -p 893 -st none -pt topic161_8_0 -u 0.022822259074360446 > ./result_10chains/node161_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node161_9_0 -p 970 -st none -pt topic161_9_0 -u 0.005013879049001649 > ./result_10chains/node161_9_0.txt &
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
    "./result_10chains/node161_0_0.txt 90"
    "./result_10chains/node161_0_2.txt 90"
    "./result_10chains/node161_1_0.txt 89"
    "./result_10chains/node161_1_2.txt 89"
    "./result_10chains/node161_2_0.txt 88"
    "./result_10chains/node161_2_2.txt 88"
    "./result_10chains/node161_3_0.txt 87"
    "./result_10chains/node161_3_2.txt 87"
    "./result_10chains/node161_4_0.txt 86"
    "./result_10chains/node161_4_2.txt 86"
    "./result_10chains/node161_5_0.txt 85"
    "./result_10chains/node161_5_2.txt 85"
    "./result_10chains/node161_6_0.txt 84"
    "./result_10chains/node161_6_2.txt 84"
    "./result_10chains/node161_7_0.txt 83"
    "./result_10chains/node161_7_2.txt 83"
    "./result_10chains/node161_8_0.txt 82"
    "./result_10chains/node161_8_2.txt 82"
    "./result_10chains/node161_9_0.txt 81"
    "./result_10chains/node161_9_2.txt 81"
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
