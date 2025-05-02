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
ros2 run evaluation_3_randomdag uunifast_node -n node155_0_2 -p 121 -st topic155_0_1 -pt None -u 0.021267612308160933 > ./result_10chains/node155_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_1_2 -p 227 -st topic155_1_1 -pt None -u 0.00220129505071337 > ./result_10chains/node155_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_2_2 -p 240 -st topic155_2_1 -pt None -u 0.01693638793381924 > ./result_10chains/node155_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_3_2 -p 263 -st topic155_3_1 -pt None -u 0.016660843441983625 > ./result_10chains/node155_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_4_2 -p 350 -st topic155_4_1 -pt None -u 0.029191505370341264 > ./result_10chains/node155_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_5_2 -p 460 -st topic155_5_1 -pt None -u 0.009547333011008574 > ./result_10chains/node155_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_6_2 -p 771 -st topic155_6_1 -pt None -u 0.002785971198056153 > ./result_10chains/node155_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_7_2 -p 828 -st topic155_7_1 -pt None -u 0.028078816399200818 > ./result_10chains/node155_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_8_2 -p 870 -st topic155_8_1 -pt None -u 0.014034583974743234 > ./result_10chains/node155_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_9_2 -p 956 -st topic155_9_1 -pt None -u 0.007724577657483582 > ./result_10chains/node155_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_0_0 -p 121 -st none -pt topic155_0_0 -u 0.02275219400977818 > ./result_10chains/node155_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_1_0 -p 227 -st none -pt topic155_1_0 -u 0.02246458282964564 > ./result_10chains/node155_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_2_0 -p 240 -st none -pt topic155_2_0 -u 0.04498107190329015 > ./result_10chains/node155_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_3_0 -p 263 -st none -pt topic155_3_0 -u 0.06376989852905379 > ./result_10chains/node155_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_4_0 -p 350 -st none -pt topic155_4_0 -u 0.004619512181665508 > ./result_10chains/node155_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_5_0 -p 460 -st none -pt topic155_5_0 -u 0.0009101378350959977 > ./result_10chains/node155_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_6_0 -p 771 -st none -pt topic155_6_0 -u 0.002969215645573259 > ./result_10chains/node155_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_7_0 -p 828 -st none -pt topic155_7_0 -u 0.002426999139828273 > ./result_10chains/node155_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_8_0 -p 870 -st none -pt topic155_8_0 -u 0.007859765920071107 > ./result_10chains/node155_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_9_0 -p 956 -st none -pt topic155_9_0 -u 0.0034220126239832283 > ./result_10chains/node155_9_0.txt &
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
    "./result_10chains/node155_0_0.txt 90"
    "./result_10chains/node155_0_2.txt 90"
    "./result_10chains/node155_1_0.txt 89"
    "./result_10chains/node155_1_2.txt 89"
    "./result_10chains/node155_2_0.txt 88"
    "./result_10chains/node155_2_2.txt 88"
    "./result_10chains/node155_3_0.txt 87"
    "./result_10chains/node155_3_2.txt 87"
    "./result_10chains/node155_4_0.txt 86"
    "./result_10chains/node155_4_2.txt 86"
    "./result_10chains/node155_5_0.txt 85"
    "./result_10chains/node155_5_2.txt 85"
    "./result_10chains/node155_6_0.txt 84"
    "./result_10chains/node155_6_2.txt 84"
    "./result_10chains/node155_7_0.txt 83"
    "./result_10chains/node155_7_2.txt 83"
    "./result_10chains/node155_8_0.txt 82"
    "./result_10chains/node155_8_2.txt 82"
    "./result_10chains/node155_9_0.txt 81"
    "./result_10chains/node155_9_2.txt 81"
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
