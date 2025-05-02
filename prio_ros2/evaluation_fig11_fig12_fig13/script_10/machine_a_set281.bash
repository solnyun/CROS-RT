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
ros2 run evaluation_3_randomdag uunifast_node -n node281_0_2 -p 29 -st topic281_0_1 -pt None -u 0.009913733733941388 > ./result_10chains/node281_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_1_2 -p 82 -st topic281_1_1 -pt None -u 0.015143121503745471 > ./result_10chains/node281_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_2_2 -p 147 -st topic281_2_1 -pt None -u 0.011044648305123084 > ./result_10chains/node281_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_3_2 -p 233 -st topic281_3_1 -pt None -u 0.008955688899885739 > ./result_10chains/node281_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_4_2 -p 251 -st topic281_4_1 -pt None -u 0.06321229893191826 > ./result_10chains/node281_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_5_2 -p 448 -st topic281_5_1 -pt None -u 0.03125166469543836 > ./result_10chains/node281_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_6_2 -p 454 -st topic281_6_1 -pt None -u 0.029392952288731317 > ./result_10chains/node281_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_7_2 -p 585 -st topic281_7_1 -pt None -u 0.006978874424958606 > ./result_10chains/node281_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_8_2 -p 913 -st topic281_8_1 -pt None -u 0.006538529938339019 > ./result_10chains/node281_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_9_2 -p 927 -st topic281_9_1 -pt None -u 0.018269027894030804 > ./result_10chains/node281_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_0_0 -p 29 -st none -pt topic281_0_0 -u 0.009210156864467023 > ./result_10chains/node281_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_1_0 -p 82 -st none -pt topic281_1_0 -u 0.003767773245261896 > ./result_10chains/node281_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_2_0 -p 147 -st none -pt topic281_2_0 -u 0.02076713388925827 > ./result_10chains/node281_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_3_0 -p 233 -st none -pt topic281_3_0 -u 0.023874531799708 > ./result_10chains/node281_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_4_0 -p 251 -st none -pt topic281_4_0 -u 0.028431523004088854 > ./result_10chains/node281_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_5_0 -p 448 -st none -pt topic281_5_0 -u 0.01002668546817398 > ./result_10chains/node281_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_6_0 -p 454 -st none -pt topic281_6_0 -u 0.005288441260520693 > ./result_10chains/node281_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_7_0 -p 585 -st none -pt topic281_7_0 -u 0.024499447866502183 > ./result_10chains/node281_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_8_0 -p 913 -st none -pt topic281_8_0 -u 0.0012867681792140817 > ./result_10chains/node281_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_9_0 -p 927 -st none -pt topic281_9_0 -u 0.07191473921263908 > ./result_10chains/node281_9_0.txt &
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
    "./result_10chains/node281_0_0.txt 90"
    "./result_10chains/node281_0_2.txt 90"
    "./result_10chains/node281_1_0.txt 89"
    "./result_10chains/node281_1_2.txt 89"
    "./result_10chains/node281_2_0.txt 88"
    "./result_10chains/node281_2_2.txt 88"
    "./result_10chains/node281_3_0.txt 87"
    "./result_10chains/node281_3_2.txt 87"
    "./result_10chains/node281_4_0.txt 86"
    "./result_10chains/node281_4_2.txt 86"
    "./result_10chains/node281_5_0.txt 85"
    "./result_10chains/node281_5_2.txt 85"
    "./result_10chains/node281_6_0.txt 84"
    "./result_10chains/node281_6_2.txt 84"
    "./result_10chains/node281_7_0.txt 83"
    "./result_10chains/node281_7_2.txt 83"
    "./result_10chains/node281_8_0.txt 82"
    "./result_10chains/node281_8_2.txt 82"
    "./result_10chains/node281_9_0.txt 81"
    "./result_10chains/node281_9_2.txt 81"
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
