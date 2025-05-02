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
ros2 run evaluation_3_randomdag uunifast_node -n node231_0_2 -p 10 -st topic231_0_1 -pt None -u 0.006100499453243202 > ./result_8chains/node231_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_1_2 -p 38 -st topic231_1_1 -pt None -u 0.021612663814336575 > ./result_8chains/node231_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_2_2 -p 126 -st topic231_2_1 -pt None -u 0.03499125098889544 > ./result_8chains/node231_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_3_2 -p 127 -st topic231_3_1 -pt None -u 0.010930778496158533 > ./result_8chains/node231_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_4_2 -p 262 -st topic231_4_1 -pt None -u 0.003795533540170676 > ./result_8chains/node231_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_5_2 -p 280 -st topic231_5_1 -pt None -u 0.022234922430526993 > ./result_8chains/node231_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_6_2 -p 345 -st topic231_6_1 -pt None -u 0.007911458583414924 > ./result_8chains/node231_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_7_2 -p 502 -st topic231_7_1 -pt None -u 0.008891950205039911 > ./result_8chains/node231_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_0_0 -p 10 -st none -pt topic231_0_0 -u 0.002444451771478451 > ./result_8chains/node231_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_1_0 -p 38 -st none -pt topic231_1_0 -u 0.017752494203384817 > ./result_8chains/node231_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_2_0 -p 126 -st none -pt topic231_2_0 -u 0.10026571644617899 > ./result_8chains/node231_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_3_0 -p 127 -st none -pt topic231_3_0 -u 0.03493280337173482 > ./result_8chains/node231_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_4_0 -p 262 -st none -pt topic231_4_0 -u 0.0076082380230149405 > ./result_8chains/node231_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_5_0 -p 280 -st none -pt topic231_5_0 -u 0.0478153499199474 > ./result_8chains/node231_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_6_0 -p 345 -st none -pt topic231_6_0 -u 0.03685556891508323 > ./result_8chains/node231_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_7_0 -p 502 -st none -pt topic231_7_0 -u 0.005584367781798404 > ./result_8chains/node231_7_0.txt &
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
    "./result_8chains/node231_0_0.txt 90"
    "./result_8chains/node231_0_2.txt 90"
    "./result_8chains/node231_1_0.txt 89"
    "./result_8chains/node231_1_2.txt 89"
    "./result_8chains/node231_2_0.txt 88"
    "./result_8chains/node231_2_2.txt 88"
    "./result_8chains/node231_3_0.txt 87"
    "./result_8chains/node231_3_2.txt 87"
    "./result_8chains/node231_4_0.txt 86"
    "./result_8chains/node231_4_2.txt 86"
    "./result_8chains/node231_5_0.txt 85"
    "./result_8chains/node231_5_2.txt 85"
    "./result_8chains/node231_6_0.txt 84"
    "./result_8chains/node231_6_2.txt 84"
    "./result_8chains/node231_7_0.txt 83"
    "./result_8chains/node231_7_2.txt 83"
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
