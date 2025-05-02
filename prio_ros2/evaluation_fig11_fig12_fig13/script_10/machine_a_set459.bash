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
ros2 run evaluation_3_randomdag uunifast_node -n node459_0_2 -p 161 -st topic459_0_1 -pt None -u 0.0189418857195765 > ./result_10chains/node459_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_1_2 -p 266 -st topic459_1_1 -pt None -u 0.013195984480816159 > ./result_10chains/node459_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_2_2 -p 329 -st topic459_2_1 -pt None -u 0.027294254283573016 > ./result_10chains/node459_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_3_2 -p 464 -st topic459_3_1 -pt None -u 0.007000688816925282 > ./result_10chains/node459_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_4_2 -p 465 -st topic459_4_1 -pt None -u 0.030505094197737864 > ./result_10chains/node459_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_5_2 -p 500 -st topic459_5_1 -pt None -u 0.0004450320465979596 > ./result_10chains/node459_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_6_2 -p 512 -st topic459_6_1 -pt None -u 0.027262490487599336 > ./result_10chains/node459_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_7_2 -p 766 -st topic459_7_1 -pt None -u 0.051722216605509144 > ./result_10chains/node459_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_8_2 -p 915 -st topic459_8_1 -pt None -u 0.000769750669443417 > ./result_10chains/node459_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_9_2 -p 978 -st topic459_9_1 -pt None -u 0.005951506357457018 > ./result_10chains/node459_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_0_0 -p 161 -st none -pt topic459_0_0 -u 0.020237823289593504 > ./result_10chains/node459_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_1_0 -p 266 -st none -pt topic459_1_0 -u 0.02711762723129757 > ./result_10chains/node459_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_2_0 -p 329 -st none -pt topic459_2_0 -u 0.012695478194366394 > ./result_10chains/node459_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_3_0 -p 464 -st none -pt topic459_3_0 -u 0.011848287363338261 > ./result_10chains/node459_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_4_0 -p 465 -st none -pt topic459_4_0 -u 0.05465290301146225 > ./result_10chains/node459_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_5_0 -p 500 -st none -pt topic459_5_0 -u 0.012577703650252903 > ./result_10chains/node459_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_6_0 -p 512 -st none -pt topic459_6_0 -u 0.008802154442815319 > ./result_10chains/node459_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_7_0 -p 766 -st none -pt topic459_7_0 -u 0.003577370138721378 > ./result_10chains/node459_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_8_0 -p 915 -st none -pt topic459_8_0 -u 0.012367214461292499 > ./result_10chains/node459_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_9_0 -p 978 -st none -pt topic459_9_0 -u 0.004524352366090372 > ./result_10chains/node459_9_0.txt &
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
    "./result_10chains/node459_0_0.txt 90"
    "./result_10chains/node459_0_2.txt 90"
    "./result_10chains/node459_1_0.txt 89"
    "./result_10chains/node459_1_2.txt 89"
    "./result_10chains/node459_2_0.txt 88"
    "./result_10chains/node459_2_2.txt 88"
    "./result_10chains/node459_3_0.txt 87"
    "./result_10chains/node459_3_2.txt 87"
    "./result_10chains/node459_4_0.txt 86"
    "./result_10chains/node459_4_2.txt 86"
    "./result_10chains/node459_5_0.txt 85"
    "./result_10chains/node459_5_2.txt 85"
    "./result_10chains/node459_6_0.txt 84"
    "./result_10chains/node459_6_2.txt 84"
    "./result_10chains/node459_7_0.txt 83"
    "./result_10chains/node459_7_2.txt 83"
    "./result_10chains/node459_8_0.txt 82"
    "./result_10chains/node459_8_2.txt 82"
    "./result_10chains/node459_9_0.txt 81"
    "./result_10chains/node459_9_2.txt 81"
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
