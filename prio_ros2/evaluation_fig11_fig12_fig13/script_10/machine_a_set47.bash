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
ros2 run evaluation_3_randomdag uunifast_node -n node47_0_2 -p 45 -st topic47_0_1 -pt None -u 0.02830820839899062 > ./result_10chains/node47_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node47_1_2 -p 121 -st topic47_1_1 -pt None -u 0.009771927396712288 > ./result_10chains/node47_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node47_2_2 -p 136 -st topic47_2_1 -pt None -u 0.020747004413776582 > ./result_10chains/node47_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node47_3_2 -p 272 -st topic47_3_1 -pt None -u 0.03728469851388805 > ./result_10chains/node47_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node47_4_2 -p 352 -st topic47_4_1 -pt None -u 0.013640710309585247 > ./result_10chains/node47_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node47_5_2 -p 751 -st topic47_5_1 -pt None -u 0.01333533702034767 > ./result_10chains/node47_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node47_6_2 -p 779 -st topic47_6_1 -pt None -u 0.011323630439204008 > ./result_10chains/node47_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node47_7_2 -p 916 -st topic47_7_1 -pt None -u 0.0010858883619197235 > ./result_10chains/node47_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node47_8_2 -p 962 -st topic47_8_1 -pt None -u 0.015377545687802766 > ./result_10chains/node47_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node47_9_2 -p 970 -st topic47_9_1 -pt None -u 0.007681998542498409 > ./result_10chains/node47_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node47_0_0 -p 45 -st none -pt topic47_0_0 -u 0.01140333452357506 > ./result_10chains/node47_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node47_1_0 -p 121 -st none -pt topic47_1_0 -u 0.0027940078391360257 > ./result_10chains/node47_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node47_2_0 -p 136 -st none -pt topic47_2_0 -u 0.01695929267748747 > ./result_10chains/node47_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node47_3_0 -p 272 -st none -pt topic47_3_0 -u 0.05252161327589305 > ./result_10chains/node47_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node47_4_0 -p 352 -st none -pt topic47_4_0 -u 0.017777974302800315 > ./result_10chains/node47_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node47_5_0 -p 751 -st none -pt topic47_5_0 -u 0.0011449521742955826 > ./result_10chains/node47_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node47_6_0 -p 779 -st none -pt topic47_6_0 -u 0.00816979710780441 > ./result_10chains/node47_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node47_7_0 -p 916 -st none -pt topic47_7_0 -u 0.011283239256176011 > ./result_10chains/node47_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node47_8_0 -p 962 -st none -pt topic47_8_0 -u 0.012440001531517184 > ./result_10chains/node47_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node47_9_0 -p 970 -st none -pt topic47_9_0 -u 0.011731224410605666 > ./result_10chains/node47_9_0.txt &
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
    "./result_10chains/node47_0_0.txt 90"
    "./result_10chains/node47_0_2.txt 90"
    "./result_10chains/node47_1_0.txt 89"
    "./result_10chains/node47_1_2.txt 89"
    "./result_10chains/node47_2_0.txt 88"
    "./result_10chains/node47_2_2.txt 88"
    "./result_10chains/node47_3_0.txt 87"
    "./result_10chains/node47_3_2.txt 87"
    "./result_10chains/node47_4_0.txt 86"
    "./result_10chains/node47_4_2.txt 86"
    "./result_10chains/node47_5_0.txt 85"
    "./result_10chains/node47_5_2.txt 85"
    "./result_10chains/node47_6_0.txt 84"
    "./result_10chains/node47_6_2.txt 84"
    "./result_10chains/node47_7_0.txt 83"
    "./result_10chains/node47_7_2.txt 83"
    "./result_10chains/node47_8_0.txt 82"
    "./result_10chains/node47_8_2.txt 82"
    "./result_10chains/node47_9_0.txt 81"
    "./result_10chains/node47_9_2.txt 81"
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
