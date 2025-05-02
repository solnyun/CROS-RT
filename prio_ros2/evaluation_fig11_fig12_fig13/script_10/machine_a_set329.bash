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
ros2 run evaluation_3_randomdag uunifast_node -n node329_0_2 -p 171 -st topic329_0_1 -pt None -u 0.00142774571314086 > ./result_10chains/node329_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_1_2 -p 278 -st topic329_1_1 -pt None -u 0.016512332130361684 > ./result_10chains/node329_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_2_2 -p 391 -st topic329_2_1 -pt None -u 0.003445554669667339 > ./result_10chains/node329_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_3_2 -p 478 -st topic329_3_1 -pt None -u 0.04227470900413988 > ./result_10chains/node329_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_4_2 -p 532 -st topic329_4_1 -pt None -u 0.001448194862514185 > ./result_10chains/node329_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_5_2 -p 559 -st topic329_5_1 -pt None -u 0.005574490234697832 > ./result_10chains/node329_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_6_2 -p 734 -st topic329_6_1 -pt None -u 0.03947161403136901 > ./result_10chains/node329_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_7_2 -p 739 -st topic329_7_1 -pt None -u 0.03788210777059124 > ./result_10chains/node329_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_8_2 -p 747 -st topic329_8_1 -pt None -u 0.01640108542828808 > ./result_10chains/node329_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_9_2 -p 841 -st topic329_9_1 -pt None -u 0.046771375484766856 > ./result_10chains/node329_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_0_0 -p 171 -st none -pt topic329_0_0 -u 0.0012945047297300283 > ./result_10chains/node329_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_1_0 -p 278 -st none -pt topic329_1_0 -u 0.024213702466374054 > ./result_10chains/node329_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_2_0 -p 391 -st none -pt topic329_2_0 -u 0.004444966584634669 > ./result_10chains/node329_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_3_0 -p 478 -st none -pt topic329_3_0 -u 0.035215096181492656 > ./result_10chains/node329_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_4_0 -p 532 -st none -pt topic329_4_0 -u 0.002093971895587299 > ./result_10chains/node329_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_5_0 -p 559 -st none -pt topic329_5_0 -u 0.07372029316632994 > ./result_10chains/node329_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_6_0 -p 734 -st none -pt topic329_6_0 -u 0.008800141731854338 > ./result_10chains/node329_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_7_0 -p 739 -st none -pt topic329_7_0 -u 0.008641653358422041 > ./result_10chains/node329_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_8_0 -p 747 -st none -pt topic329_8_0 -u 0.007172285160532504 > ./result_10chains/node329_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_9_0 -p 841 -st none -pt topic329_9_0 -u 0.0052183995973084235 > ./result_10chains/node329_9_0.txt &
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
    "./result_10chains/node329_0_0.txt 90"
    "./result_10chains/node329_0_2.txt 90"
    "./result_10chains/node329_1_0.txt 89"
    "./result_10chains/node329_1_2.txt 89"
    "./result_10chains/node329_2_0.txt 88"
    "./result_10chains/node329_2_2.txt 88"
    "./result_10chains/node329_3_0.txt 87"
    "./result_10chains/node329_3_2.txt 87"
    "./result_10chains/node329_4_0.txt 86"
    "./result_10chains/node329_4_2.txt 86"
    "./result_10chains/node329_5_0.txt 85"
    "./result_10chains/node329_5_2.txt 85"
    "./result_10chains/node329_6_0.txt 84"
    "./result_10chains/node329_6_2.txt 84"
    "./result_10chains/node329_7_0.txt 83"
    "./result_10chains/node329_7_2.txt 83"
    "./result_10chains/node329_8_0.txt 82"
    "./result_10chains/node329_8_2.txt 82"
    "./result_10chains/node329_9_0.txt 81"
    "./result_10chains/node329_9_2.txt 81"
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
