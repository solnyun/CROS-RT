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
ros2 run evaluation_3_randomdag uunifast_node -n node3_0_2 -p 16 -st topic3_0_1 -pt None -u 0.03240165590814609 > ./result_10chains/node3_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_1_2 -p 61 -st topic3_1_1 -pt None -u 0.03893914614337246 > ./result_10chains/node3_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_2_2 -p 64 -st topic3_2_1 -pt None -u 0.01056074570433696 > ./result_10chains/node3_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_3_2 -p 90 -st topic3_3_1 -pt None -u 0.04285404903198792 > ./result_10chains/node3_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_4_2 -p 175 -st topic3_4_1 -pt None -u 0.015181431474914436 > ./result_10chains/node3_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_5_2 -p 305 -st topic3_5_1 -pt None -u 0.003436778425069925 > ./result_10chains/node3_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_6_2 -p 456 -st topic3_6_1 -pt None -u 0.024113223272748202 > ./result_10chains/node3_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_7_2 -p 490 -st topic3_7_1 -pt None -u 0.0024905452911369447 > ./result_10chains/node3_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_8_2 -p 756 -st topic3_8_1 -pt None -u 0.014349247566970091 > ./result_10chains/node3_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_9_2 -p 849 -st topic3_9_1 -pt None -u 0.01331257373806127 > ./result_10chains/node3_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_0_0 -p 16 -st none -pt topic3_0_0 -u 0.00013035989771298384 > ./result_10chains/node3_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_1_0 -p 61 -st none -pt topic3_1_0 -u 0.024055762824163385 > ./result_10chains/node3_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_2_0 -p 64 -st none -pt topic3_2_0 -u 0.015684875483323035 > ./result_10chains/node3_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_3_0 -p 90 -st none -pt topic3_3_0 -u 0.04840298939417681 > ./result_10chains/node3_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_4_0 -p 175 -st none -pt topic3_4_0 -u 0.005103219909069451 > ./result_10chains/node3_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_5_0 -p 305 -st none -pt topic3_5_0 -u 0.018407810029511168 > ./result_10chains/node3_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_6_0 -p 456 -st none -pt topic3_6_0 -u 0.0021917577251871767 > ./result_10chains/node3_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_7_0 -p 490 -st none -pt topic3_7_0 -u 0.0015398491779957113 > ./result_10chains/node3_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_8_0 -p 756 -st none -pt topic3_8_0 -u 0.001962140392961137 > ./result_10chains/node3_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_9_0 -p 849 -st none -pt topic3_9_0 -u 0.02593009420456656 > ./result_10chains/node3_9_0.txt &
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
    "./result_10chains/node3_0_0.txt 90"
    "./result_10chains/node3_0_2.txt 90"
    "./result_10chains/node3_1_0.txt 89"
    "./result_10chains/node3_1_2.txt 89"
    "./result_10chains/node3_2_0.txt 88"
    "./result_10chains/node3_2_2.txt 88"
    "./result_10chains/node3_3_0.txt 87"
    "./result_10chains/node3_3_2.txt 87"
    "./result_10chains/node3_4_0.txt 86"
    "./result_10chains/node3_4_2.txt 86"
    "./result_10chains/node3_5_0.txt 85"
    "./result_10chains/node3_5_2.txt 85"
    "./result_10chains/node3_6_0.txt 84"
    "./result_10chains/node3_6_2.txt 84"
    "./result_10chains/node3_7_0.txt 83"
    "./result_10chains/node3_7_2.txt 83"
    "./result_10chains/node3_8_0.txt 82"
    "./result_10chains/node3_8_2.txt 82"
    "./result_10chains/node3_9_0.txt 81"
    "./result_10chains/node3_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
