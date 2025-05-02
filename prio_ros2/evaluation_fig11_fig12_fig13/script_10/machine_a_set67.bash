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
ros2 run evaluation_3_randomdag uunifast_node -n node67_0_2 -p 43 -st topic67_0_1 -pt None -u 0.013530117012563458 > ./result_10chains/node67_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_1_2 -p 124 -st topic67_1_1 -pt None -u 0.015325474798937089 > ./result_10chains/node67_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_2_2 -p 374 -st topic67_2_1 -pt None -u 0.021430255097000195 > ./result_10chains/node67_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_3_2 -p 444 -st topic67_3_1 -pt None -u 0.008159404570796225 > ./result_10chains/node67_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_4_2 -p 471 -st topic67_4_1 -pt None -u 0.009503937051147993 > ./result_10chains/node67_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_5_2 -p 518 -st topic67_5_1 -pt None -u 0.0028003085746426404 > ./result_10chains/node67_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_6_2 -p 644 -st topic67_6_1 -pt None -u 0.016134866780062512 > ./result_10chains/node67_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_7_2 -p 661 -st topic67_7_1 -pt None -u 0.023451460659811296 > ./result_10chains/node67_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_8_2 -p 947 -st topic67_8_1 -pt None -u 0.001327042722936135 > ./result_10chains/node67_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_9_2 -p 951 -st topic67_9_1 -pt None -u 0.01278772391401719 > ./result_10chains/node67_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_0_0 -p 43 -st none -pt topic67_0_0 -u 0.019538836946721705 > ./result_10chains/node67_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_1_0 -p 124 -st none -pt topic67_1_0 -u 0.015700668568852605 > ./result_10chains/node67_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_2_0 -p 374 -st none -pt topic67_2_0 -u 0.0025414727463505815 > ./result_10chains/node67_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_3_0 -p 444 -st none -pt topic67_3_0 -u 0.010835451702320809 > ./result_10chains/node67_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_4_0 -p 471 -st none -pt topic67_4_0 -u 0.012737936688355156 > ./result_10chains/node67_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_5_0 -p 518 -st none -pt topic67_5_0 -u 0.018536251906455525 > ./result_10chains/node67_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_6_0 -p 644 -st none -pt topic67_6_0 -u 0.007731381229451495 > ./result_10chains/node67_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_7_0 -p 661 -st none -pt topic67_7_0 -u 0.04290800518265729 > ./result_10chains/node67_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_8_0 -p 947 -st none -pt topic67_8_0 -u 0.011759576192866751 > ./result_10chains/node67_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_9_0 -p 951 -st none -pt topic67_9_0 -u 0.018871219086902792 > ./result_10chains/node67_9_0.txt &
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
    "./result_10chains/node67_0_0.txt 90"
    "./result_10chains/node67_0_2.txt 90"
    "./result_10chains/node67_1_0.txt 89"
    "./result_10chains/node67_1_2.txt 89"
    "./result_10chains/node67_2_0.txt 88"
    "./result_10chains/node67_2_2.txt 88"
    "./result_10chains/node67_3_0.txt 87"
    "./result_10chains/node67_3_2.txt 87"
    "./result_10chains/node67_4_0.txt 86"
    "./result_10chains/node67_4_2.txt 86"
    "./result_10chains/node67_5_0.txt 85"
    "./result_10chains/node67_5_2.txt 85"
    "./result_10chains/node67_6_0.txt 84"
    "./result_10chains/node67_6_2.txt 84"
    "./result_10chains/node67_7_0.txt 83"
    "./result_10chains/node67_7_2.txt 83"
    "./result_10chains/node67_8_0.txt 82"
    "./result_10chains/node67_8_2.txt 82"
    "./result_10chains/node67_9_0.txt 81"
    "./result_10chains/node67_9_2.txt 81"
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
