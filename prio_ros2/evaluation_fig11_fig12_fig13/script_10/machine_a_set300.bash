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
ros2 run evaluation_3_randomdag uunifast_node -n node300_0_2 -p 63 -st topic300_0_1 -pt None -u 0.016422806322776262 > ./result_10chains/node300_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_1_2 -p 120 -st topic300_1_1 -pt None -u 0.0018252789193750618 > ./result_10chains/node300_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_2_2 -p 135 -st topic300_2_1 -pt None -u 0.01062027067519239 > ./result_10chains/node300_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_3_2 -p 309 -st topic300_3_1 -pt None -u 0.011397386547284338 > ./result_10chains/node300_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_4_2 -p 466 -st topic300_4_1 -pt None -u 0.010577371400247004 > ./result_10chains/node300_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_5_2 -p 485 -st topic300_5_1 -pt None -u 0.016195724643095932 > ./result_10chains/node300_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_6_2 -p 657 -st topic300_6_1 -pt None -u 0.05299567701346164 > ./result_10chains/node300_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_7_2 -p 777 -st topic300_7_1 -pt None -u 0.035674663130788056 > ./result_10chains/node300_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_8_2 -p 907 -st topic300_8_1 -pt None -u 0.0015245681682851259 > ./result_10chains/node300_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_9_2 -p 977 -st topic300_9_1 -pt None -u 0.004433161163919685 > ./result_10chains/node300_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_0_0 -p 63 -st none -pt topic300_0_0 -u 0.007966185844059115 > ./result_10chains/node300_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_1_0 -p 120 -st none -pt topic300_1_0 -u 0.022278424699315125 > ./result_10chains/node300_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_2_0 -p 135 -st none -pt topic300_2_0 -u 0.05690502360809718 > ./result_10chains/node300_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_3_0 -p 309 -st none -pt topic300_3_0 -u 0.002286843639050351 > ./result_10chains/node300_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_4_0 -p 466 -st none -pt topic300_4_0 -u 0.02452208304343345 > ./result_10chains/node300_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_5_0 -p 485 -st none -pt topic300_5_0 -u 0.00867154277296106 > ./result_10chains/node300_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_6_0 -p 657 -st none -pt topic300_6_0 -u 0.015009947034128085 > ./result_10chains/node300_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_7_0 -p 777 -st none -pt topic300_7_0 -u 0.00939412031602982 > ./result_10chains/node300_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_8_0 -p 907 -st none -pt topic300_8_0 -u 0.022655333571681355 > ./result_10chains/node300_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_9_0 -p 977 -st none -pt topic300_9_0 -u 0.03264531167034948 > ./result_10chains/node300_9_0.txt &
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
    "./result_10chains/node300_0_0.txt 90"
    "./result_10chains/node300_0_2.txt 90"
    "./result_10chains/node300_1_0.txt 89"
    "./result_10chains/node300_1_2.txt 89"
    "./result_10chains/node300_2_0.txt 88"
    "./result_10chains/node300_2_2.txt 88"
    "./result_10chains/node300_3_0.txt 87"
    "./result_10chains/node300_3_2.txt 87"
    "./result_10chains/node300_4_0.txt 86"
    "./result_10chains/node300_4_2.txt 86"
    "./result_10chains/node300_5_0.txt 85"
    "./result_10chains/node300_5_2.txt 85"
    "./result_10chains/node300_6_0.txt 84"
    "./result_10chains/node300_6_2.txt 84"
    "./result_10chains/node300_7_0.txt 83"
    "./result_10chains/node300_7_2.txt 83"
    "./result_10chains/node300_8_0.txt 82"
    "./result_10chains/node300_8_2.txt 82"
    "./result_10chains/node300_9_0.txt 81"
    "./result_10chains/node300_9_2.txt 81"
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
