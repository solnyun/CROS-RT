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
ros2 run evaluation_3_randomdag uunifast_node -n node430_0_2 -p 79 -st topic430_0_1 -pt None -u 0.0006492267622952297 > ./result_10chains/node430_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_1_2 -p 285 -st topic430_1_1 -pt None -u 0.005682541345714609 > ./result_10chains/node430_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_2_2 -p 387 -st topic430_2_1 -pt None -u 0.00019249285374495217 > ./result_10chains/node430_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_3_2 -p 559 -st topic430_3_1 -pt None -u 0.05189173230353117 > ./result_10chains/node430_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_4_2 -p 598 -st topic430_4_1 -pt None -u 0.018014386332739996 > ./result_10chains/node430_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_5_2 -p 624 -st topic430_5_1 -pt None -u 0.009560617822268552 > ./result_10chains/node430_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_6_2 -p 637 -st topic430_6_1 -pt None -u 0.0033071529969501967 > ./result_10chains/node430_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_7_2 -p 712 -st topic430_7_1 -pt None -u 0.023631214888727464 > ./result_10chains/node430_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_8_2 -p 855 -st topic430_8_1 -pt None -u 0.021079618023928416 > ./result_10chains/node430_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_9_2 -p 873 -st topic430_9_1 -pt None -u 0.014129651775502485 > ./result_10chains/node430_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_0_0 -p 79 -st none -pt topic430_0_0 -u 0.006515486711413998 > ./result_10chains/node430_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_1_0 -p 285 -st none -pt topic430_1_0 -u 0.00675314548520628 > ./result_10chains/node430_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_2_0 -p 387 -st none -pt topic430_2_0 -u 0.044493833846712905 > ./result_10chains/node430_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_3_0 -p 559 -st none -pt topic430_3_0 -u 0.007002768709693019 > ./result_10chains/node430_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_4_0 -p 598 -st none -pt topic430_4_0 -u 0.011089384029428384 > ./result_10chains/node430_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_5_0 -p 624 -st none -pt topic430_5_0 -u 0.1034972823845545 > ./result_10chains/node430_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_6_0 -p 637 -st none -pt topic430_6_0 -u 0.0007593794446978941 > ./result_10chains/node430_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_7_0 -p 712 -st none -pt topic430_7_0 -u 0.022448701640529617 > ./result_10chains/node430_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_8_0 -p 855 -st none -pt topic430_8_0 -u 0.014248944417580858 > ./result_10chains/node430_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_9_0 -p 873 -st none -pt topic430_9_0 -u 0.007752831276061613 > ./result_10chains/node430_9_0.txt &
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
    "./result_10chains/node430_0_0.txt 90"
    "./result_10chains/node430_0_2.txt 90"
    "./result_10chains/node430_1_0.txt 89"
    "./result_10chains/node430_1_2.txt 89"
    "./result_10chains/node430_2_0.txt 88"
    "./result_10chains/node430_2_2.txt 88"
    "./result_10chains/node430_3_0.txt 87"
    "./result_10chains/node430_3_2.txt 87"
    "./result_10chains/node430_4_0.txt 86"
    "./result_10chains/node430_4_2.txt 86"
    "./result_10chains/node430_5_0.txt 85"
    "./result_10chains/node430_5_2.txt 85"
    "./result_10chains/node430_6_0.txt 84"
    "./result_10chains/node430_6_2.txt 84"
    "./result_10chains/node430_7_0.txt 83"
    "./result_10chains/node430_7_2.txt 83"
    "./result_10chains/node430_8_0.txt 82"
    "./result_10chains/node430_8_2.txt 82"
    "./result_10chains/node430_9_0.txt 81"
    "./result_10chains/node430_9_2.txt 81"
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
