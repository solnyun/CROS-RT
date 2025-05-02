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
ros2 run evaluation_3_randomdag uunifast_node -n node187_0_2 -p 68 -st topic187_0_1 -pt None -u 0.009595485397353942 > ./result_10chains/node187_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_1_2 -p 95 -st topic187_1_1 -pt None -u 0.015608971150242124 > ./result_10chains/node187_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_2_2 -p 112 -st topic187_2_1 -pt None -u 0.050049932942742015 > ./result_10chains/node187_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_3_2 -p 155 -st topic187_3_1 -pt None -u 0.04378424836246669 > ./result_10chains/node187_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_4_2 -p 349 -st topic187_4_1 -pt None -u 0.0725482615350807 > ./result_10chains/node187_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_5_2 -p 509 -st topic187_5_1 -pt None -u 0.031752966373506844 > ./result_10chains/node187_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_6_2 -p 551 -st topic187_6_1 -pt None -u 0.005043174011377827 > ./result_10chains/node187_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_7_2 -p 703 -st topic187_7_1 -pt None -u 0.009648917023143064 > ./result_10chains/node187_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_8_2 -p 711 -st topic187_8_1 -pt None -u 0.015370145747553306 > ./result_10chains/node187_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_9_2 -p 777 -st topic187_9_1 -pt None -u 0.024815167499161076 > ./result_10chains/node187_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_0_0 -p 68 -st none -pt topic187_0_0 -u 0.00883889528038323 > ./result_10chains/node187_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_1_0 -p 95 -st none -pt topic187_1_0 -u 0.00064959054199204 > ./result_10chains/node187_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_2_0 -p 112 -st none -pt topic187_2_0 -u 0.007006754306106311 > ./result_10chains/node187_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_3_0 -p 155 -st none -pt topic187_3_0 -u 0.022617051626939222 > ./result_10chains/node187_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_4_0 -p 349 -st none -pt topic187_4_0 -u 0.005490102910585104 > ./result_10chains/node187_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_5_0 -p 509 -st none -pt topic187_5_0 -u 0.011940582286124934 > ./result_10chains/node187_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_6_0 -p 551 -st none -pt topic187_6_0 -u 0.010257183772293538 > ./result_10chains/node187_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_7_0 -p 703 -st none -pt topic187_7_0 -u 0.0041854447275267714 > ./result_10chains/node187_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_8_0 -p 711 -st none -pt topic187_8_0 -u 0.009406684479961964 > ./result_10chains/node187_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_9_0 -p 777 -st none -pt topic187_9_0 -u 0.0059269284594778635 > ./result_10chains/node187_9_0.txt &
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
    "./result_10chains/node187_0_0.txt 90"
    "./result_10chains/node187_0_2.txt 90"
    "./result_10chains/node187_1_0.txt 89"
    "./result_10chains/node187_1_2.txt 89"
    "./result_10chains/node187_2_0.txt 88"
    "./result_10chains/node187_2_2.txt 88"
    "./result_10chains/node187_3_0.txt 87"
    "./result_10chains/node187_3_2.txt 87"
    "./result_10chains/node187_4_0.txt 86"
    "./result_10chains/node187_4_2.txt 86"
    "./result_10chains/node187_5_0.txt 85"
    "./result_10chains/node187_5_2.txt 85"
    "./result_10chains/node187_6_0.txt 84"
    "./result_10chains/node187_6_2.txt 84"
    "./result_10chains/node187_7_0.txt 83"
    "./result_10chains/node187_7_2.txt 83"
    "./result_10chains/node187_8_0.txt 82"
    "./result_10chains/node187_8_2.txt 82"
    "./result_10chains/node187_9_0.txt 81"
    "./result_10chains/node187_9_2.txt 81"
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
