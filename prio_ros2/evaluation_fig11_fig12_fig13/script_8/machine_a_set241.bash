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
ros2 run evaluation_3_randomdag uunifast_node -n node241_0_2 -p 41 -st topic241_0_1 -pt None -u 0.03139564530660377 > ./result_8chains/node241_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_1_2 -p 241 -st topic241_1_1 -pt None -u 0.0031868053343847014 > ./result_8chains/node241_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_2_2 -p 261 -st topic241_2_1 -pt None -u 0.022182858944528205 > ./result_8chains/node241_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_3_2 -p 277 -st topic241_3_1 -pt None -u 0.04568282738552229 > ./result_8chains/node241_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_4_2 -p 346 -st topic241_4_1 -pt None -u 0.010886175424344863 > ./result_8chains/node241_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_5_2 -p 512 -st topic241_5_1 -pt None -u 0.002469758119731158 > ./result_8chains/node241_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_6_2 -p 558 -st topic241_6_1 -pt None -u 0.07039505078700392 > ./result_8chains/node241_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_7_2 -p 998 -st topic241_7_1 -pt None -u 0.00043097607265002626 > ./result_8chains/node241_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_0_0 -p 41 -st none -pt topic241_0_0 -u 0.043846406800513715 > ./result_8chains/node241_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_1_0 -p 241 -st none -pt topic241_1_0 -u 0.010618618916718559 > ./result_8chains/node241_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_2_0 -p 261 -st none -pt topic241_2_0 -u 0.05523489106888946 > ./result_8chains/node241_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_3_0 -p 277 -st none -pt topic241_3_0 -u 0.011902280048422476 > ./result_8chains/node241_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_4_0 -p 346 -st none -pt topic241_4_0 -u 0.016095295503632756 > ./result_8chains/node241_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_5_0 -p 512 -st none -pt topic241_5_0 -u 0.021893852134027225 > ./result_8chains/node241_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_6_0 -p 558 -st none -pt topic241_6_0 -u 0.021990341601026878 > ./result_8chains/node241_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_7_0 -p 998 -st none -pt topic241_7_0 -u 0.002916745138601278 > ./result_8chains/node241_7_0.txt &
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
    "./result_8chains/node241_0_0.txt 90"
    "./result_8chains/node241_0_2.txt 90"
    "./result_8chains/node241_1_0.txt 89"
    "./result_8chains/node241_1_2.txt 89"
    "./result_8chains/node241_2_0.txt 88"
    "./result_8chains/node241_2_2.txt 88"
    "./result_8chains/node241_3_0.txt 87"
    "./result_8chains/node241_3_2.txt 87"
    "./result_8chains/node241_4_0.txt 86"
    "./result_8chains/node241_4_2.txt 86"
    "./result_8chains/node241_5_0.txt 85"
    "./result_8chains/node241_5_2.txt 85"
    "./result_8chains/node241_6_0.txt 84"
    "./result_8chains/node241_6_2.txt 84"
    "./result_8chains/node241_7_0.txt 83"
    "./result_8chains/node241_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
