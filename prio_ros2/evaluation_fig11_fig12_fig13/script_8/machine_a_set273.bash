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
ros2 run evaluation_3_randomdag uunifast_node -n node273_0_2 -p 20 -st topic273_0_1 -pt None -u 0.009338950512327915 > ./result_8chains/node273_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_1_2 -p 22 -st topic273_1_1 -pt None -u 0.01658189740852145 > ./result_8chains/node273_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_2_2 -p 55 -st topic273_2_1 -pt None -u 5.11749496173719e-05 > ./result_8chains/node273_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_3_2 -p 127 -st topic273_3_1 -pt None -u 0.06083063163909763 > ./result_8chains/node273_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_4_2 -p 206 -st topic273_4_1 -pt None -u 0.010962563116281493 > ./result_8chains/node273_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_5_2 -p 397 -st topic273_5_1 -pt None -u 0.012600621720707111 > ./result_8chains/node273_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_6_2 -p 802 -st topic273_6_1 -pt None -u 0.004894704882535905 > ./result_8chains/node273_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_7_2 -p 808 -st topic273_7_1 -pt None -u 0.010133570879085962 > ./result_8chains/node273_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_0_0 -p 20 -st none -pt topic273_0_0 -u 0.012330286824571768 > ./result_8chains/node273_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_1_0 -p 22 -st none -pt topic273_1_0 -u 0.03545761511654305 > ./result_8chains/node273_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_2_0 -p 55 -st none -pt topic273_2_0 -u 0.012364126953299193 > ./result_8chains/node273_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_3_0 -p 127 -st none -pt topic273_3_0 -u 0.028883348994012126 > ./result_8chains/node273_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_4_0 -p 206 -st none -pt topic273_4_0 -u 0.004079613104915725 > ./result_8chains/node273_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_5_0 -p 397 -st none -pt topic273_5_0 -u 0.006935023191421585 > ./result_8chains/node273_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_6_0 -p 802 -st none -pt topic273_6_0 -u 0.012744009255881983 > ./result_8chains/node273_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_7_0 -p 808 -st none -pt topic273_7_0 -u 0.03569140176407798 > ./result_8chains/node273_7_0.txt &
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
    "./result_8chains/node273_0_0.txt 90"
    "./result_8chains/node273_0_2.txt 90"
    "./result_8chains/node273_1_0.txt 89"
    "./result_8chains/node273_1_2.txt 89"
    "./result_8chains/node273_2_0.txt 88"
    "./result_8chains/node273_2_2.txt 88"
    "./result_8chains/node273_3_0.txt 87"
    "./result_8chains/node273_3_2.txt 87"
    "./result_8chains/node273_4_0.txt 86"
    "./result_8chains/node273_4_2.txt 86"
    "./result_8chains/node273_5_0.txt 85"
    "./result_8chains/node273_5_2.txt 85"
    "./result_8chains/node273_6_0.txt 84"
    "./result_8chains/node273_6_2.txt 84"
    "./result_8chains/node273_7_0.txt 83"
    "./result_8chains/node273_7_2.txt 83"
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
