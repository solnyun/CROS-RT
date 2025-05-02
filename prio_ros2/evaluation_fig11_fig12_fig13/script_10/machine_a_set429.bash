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
ros2 run evaluation_3_randomdag uunifast_node -n node429_0_2 -p 101 -st topic429_0_1 -pt None -u 0.07613982741106884 > ./result_10chains/node429_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_1_2 -p 231 -st topic429_1_1 -pt None -u 0.041897569998341155 > ./result_10chains/node429_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_2_2 -p 278 -st topic429_2_1 -pt None -u 0.011379463090523068 > ./result_10chains/node429_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_3_2 -p 280 -st topic429_3_1 -pt None -u 0.042713445626851726 > ./result_10chains/node429_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_4_2 -p 423 -st topic429_4_1 -pt None -u 0.0029691706443213117 > ./result_10chains/node429_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_5_2 -p 528 -st topic429_5_1 -pt None -u 0.0446326302183265 > ./result_10chains/node429_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_6_2 -p 561 -st topic429_6_1 -pt None -u 0.006804002177401791 > ./result_10chains/node429_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_7_2 -p 837 -st topic429_7_1 -pt None -u 0.01656089625988781 > ./result_10chains/node429_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_8_2 -p 912 -st topic429_8_1 -pt None -u 0.013097379774610493 > ./result_10chains/node429_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_9_2 -p 928 -st topic429_9_1 -pt None -u 0.010070044186119346 > ./result_10chains/node429_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_0_0 -p 101 -st none -pt topic429_0_0 -u 0.026804790797154032 > ./result_10chains/node429_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_1_0 -p 231 -st none -pt topic429_1_0 -u 0.015259922696253536 > ./result_10chains/node429_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_2_0 -p 278 -st none -pt topic429_2_0 -u 0.0003029712022183939 > ./result_10chains/node429_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_3_0 -p 280 -st none -pt topic429_3_0 -u 0.00026860618411628234 > ./result_10chains/node429_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_4_0 -p 423 -st none -pt topic429_4_0 -u 0.004487904528618247 > ./result_10chains/node429_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_5_0 -p 528 -st none -pt topic429_5_0 -u 0.026024485516049523 > ./result_10chains/node429_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_6_0 -p 561 -st none -pt topic429_6_0 -u 0.029080030136323487 > ./result_10chains/node429_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_7_0 -p 837 -st none -pt topic429_7_0 -u 0.0012659608588059257 > ./result_10chains/node429_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_8_0 -p 912 -st none -pt topic429_8_0 -u 0.014965874659432783 > ./result_10chains/node429_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node429_9_0 -p 928 -st none -pt topic429_9_0 -u 0.005784799671503263 > ./result_10chains/node429_9_0.txt &
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
    "./result_10chains/node429_0_0.txt 90"
    "./result_10chains/node429_0_2.txt 90"
    "./result_10chains/node429_1_0.txt 89"
    "./result_10chains/node429_1_2.txt 89"
    "./result_10chains/node429_2_0.txt 88"
    "./result_10chains/node429_2_2.txt 88"
    "./result_10chains/node429_3_0.txt 87"
    "./result_10chains/node429_3_2.txt 87"
    "./result_10chains/node429_4_0.txt 86"
    "./result_10chains/node429_4_2.txt 86"
    "./result_10chains/node429_5_0.txt 85"
    "./result_10chains/node429_5_2.txt 85"
    "./result_10chains/node429_6_0.txt 84"
    "./result_10chains/node429_6_2.txt 84"
    "./result_10chains/node429_7_0.txt 83"
    "./result_10chains/node429_7_2.txt 83"
    "./result_10chains/node429_8_0.txt 82"
    "./result_10chains/node429_8_2.txt 82"
    "./result_10chains/node429_9_0.txt 81"
    "./result_10chains/node429_9_2.txt 81"
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
