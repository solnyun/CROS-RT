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
ros2 run evaluation_3_randomdag uunifast_node -n node8_0_2 -p 11 -st topic8_0_1 -pt None -u 0.05915057684022418 > ./result_10chains/node8_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_1_2 -p 24 -st topic8_1_1 -pt None -u 0.007017657109671782 > ./result_10chains/node8_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_2_2 -p 59 -st topic8_2_1 -pt None -u 0.01611210151654796 > ./result_10chains/node8_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_3_2 -p 69 -st topic8_3_1 -pt None -u 0.0033681376809131525 > ./result_10chains/node8_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_4_2 -p 246 -st topic8_4_1 -pt None -u 0.01567152260038812 > ./result_10chains/node8_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_5_2 -p 372 -st topic8_5_1 -pt None -u 0.03720263215173214 > ./result_10chains/node8_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_6_2 -p 456 -st topic8_6_1 -pt None -u 0.003988978981583319 > ./result_10chains/node8_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_7_2 -p 516 -st topic8_7_1 -pt None -u 0.007803815558439876 > ./result_10chains/node8_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_8_2 -p 802 -st topic8_8_1 -pt None -u 0.0046892001962418745 > ./result_10chains/node8_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_9_2 -p 938 -st topic8_9_1 -pt None -u 0.00926549823696158 > ./result_10chains/node8_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_0_0 -p 11 -st none -pt topic8_0_0 -u 0.031461272946373686 > ./result_10chains/node8_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_1_0 -p 24 -st none -pt topic8_1_0 -u 0.023928625309511675 > ./result_10chains/node8_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_2_0 -p 59 -st none -pt topic8_2_0 -u 0.001154456789259739 > ./result_10chains/node8_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_3_0 -p 69 -st none -pt topic8_3_0 -u 0.002763175891282277 > ./result_10chains/node8_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_4_0 -p 246 -st none -pt topic8_4_0 -u 0.03451598624189542 > ./result_10chains/node8_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_5_0 -p 372 -st none -pt topic8_5_0 -u 0.04456506493524501 > ./result_10chains/node8_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_6_0 -p 456 -st none -pt topic8_6_0 -u 0.010112829914609586 > ./result_10chains/node8_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_7_0 -p 516 -st none -pt topic8_7_0 -u 0.005377787787017821 > ./result_10chains/node8_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_8_0 -p 802 -st none -pt topic8_8_0 -u 0.001090959537920537 > ./result_10chains/node8_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_9_0 -p 938 -st none -pt topic8_9_0 -u 0.00625594630255482 > ./result_10chains/node8_9_0.txt &
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
    "./result_10chains/node8_0_0.txt 90"
    "./result_10chains/node8_0_2.txt 90"
    "./result_10chains/node8_1_0.txt 89"
    "./result_10chains/node8_1_2.txt 89"
    "./result_10chains/node8_2_0.txt 88"
    "./result_10chains/node8_2_2.txt 88"
    "./result_10chains/node8_3_0.txt 87"
    "./result_10chains/node8_3_2.txt 87"
    "./result_10chains/node8_4_0.txt 86"
    "./result_10chains/node8_4_2.txt 86"
    "./result_10chains/node8_5_0.txt 85"
    "./result_10chains/node8_5_2.txt 85"
    "./result_10chains/node8_6_0.txt 84"
    "./result_10chains/node8_6_2.txt 84"
    "./result_10chains/node8_7_0.txt 83"
    "./result_10chains/node8_7_2.txt 83"
    "./result_10chains/node8_8_0.txt 82"
    "./result_10chains/node8_8_2.txt 82"
    "./result_10chains/node8_9_0.txt 81"
    "./result_10chains/node8_9_2.txt 81"
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
