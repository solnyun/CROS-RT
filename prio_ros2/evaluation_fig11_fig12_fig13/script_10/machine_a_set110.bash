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
ros2 run evaluation_3_randomdag uunifast_node -n node110_0_2 -p 16 -st topic110_0_1 -pt None -u 0.004977758112154229 > ./result_10chains/node110_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_1_2 -p 126 -st topic110_1_1 -pt None -u 0.011684030160281134 > ./result_10chains/node110_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_2_2 -p 208 -st topic110_2_1 -pt None -u 0.012146718864581074 > ./result_10chains/node110_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_3_2 -p 351 -st topic110_3_1 -pt None -u 0.01071410133414008 > ./result_10chains/node110_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_4_2 -p 509 -st topic110_4_1 -pt None -u 0.03380421454676458 > ./result_10chains/node110_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_5_2 -p 540 -st topic110_5_1 -pt None -u 0.00827938940092074 > ./result_10chains/node110_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_6_2 -p 593 -st topic110_6_1 -pt None -u 0.009347091456192141 > ./result_10chains/node110_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_7_2 -p 617 -st topic110_7_1 -pt None -u 0.02757268951513392 > ./result_10chains/node110_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_8_2 -p 701 -st topic110_8_1 -pt None -u 0.013770351085777136 > ./result_10chains/node110_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_9_2 -p 797 -st topic110_9_1 -pt None -u 0.023796196313633007 > ./result_10chains/node110_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_0_0 -p 16 -st none -pt topic110_0_0 -u 0.018883193421432243 > ./result_10chains/node110_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_1_0 -p 126 -st none -pt topic110_1_0 -u 0.01956522783650233 > ./result_10chains/node110_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_2_0 -p 208 -st none -pt topic110_2_0 -u 0.010725895254228013 > ./result_10chains/node110_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_3_0 -p 351 -st none -pt topic110_3_0 -u 0.042758492026455264 > ./result_10chains/node110_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_4_0 -p 509 -st none -pt topic110_4_0 -u 0.01008248812863427 > ./result_10chains/node110_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_5_0 -p 540 -st none -pt topic110_5_0 -u 0.002568561784255241 > ./result_10chains/node110_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_6_0 -p 593 -st none -pt topic110_6_0 -u 0.041736825916161374 > ./result_10chains/node110_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_7_0 -p 617 -st none -pt topic110_7_0 -u 0.03391938393337082 > ./result_10chains/node110_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_8_0 -p 701 -st none -pt topic110_8_0 -u 0.0074010594371708704 > ./result_10chains/node110_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_9_0 -p 797 -st none -pt topic110_9_0 -u 0.03637440881904097 > ./result_10chains/node110_9_0.txt &
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
    "./result_10chains/node110_0_0.txt 90"
    "./result_10chains/node110_0_2.txt 90"
    "./result_10chains/node110_1_0.txt 89"
    "./result_10chains/node110_1_2.txt 89"
    "./result_10chains/node110_2_0.txt 88"
    "./result_10chains/node110_2_2.txt 88"
    "./result_10chains/node110_3_0.txt 87"
    "./result_10chains/node110_3_2.txt 87"
    "./result_10chains/node110_4_0.txt 86"
    "./result_10chains/node110_4_2.txt 86"
    "./result_10chains/node110_5_0.txt 85"
    "./result_10chains/node110_5_2.txt 85"
    "./result_10chains/node110_6_0.txt 84"
    "./result_10chains/node110_6_2.txt 84"
    "./result_10chains/node110_7_0.txt 83"
    "./result_10chains/node110_7_2.txt 83"
    "./result_10chains/node110_8_0.txt 82"
    "./result_10chains/node110_8_2.txt 82"
    "./result_10chains/node110_9_0.txt 81"
    "./result_10chains/node110_9_2.txt 81"
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
