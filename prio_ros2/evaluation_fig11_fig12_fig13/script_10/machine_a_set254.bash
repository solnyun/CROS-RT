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
ros2 run evaluation_3_randomdag uunifast_node -n node254_0_2 -p 11 -st topic254_0_1 -pt None -u 0.004341543611155851 > ./result_10chains/node254_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_1_2 -p 196 -st topic254_1_1 -pt None -u 0.020679182714521904 > ./result_10chains/node254_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_2_2 -p 416 -st topic254_2_1 -pt None -u 0.0015002547002269107 > ./result_10chains/node254_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_3_2 -p 532 -st topic254_3_1 -pt None -u 0.009492288172608387 > ./result_10chains/node254_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_4_2 -p 576 -st topic254_4_1 -pt None -u 0.00034781252967602816 > ./result_10chains/node254_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_5_2 -p 784 -st topic254_5_1 -pt None -u 0.0022586397515613754 > ./result_10chains/node254_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_6_2 -p 815 -st topic254_6_1 -pt None -u 0.0018510635626267924 > ./result_10chains/node254_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_7_2 -p 868 -st topic254_7_1 -pt None -u 0.001969922263605567 > ./result_10chains/node254_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_8_2 -p 980 -st topic254_8_1 -pt None -u 0.04341263216859269 > ./result_10chains/node254_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_9_2 -p 998 -st topic254_9_1 -pt None -u 0.024722726922309066 > ./result_10chains/node254_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_0_0 -p 11 -st none -pt topic254_0_0 -u 0.002057996572880638 > ./result_10chains/node254_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_1_0 -p 196 -st none -pt topic254_1_0 -u 0.0007028360626754604 > ./result_10chains/node254_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_2_0 -p 416 -st none -pt topic254_2_0 -u 0.004907257276169696 > ./result_10chains/node254_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_3_0 -p 532 -st none -pt topic254_3_0 -u 0.004349240352778838 > ./result_10chains/node254_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_4_0 -p 576 -st none -pt topic254_4_0 -u 0.018488297115596353 > ./result_10chains/node254_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_5_0 -p 784 -st none -pt topic254_5_0 -u 0.05473796741336884 > ./result_10chains/node254_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_6_0 -p 815 -st none -pt topic254_6_0 -u 0.03807531085966112 > ./result_10chains/node254_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_7_0 -p 868 -st none -pt topic254_7_0 -u 0.011291339628311026 > ./result_10chains/node254_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_8_0 -p 980 -st none -pt topic254_8_0 -u 0.022727310556908825 > ./result_10chains/node254_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_9_0 -p 998 -st none -pt topic254_9_0 -u 0.02348017592238092 > ./result_10chains/node254_9_0.txt &
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
    "./result_10chains/node254_0_0.txt 90"
    "./result_10chains/node254_0_2.txt 90"
    "./result_10chains/node254_1_0.txt 89"
    "./result_10chains/node254_1_2.txt 89"
    "./result_10chains/node254_2_0.txt 88"
    "./result_10chains/node254_2_2.txt 88"
    "./result_10chains/node254_3_0.txt 87"
    "./result_10chains/node254_3_2.txt 87"
    "./result_10chains/node254_4_0.txt 86"
    "./result_10chains/node254_4_2.txt 86"
    "./result_10chains/node254_5_0.txt 85"
    "./result_10chains/node254_5_2.txt 85"
    "./result_10chains/node254_6_0.txt 84"
    "./result_10chains/node254_6_2.txt 84"
    "./result_10chains/node254_7_0.txt 83"
    "./result_10chains/node254_7_2.txt 83"
    "./result_10chains/node254_8_0.txt 82"
    "./result_10chains/node254_8_2.txt 82"
    "./result_10chains/node254_9_0.txt 81"
    "./result_10chains/node254_9_2.txt 81"
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
