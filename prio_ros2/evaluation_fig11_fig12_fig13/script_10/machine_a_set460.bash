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
ros2 run evaluation_3_randomdag uunifast_node -n node460_0_2 -p 109 -st topic460_0_1 -pt None -u 0.008833849227235846 > ./result_10chains/node460_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_1_2 -p 159 -st topic460_1_1 -pt None -u 0.014461366937242703 > ./result_10chains/node460_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_2_2 -p 278 -st topic460_2_1 -pt None -u 0.003413222804736993 > ./result_10chains/node460_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_3_2 -p 389 -st topic460_3_1 -pt None -u 0.011909059206365369 > ./result_10chains/node460_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_4_2 -p 504 -st topic460_4_1 -pt None -u 0.0736220951750691 > ./result_10chains/node460_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_5_2 -p 505 -st topic460_5_1 -pt None -u 0.0019450003805527583 > ./result_10chains/node460_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_6_2 -p 645 -st topic460_6_1 -pt None -u 0.007291261396192933 > ./result_10chains/node460_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_7_2 -p 847 -st topic460_7_1 -pt None -u 0.001574099541529081 > ./result_10chains/node460_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_8_2 -p 888 -st topic460_8_1 -pt None -u 0.015678685821703276 > ./result_10chains/node460_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_9_2 -p 903 -st topic460_9_1 -pt None -u 0.007057495949993665 > ./result_10chains/node460_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_0_0 -p 109 -st none -pt topic460_0_0 -u 0.010384068543618785 > ./result_10chains/node460_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_1_0 -p 159 -st none -pt topic460_1_0 -u 0.01336701240173116 > ./result_10chains/node460_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_2_0 -p 278 -st none -pt topic460_2_0 -u 0.0005920502830306651 > ./result_10chains/node460_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_3_0 -p 389 -st none -pt topic460_3_0 -u 0.004992318764056036 > ./result_10chains/node460_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_4_0 -p 504 -st none -pt topic460_4_0 -u 0.01662520728296335 > ./result_10chains/node460_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_5_0 -p 505 -st none -pt topic460_5_0 -u 0.027216275307101856 > ./result_10chains/node460_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_6_0 -p 645 -st none -pt topic460_6_0 -u 0.04379486958299439 > ./result_10chains/node460_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_7_0 -p 847 -st none -pt topic460_7_0 -u 0.010246085443540207 > ./result_10chains/node460_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_8_0 -p 888 -st none -pt topic460_8_0 -u 0.0208361069670042 > ./result_10chains/node460_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_9_0 -p 903 -st none -pt topic460_9_0 -u 0.002304694482971978 > ./result_10chains/node460_9_0.txt &
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
    "./result_10chains/node460_0_0.txt 90"
    "./result_10chains/node460_0_2.txt 90"
    "./result_10chains/node460_1_0.txt 89"
    "./result_10chains/node460_1_2.txt 89"
    "./result_10chains/node460_2_0.txt 88"
    "./result_10chains/node460_2_2.txt 88"
    "./result_10chains/node460_3_0.txt 87"
    "./result_10chains/node460_3_2.txt 87"
    "./result_10chains/node460_4_0.txt 86"
    "./result_10chains/node460_4_2.txt 86"
    "./result_10chains/node460_5_0.txt 85"
    "./result_10chains/node460_5_2.txt 85"
    "./result_10chains/node460_6_0.txt 84"
    "./result_10chains/node460_6_2.txt 84"
    "./result_10chains/node460_7_0.txt 83"
    "./result_10chains/node460_7_2.txt 83"
    "./result_10chains/node460_8_0.txt 82"
    "./result_10chains/node460_8_2.txt 82"
    "./result_10chains/node460_9_0.txt 81"
    "./result_10chains/node460_9_2.txt 81"
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
