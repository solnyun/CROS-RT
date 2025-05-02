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
ros2 run evaluation_3_randomdag uunifast_node -n node464_0_2 -p 30 -st topic464_0_1 -pt None -u 0.00987943702986177 > ./result_8chains/node464_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_1_2 -p 133 -st topic464_1_1 -pt None -u 0.008400992885556291 > ./result_8chains/node464_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_2_2 -p 376 -st topic464_2_1 -pt None -u 0.020564832797756283 > ./result_8chains/node464_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_3_2 -p 458 -st topic464_3_1 -pt None -u 0.00016175752706981683 > ./result_8chains/node464_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_4_2 -p 530 -st topic464_4_1 -pt None -u 0.04663655568863555 > ./result_8chains/node464_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_5_2 -p 567 -st topic464_5_1 -pt None -u 0.011344770431334944 > ./result_8chains/node464_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_6_2 -p 594 -st topic464_6_1 -pt None -u 0.007614007052193731 > ./result_8chains/node464_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_7_2 -p 978 -st topic464_7_1 -pt None -u 0.0033598801208895297 > ./result_8chains/node464_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_0_0 -p 30 -st none -pt topic464_0_0 -u 0.02506684296237316 > ./result_8chains/node464_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_1_0 -p 133 -st none -pt topic464_1_0 -u 0.07357088990632965 > ./result_8chains/node464_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_2_0 -p 376 -st none -pt topic464_2_0 -u 0.01130252898928552 > ./result_8chains/node464_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_3_0 -p 458 -st none -pt topic464_3_0 -u 0.06377135510489595 > ./result_8chains/node464_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_4_0 -p 530 -st none -pt topic464_4_0 -u 0.06657305747563205 > ./result_8chains/node464_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_5_0 -p 567 -st none -pt topic464_5_0 -u 0.0015206647800768136 > ./result_8chains/node464_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_6_0 -p 594 -st none -pt topic464_6_0 -u 0.026604814113147586 > ./result_8chains/node464_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_7_0 -p 978 -st none -pt topic464_7_0 -u 0.011713246241727005 > ./result_8chains/node464_7_0.txt &
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
    "./result_8chains/node464_0_0.txt 90"
    "./result_8chains/node464_0_2.txt 90"
    "./result_8chains/node464_1_0.txt 89"
    "./result_8chains/node464_1_2.txt 89"
    "./result_8chains/node464_2_0.txt 88"
    "./result_8chains/node464_2_2.txt 88"
    "./result_8chains/node464_3_0.txt 87"
    "./result_8chains/node464_3_2.txt 87"
    "./result_8chains/node464_4_0.txt 86"
    "./result_8chains/node464_4_2.txt 86"
    "./result_8chains/node464_5_0.txt 85"
    "./result_8chains/node464_5_2.txt 85"
    "./result_8chains/node464_6_0.txt 84"
    "./result_8chains/node464_6_2.txt 84"
    "./result_8chains/node464_7_0.txt 83"
    "./result_8chains/node464_7_2.txt 83"
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
