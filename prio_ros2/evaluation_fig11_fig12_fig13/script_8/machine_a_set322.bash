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
ros2 run evaluation_3_randomdag uunifast_node -n node322_0_2 -p 178 -st topic322_0_1 -pt None -u 0.011174456670607957 > ./result_8chains/node322_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_1_2 -p 320 -st topic322_1_1 -pt None -u 0.0031059940311079504 > ./result_8chains/node322_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_2_2 -p 383 -st topic322_2_1 -pt None -u 0.019544222704813374 > ./result_8chains/node322_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_3_2 -p 577 -st topic322_3_1 -pt None -u 0.05216645972772227 > ./result_8chains/node322_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_4_2 -p 634 -st topic322_4_1 -pt None -u 0.03379873095964017 > ./result_8chains/node322_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_5_2 -p 666 -st topic322_5_1 -pt None -u 0.05048968155929161 > ./result_8chains/node322_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_6_2 -p 669 -st topic322_6_1 -pt None -u 0.01869121867651293 > ./result_8chains/node322_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_7_2 -p 957 -st topic322_7_1 -pt None -u 0.015362631855292404 > ./result_8chains/node322_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_0_0 -p 178 -st none -pt topic322_0_0 -u 0.0035958866698110326 > ./result_8chains/node322_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_1_0 -p 320 -st none -pt topic322_1_0 -u 0.009611452003010668 > ./result_8chains/node322_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_2_0 -p 383 -st none -pt topic322_2_0 -u 0.01638891237881046 > ./result_8chains/node322_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_3_0 -p 577 -st none -pt topic322_3_0 -u 0.0042537596481161954 > ./result_8chains/node322_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_4_0 -p 634 -st none -pt topic322_4_0 -u 0.05435427200008863 > ./result_8chains/node322_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_5_0 -p 666 -st none -pt topic322_5_0 -u 0.0703060257457454 > ./result_8chains/node322_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_6_0 -p 669 -st none -pt topic322_6_0 -u 0.026684153491076987 > ./result_8chains/node322_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_7_0 -p 957 -st none -pt topic322_7_0 -u 0.0008662234739449312 > ./result_8chains/node322_7_0.txt &
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
    "./result_8chains/node322_0_0.txt 90"
    "./result_8chains/node322_0_2.txt 90"
    "./result_8chains/node322_1_0.txt 89"
    "./result_8chains/node322_1_2.txt 89"
    "./result_8chains/node322_2_0.txt 88"
    "./result_8chains/node322_2_2.txt 88"
    "./result_8chains/node322_3_0.txt 87"
    "./result_8chains/node322_3_2.txt 87"
    "./result_8chains/node322_4_0.txt 86"
    "./result_8chains/node322_4_2.txt 86"
    "./result_8chains/node322_5_0.txt 85"
    "./result_8chains/node322_5_2.txt 85"
    "./result_8chains/node322_6_0.txt 84"
    "./result_8chains/node322_6_2.txt 84"
    "./result_8chains/node322_7_0.txt 83"
    "./result_8chains/node322_7_2.txt 83"
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
