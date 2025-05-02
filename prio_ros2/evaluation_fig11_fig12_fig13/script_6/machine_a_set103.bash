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
ros2 run evaluation_3_randomdag uunifast_node -n node103_0_2 -p 230 -st topic103_0_1 -pt None -u 0.010293140391201772 > ./result_6chains/node103_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_1_2 -p 353 -st topic103_1_1 -pt None -u 0.01164062500939439 > ./result_6chains/node103_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_2_2 -p 634 -st topic103_2_1 -pt None -u 0.015224120250715067 > ./result_6chains/node103_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_3_2 -p 638 -st topic103_3_1 -pt None -u 0.012914546365001472 > ./result_6chains/node103_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_4_2 -p 769 -st topic103_4_1 -pt None -u 0.0319543122433911 > ./result_6chains/node103_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_5_2 -p 990 -st topic103_5_1 -pt None -u 0.003607905795289482 > ./result_6chains/node103_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_0_0 -p 230 -st none -pt topic103_0_0 -u 0.020874705743891664 > ./result_6chains/node103_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_1_0 -p 353 -st none -pt topic103_1_0 -u 0.005815199798558157 > ./result_6chains/node103_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_2_0 -p 634 -st none -pt topic103_2_0 -u 0.09969577430041732 > ./result_6chains/node103_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_3_0 -p 638 -st none -pt topic103_3_0 -u 0.002898221580651228 > ./result_6chains/node103_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_4_0 -p 769 -st none -pt topic103_4_0 -u 0.06438843043717055 > ./result_6chains/node103_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_5_0 -p 990 -st none -pt topic103_5_0 -u 0.11504800742005754 > ./result_6chains/node103_5_0.txt &
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
    "./result_6chains/node103_0_0.txt 90"
    "./result_6chains/node103_0_2.txt 90"
    "./result_6chains/node103_1_0.txt 89"
    "./result_6chains/node103_1_2.txt 89"
    "./result_6chains/node103_2_0.txt 88"
    "./result_6chains/node103_2_2.txt 88"
    "./result_6chains/node103_3_0.txt 87"
    "./result_6chains/node103_3_2.txt 87"
    "./result_6chains/node103_4_0.txt 86"
    "./result_6chains/node103_4_2.txt 86"
    "./result_6chains/node103_5_0.txt 85"
    "./result_6chains/node103_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
