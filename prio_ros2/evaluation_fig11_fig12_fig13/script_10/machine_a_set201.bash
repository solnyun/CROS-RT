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
ros2 run evaluation_3_randomdag uunifast_node -n node201_0_2 -p 44 -st topic201_0_1 -pt None -u 0.021767956875342276 > ./result_10chains/node201_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_1_2 -p 217 -st topic201_1_1 -pt None -u 0.005791575031928509 > ./result_10chains/node201_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_2_2 -p 225 -st topic201_2_1 -pt None -u 0.011168784692134781 > ./result_10chains/node201_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_3_2 -p 240 -st topic201_3_1 -pt None -u 0.03995433825410266 > ./result_10chains/node201_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_4_2 -p 267 -st topic201_4_1 -pt None -u 0.03500033534768718 > ./result_10chains/node201_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_5_2 -p 490 -st topic201_5_1 -pt None -u 0.014963567168493314 > ./result_10chains/node201_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_6_2 -p 528 -st topic201_6_1 -pt None -u 0.004540410431753156 > ./result_10chains/node201_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_7_2 -p 739 -st topic201_7_1 -pt None -u 0.014692868433512252 > ./result_10chains/node201_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_8_2 -p 822 -st topic201_8_1 -pt None -u 0.04544172268415261 > ./result_10chains/node201_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_9_2 -p 900 -st topic201_9_1 -pt None -u 0.007397320883036939 > ./result_10chains/node201_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_0_0 -p 44 -st none -pt topic201_0_0 -u 0.023818346114992117 > ./result_10chains/node201_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_1_0 -p 217 -st none -pt topic201_1_0 -u 0.003230999130989509 > ./result_10chains/node201_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_2_0 -p 225 -st none -pt topic201_2_0 -u 0.03727184714064924 > ./result_10chains/node201_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_3_0 -p 240 -st none -pt topic201_3_0 -u 0.016792229119305335 > ./result_10chains/node201_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_4_0 -p 267 -st none -pt topic201_4_0 -u 0.031640166207029696 > ./result_10chains/node201_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_5_0 -p 490 -st none -pt topic201_5_0 -u 0.008130972652279578 > ./result_10chains/node201_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_6_0 -p 528 -st none -pt topic201_6_0 -u 0.005169540429598107 > ./result_10chains/node201_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_7_0 -p 739 -st none -pt topic201_7_0 -u 0.0019088492626790632 > ./result_10chains/node201_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_8_0 -p 822 -st none -pt topic201_8_0 -u 0.005712221981047108 > ./result_10chains/node201_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node201_9_0 -p 900 -st none -pt topic201_9_0 -u 0.028984573926993287 > ./result_10chains/node201_9_0.txt &
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
    "./result_10chains/node201_0_0.txt 90"
    "./result_10chains/node201_0_2.txt 90"
    "./result_10chains/node201_1_0.txt 89"
    "./result_10chains/node201_1_2.txt 89"
    "./result_10chains/node201_2_0.txt 88"
    "./result_10chains/node201_2_2.txt 88"
    "./result_10chains/node201_3_0.txt 87"
    "./result_10chains/node201_3_2.txt 87"
    "./result_10chains/node201_4_0.txt 86"
    "./result_10chains/node201_4_2.txt 86"
    "./result_10chains/node201_5_0.txt 85"
    "./result_10chains/node201_5_2.txt 85"
    "./result_10chains/node201_6_0.txt 84"
    "./result_10chains/node201_6_2.txt 84"
    "./result_10chains/node201_7_0.txt 83"
    "./result_10chains/node201_7_2.txt 83"
    "./result_10chains/node201_8_0.txt 82"
    "./result_10chains/node201_8_2.txt 82"
    "./result_10chains/node201_9_0.txt 81"
    "./result_10chains/node201_9_2.txt 81"
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
