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
ros2 run evaluation_3_randomdag uunifast_node -n node70_0_2 -p 96 -st topic70_0_1 -pt None -u 0.01946584032997717 > ./result_10chains/node70_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_1_2 -p 184 -st topic70_1_1 -pt None -u 0.010050625887977394 > ./result_10chains/node70_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_2_2 -p 407 -st topic70_2_1 -pt None -u 0.019582898527275072 > ./result_10chains/node70_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_3_2 -p 413 -st topic70_3_1 -pt None -u 0.028476299841052932 > ./result_10chains/node70_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_4_2 -p 446 -st topic70_4_1 -pt None -u 0.013929265345754671 > ./result_10chains/node70_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_5_2 -p 472 -st topic70_5_1 -pt None -u 0.019034895324916812 > ./result_10chains/node70_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_6_2 -p 513 -st topic70_6_1 -pt None -u 0.039718360307639894 > ./result_10chains/node70_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_7_2 -p 719 -st topic70_7_1 -pt None -u 0.04224792517286599 > ./result_10chains/node70_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_8_2 -p 858 -st topic70_8_1 -pt None -u 0.0024177566027079322 > ./result_10chains/node70_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_9_2 -p 966 -st topic70_9_1 -pt None -u 0.05216212775577548 > ./result_10chains/node70_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_0_0 -p 96 -st none -pt topic70_0_0 -u 0.008535895410858696 > ./result_10chains/node70_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_1_0 -p 184 -st none -pt topic70_1_0 -u 0.0011399830748858308 > ./result_10chains/node70_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_2_0 -p 407 -st none -pt topic70_2_0 -u 0.008756187480683575 > ./result_10chains/node70_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_3_0 -p 413 -st none -pt topic70_3_0 -u 0.011977998031071801 > ./result_10chains/node70_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_4_0 -p 446 -st none -pt topic70_4_0 -u 0.011513387636865602 > ./result_10chains/node70_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_5_0 -p 472 -st none -pt topic70_5_0 -u 0.006916168541785672 > ./result_10chains/node70_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_6_0 -p 513 -st none -pt topic70_6_0 -u 0.0004882727210041016 > ./result_10chains/node70_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_7_0 -p 719 -st none -pt topic70_7_0 -u 0.0034535341356102534 > ./result_10chains/node70_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_8_0 -p 858 -st none -pt topic70_8_0 -u 0.011029169279168888 > ./result_10chains/node70_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_9_0 -p 966 -st none -pt topic70_9_0 -u 0.017012553114505176 > ./result_10chains/node70_9_0.txt &
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
    "./result_10chains/node70_0_0.txt 90"
    "./result_10chains/node70_0_2.txt 90"
    "./result_10chains/node70_1_0.txt 89"
    "./result_10chains/node70_1_2.txt 89"
    "./result_10chains/node70_2_0.txt 88"
    "./result_10chains/node70_2_2.txt 88"
    "./result_10chains/node70_3_0.txt 87"
    "./result_10chains/node70_3_2.txt 87"
    "./result_10chains/node70_4_0.txt 86"
    "./result_10chains/node70_4_2.txt 86"
    "./result_10chains/node70_5_0.txt 85"
    "./result_10chains/node70_5_2.txt 85"
    "./result_10chains/node70_6_0.txt 84"
    "./result_10chains/node70_6_2.txt 84"
    "./result_10chains/node70_7_0.txt 83"
    "./result_10chains/node70_7_2.txt 83"
    "./result_10chains/node70_8_0.txt 82"
    "./result_10chains/node70_8_2.txt 82"
    "./result_10chains/node70_9_0.txt 81"
    "./result_10chains/node70_9_2.txt 81"
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
