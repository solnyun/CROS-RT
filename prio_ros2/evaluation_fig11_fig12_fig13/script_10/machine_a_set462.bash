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
ros2 run evaluation_3_randomdag uunifast_node -n node462_0_2 -p 31 -st topic462_0_1 -pt None -u 0.007533312973575457 > ./result_10chains/node462_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_1_2 -p 44 -st topic462_1_1 -pt None -u 0.040519069442516154 > ./result_10chains/node462_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_2_2 -p 51 -st topic462_2_1 -pt None -u 0.005850679986974083 > ./result_10chains/node462_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_3_2 -p 180 -st topic462_3_1 -pt None -u 0.014551137921358703 > ./result_10chains/node462_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_4_2 -p 562 -st topic462_4_1 -pt None -u 0.021418252732308907 > ./result_10chains/node462_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_5_2 -p 576 -st topic462_5_1 -pt None -u 0.030672066620382715 > ./result_10chains/node462_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_6_2 -p 605 -st topic462_6_1 -pt None -u 0.005851819419978477 > ./result_10chains/node462_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_7_2 -p 750 -st topic462_7_1 -pt None -u 0.04784334093573389 > ./result_10chains/node462_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_8_2 -p 860 -st topic462_8_1 -pt None -u 0.016330664795988672 > ./result_10chains/node462_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_9_2 -p 981 -st topic462_9_1 -pt None -u 0.0036167399990833064 > ./result_10chains/node462_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_0_0 -p 31 -st none -pt topic462_0_0 -u 0.0035926430392775877 > ./result_10chains/node462_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_1_0 -p 44 -st none -pt topic462_1_0 -u 0.026986684459698984 > ./result_10chains/node462_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_2_0 -p 51 -st none -pt topic462_2_0 -u 0.016065342672640925 > ./result_10chains/node462_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_3_0 -p 180 -st none -pt topic462_3_0 -u 0.010293358549641363 > ./result_10chains/node462_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_4_0 -p 562 -st none -pt topic462_4_0 -u 0.011111389133132699 > ./result_10chains/node462_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_5_0 -p 576 -st none -pt topic462_5_0 -u 0.018894466934135656 > ./result_10chains/node462_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_6_0 -p 605 -st none -pt topic462_6_0 -u 0.005959234851952572 > ./result_10chains/node462_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_7_0 -p 750 -st none -pt topic462_7_0 -u 0.02641261127020539 > ./result_10chains/node462_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_8_0 -p 860 -st none -pt topic462_8_0 -u 0.03624666960426872 > ./result_10chains/node462_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_9_0 -p 981 -st none -pt topic462_9_0 -u 0.004162195305627843 > ./result_10chains/node462_9_0.txt &
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
    "./result_10chains/node462_0_0.txt 90"
    "./result_10chains/node462_0_2.txt 90"
    "./result_10chains/node462_1_0.txt 89"
    "./result_10chains/node462_1_2.txt 89"
    "./result_10chains/node462_2_0.txt 88"
    "./result_10chains/node462_2_2.txt 88"
    "./result_10chains/node462_3_0.txt 87"
    "./result_10chains/node462_3_2.txt 87"
    "./result_10chains/node462_4_0.txt 86"
    "./result_10chains/node462_4_2.txt 86"
    "./result_10chains/node462_5_0.txt 85"
    "./result_10chains/node462_5_2.txt 85"
    "./result_10chains/node462_6_0.txt 84"
    "./result_10chains/node462_6_2.txt 84"
    "./result_10chains/node462_7_0.txt 83"
    "./result_10chains/node462_7_2.txt 83"
    "./result_10chains/node462_8_0.txt 82"
    "./result_10chains/node462_8_2.txt 82"
    "./result_10chains/node462_9_0.txt 81"
    "./result_10chains/node462_9_2.txt 81"
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
