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
ros2 run evaluation_3_randomdag uunifast_node -n node58_0_2 -p 96 -st topic58_0_1 -pt None -u 0.0022128980690264144 > ./result_10chains/node58_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_1_2 -p 376 -st topic58_1_1 -pt None -u 0.006283926161258335 > ./result_10chains/node58_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_2_2 -p 429 -st topic58_2_1 -pt None -u 0.014767981180369483 > ./result_10chains/node58_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_3_2 -p 458 -st topic58_3_1 -pt None -u 0.006586754459329186 > ./result_10chains/node58_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_4_2 -p 520 -st topic58_4_1 -pt None -u 0.010289788599900707 > ./result_10chains/node58_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_5_2 -p 639 -st topic58_5_1 -pt None -u 0.0004530711372034979 > ./result_10chains/node58_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_6_2 -p 803 -st topic58_6_1 -pt None -u 0.029447027428689376 > ./result_10chains/node58_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_7_2 -p 861 -st topic58_7_1 -pt None -u 0.010364140108368808 > ./result_10chains/node58_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_8_2 -p 909 -st topic58_8_1 -pt None -u 0.00023572948054755016 > ./result_10chains/node58_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_9_2 -p 956 -st topic58_9_1 -pt None -u 0.010939553492339778 > ./result_10chains/node58_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_0_0 -p 96 -st none -pt topic58_0_0 -u 0.0333379226437886 > ./result_10chains/node58_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_1_0 -p 376 -st none -pt topic58_1_0 -u 0.0166233672759713 > ./result_10chains/node58_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_2_0 -p 429 -st none -pt topic58_2_0 -u 0.0186156963761131 > ./result_10chains/node58_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_3_0 -p 458 -st none -pt topic58_3_0 -u 0.08228372657693356 > ./result_10chains/node58_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_4_0 -p 520 -st none -pt topic58_4_0 -u 0.0005188432052593561 > ./result_10chains/node58_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_5_0 -p 639 -st none -pt topic58_5_0 -u 0.015572352443022575 > ./result_10chains/node58_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_6_0 -p 803 -st none -pt topic58_6_0 -u 0.017484306816714396 > ./result_10chains/node58_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_7_0 -p 861 -st none -pt topic58_7_0 -u 0.010603426843429797 > ./result_10chains/node58_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_8_0 -p 909 -st none -pt topic58_8_0 -u 0.003717307056878394 > ./result_10chains/node58_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_9_0 -p 956 -st none -pt topic58_9_0 -u 0.0009467659879922596 > ./result_10chains/node58_9_0.txt &
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
    "./result_10chains/node58_0_0.txt 90"
    "./result_10chains/node58_0_2.txt 90"
    "./result_10chains/node58_1_0.txt 89"
    "./result_10chains/node58_1_2.txt 89"
    "./result_10chains/node58_2_0.txt 88"
    "./result_10chains/node58_2_2.txt 88"
    "./result_10chains/node58_3_0.txt 87"
    "./result_10chains/node58_3_2.txt 87"
    "./result_10chains/node58_4_0.txt 86"
    "./result_10chains/node58_4_2.txt 86"
    "./result_10chains/node58_5_0.txt 85"
    "./result_10chains/node58_5_2.txt 85"
    "./result_10chains/node58_6_0.txt 84"
    "./result_10chains/node58_6_2.txt 84"
    "./result_10chains/node58_7_0.txt 83"
    "./result_10chains/node58_7_2.txt 83"
    "./result_10chains/node58_8_0.txt 82"
    "./result_10chains/node58_8_2.txt 82"
    "./result_10chains/node58_9_0.txt 81"
    "./result_10chains/node58_9_2.txt 81"
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
