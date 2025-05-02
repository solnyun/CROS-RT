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
ros2 run evaluation_3_randomdag uunifast_node -n node372_0_2 -p 94 -st topic372_0_1 -pt None -u 0.013546618911300656 > ./result_10chains/node372_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_1_2 -p 165 -st topic372_1_1 -pt None -u 0.012155000697070817 > ./result_10chains/node372_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_2_2 -p 247 -st topic372_2_1 -pt None -u 0.020344557702635546 > ./result_10chains/node372_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_3_2 -p 419 -st topic372_3_1 -pt None -u 0.0085879191408324 > ./result_10chains/node372_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_4_2 -p 449 -st topic372_4_1 -pt None -u 0.0055818517349507935 > ./result_10chains/node372_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_5_2 -p 463 -st topic372_5_1 -pt None -u 0.023421106483802467 > ./result_10chains/node372_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_6_2 -p 696 -st topic372_6_1 -pt None -u 0.002771755785362179 > ./result_10chains/node372_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_7_2 -p 698 -st topic372_7_1 -pt None -u 0.008039336917820772 > ./result_10chains/node372_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_8_2 -p 719 -st topic372_8_1 -pt None -u 0.04194138562014188 > ./result_10chains/node372_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_9_2 -p 751 -st topic372_9_1 -pt None -u 0.017948897751808954 > ./result_10chains/node372_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_0_0 -p 94 -st none -pt topic372_0_0 -u 0.005197555351428518 > ./result_10chains/node372_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_1_0 -p 165 -st none -pt topic372_1_0 -u 0.002788162485117207 > ./result_10chains/node372_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_2_0 -p 247 -st none -pt topic372_2_0 -u 0.03986512958507693 > ./result_10chains/node372_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_3_0 -p 419 -st none -pt topic372_3_0 -u 0.028586540832591545 > ./result_10chains/node372_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_4_0 -p 449 -st none -pt topic372_4_0 -u 0.00540833089117565 > ./result_10chains/node372_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_5_0 -p 463 -st none -pt topic372_5_0 -u 0.028458012951054767 > ./result_10chains/node372_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_6_0 -p 696 -st none -pt topic372_6_0 -u 0.014909260378950046 > ./result_10chains/node372_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_7_0 -p 698 -st none -pt topic372_7_0 -u 0.0018871523489956687 > ./result_10chains/node372_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_8_0 -p 719 -st none -pt topic372_8_0 -u 0.0007192310896868004 > ./result_10chains/node372_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_9_0 -p 751 -st none -pt topic372_9_0 -u 0.05793825910353711 > ./result_10chains/node372_9_0.txt &
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
    "./result_10chains/node372_0_0.txt 90"
    "./result_10chains/node372_0_2.txt 90"
    "./result_10chains/node372_1_0.txt 89"
    "./result_10chains/node372_1_2.txt 89"
    "./result_10chains/node372_2_0.txt 88"
    "./result_10chains/node372_2_2.txt 88"
    "./result_10chains/node372_3_0.txt 87"
    "./result_10chains/node372_3_2.txt 87"
    "./result_10chains/node372_4_0.txt 86"
    "./result_10chains/node372_4_2.txt 86"
    "./result_10chains/node372_5_0.txt 85"
    "./result_10chains/node372_5_2.txt 85"
    "./result_10chains/node372_6_0.txt 84"
    "./result_10chains/node372_6_2.txt 84"
    "./result_10chains/node372_7_0.txt 83"
    "./result_10chains/node372_7_2.txt 83"
    "./result_10chains/node372_8_0.txt 82"
    "./result_10chains/node372_8_2.txt 82"
    "./result_10chains/node372_9_0.txt 81"
    "./result_10chains/node372_9_2.txt 81"
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
