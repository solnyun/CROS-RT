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
ros2 run evaluation_3_randomdag uunifast_node -n node364_0_2 -p 164 -st topic364_0_1 -pt None -u 0.023828042297673213 > ./result_10chains/node364_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_1_2 -p 306 -st topic364_1_1 -pt None -u 0.015928566916617037 > ./result_10chains/node364_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_2_2 -p 343 -st topic364_2_1 -pt None -u 0.002984483759777057 > ./result_10chains/node364_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_3_2 -p 476 -st topic364_3_1 -pt None -u 0.01881760402988991 > ./result_10chains/node364_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_4_2 -p 481 -st topic364_4_1 -pt None -u 0.010938649903698805 > ./result_10chains/node364_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_5_2 -p 492 -st topic364_5_1 -pt None -u 0.038787855703473595 > ./result_10chains/node364_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_6_2 -p 690 -st topic364_6_1 -pt None -u 0.009398757959496629 > ./result_10chains/node364_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_7_2 -p 699 -st topic364_7_1 -pt None -u 0.01643863566198127 > ./result_10chains/node364_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_8_2 -p 717 -st topic364_8_1 -pt None -u 0.015622051306370219 > ./result_10chains/node364_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_9_2 -p 842 -st topic364_9_1 -pt None -u 0.002123562568913134 > ./result_10chains/node364_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_0_0 -p 164 -st none -pt topic364_0_0 -u 0.05095056011488869 > ./result_10chains/node364_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_1_0 -p 306 -st none -pt topic364_1_0 -u 0.0070282391566723335 > ./result_10chains/node364_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_2_0 -p 343 -st none -pt topic364_2_0 -u 0.0024165227723573213 > ./result_10chains/node364_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_3_0 -p 476 -st none -pt topic364_3_0 -u 0.00883402886432949 > ./result_10chains/node364_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_4_0 -p 481 -st none -pt topic364_4_0 -u 0.009041383660188695 > ./result_10chains/node364_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_5_0 -p 492 -st none -pt topic364_5_0 -u 0.005299095594831826 > ./result_10chains/node364_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_6_0 -p 690 -st none -pt topic364_6_0 -u 0.028648732270878025 > ./result_10chains/node364_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_7_0 -p 699 -st none -pt topic364_7_0 -u 0.015512543490048991 > ./result_10chains/node364_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_8_0 -p 717 -st none -pt topic364_8_0 -u 0.010092428645874972 > ./result_10chains/node364_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_9_0 -p 842 -st none -pt topic364_9_0 -u 0.030036684748445067 > ./result_10chains/node364_9_0.txt &
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
    "./result_10chains/node364_0_0.txt 90"
    "./result_10chains/node364_0_2.txt 90"
    "./result_10chains/node364_1_0.txt 89"
    "./result_10chains/node364_1_2.txt 89"
    "./result_10chains/node364_2_0.txt 88"
    "./result_10chains/node364_2_2.txt 88"
    "./result_10chains/node364_3_0.txt 87"
    "./result_10chains/node364_3_2.txt 87"
    "./result_10chains/node364_4_0.txt 86"
    "./result_10chains/node364_4_2.txt 86"
    "./result_10chains/node364_5_0.txt 85"
    "./result_10chains/node364_5_2.txt 85"
    "./result_10chains/node364_6_0.txt 84"
    "./result_10chains/node364_6_2.txt 84"
    "./result_10chains/node364_7_0.txt 83"
    "./result_10chains/node364_7_2.txt 83"
    "./result_10chains/node364_8_0.txt 82"
    "./result_10chains/node364_8_2.txt 82"
    "./result_10chains/node364_9_0.txt 81"
    "./result_10chains/node364_9_2.txt 81"
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
