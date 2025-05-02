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
ros2 run evaluation_3_randomdag uunifast_node -n node62_0_2 -p 14 -st topic62_0_1 -pt None -u 0.002874737132547156 > ./result_8chains/node62_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_1_2 -p 117 -st topic62_1_1 -pt None -u 0.020382090793483465 > ./result_8chains/node62_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_2_2 -p 242 -st topic62_2_1 -pt None -u 0.009126569048210964 > ./result_8chains/node62_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_3_2 -p 426 -st topic62_3_1 -pt None -u 0.002353934429189908 > ./result_8chains/node62_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_4_2 -p 494 -st topic62_4_1 -pt None -u 0.03252814090298567 > ./result_8chains/node62_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_5_2 -p 561 -st topic62_5_1 -pt None -u 0.010163719117451953 > ./result_8chains/node62_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_6_2 -p 643 -st topic62_6_1 -pt None -u 0.06152810141035109 > ./result_8chains/node62_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_7_2 -p 855 -st topic62_7_1 -pt None -u 0.004192976989710559 > ./result_8chains/node62_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_0_0 -p 14 -st none -pt topic62_0_0 -u 0.01602700429020959 > ./result_8chains/node62_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_1_0 -p 117 -st none -pt topic62_1_0 -u 0.0021745268648294402 > ./result_8chains/node62_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_2_0 -p 242 -st none -pt topic62_2_0 -u 0.0015850649413256535 > ./result_8chains/node62_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_3_0 -p 426 -st none -pt topic62_3_0 -u 0.01605851572346756 > ./result_8chains/node62_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_4_0 -p 494 -st none -pt topic62_4_0 -u 0.03151732113220124 > ./result_8chains/node62_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_5_0 -p 561 -st none -pt topic62_5_0 -u 0.025155065060253973 > ./result_8chains/node62_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_6_0 -p 643 -st none -pt topic62_6_0 -u 0.008360407305417844 > ./result_8chains/node62_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_7_0 -p 855 -st none -pt topic62_7_0 -u 0.055419124851817575 > ./result_8chains/node62_7_0.txt &
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
    "./result_8chains/node62_0_0.txt 90"
    "./result_8chains/node62_0_2.txt 90"
    "./result_8chains/node62_1_0.txt 89"
    "./result_8chains/node62_1_2.txt 89"
    "./result_8chains/node62_2_0.txt 88"
    "./result_8chains/node62_2_2.txt 88"
    "./result_8chains/node62_3_0.txt 87"
    "./result_8chains/node62_3_2.txt 87"
    "./result_8chains/node62_4_0.txt 86"
    "./result_8chains/node62_4_2.txt 86"
    "./result_8chains/node62_5_0.txt 85"
    "./result_8chains/node62_5_2.txt 85"
    "./result_8chains/node62_6_0.txt 84"
    "./result_8chains/node62_6_2.txt 84"
    "./result_8chains/node62_7_0.txt 83"
    "./result_8chains/node62_7_2.txt 83"
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
