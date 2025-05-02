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
ros2 run evaluation_3_randomdag uunifast_node -n node261_0_2 -p 32 -st topic261_0_1 -pt None -u 0.00493439218249514 > ./result_8chains/node261_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node261_1_2 -p 218 -st topic261_1_1 -pt None -u 0.11509276653124487 > ./result_8chains/node261_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_2_2 -p 323 -st topic261_2_1 -pt None -u 0.009257598708163672 > ./result_8chains/node261_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node261_3_2 -p 426 -st topic261_3_1 -pt None -u 0.014433178546181438 > ./result_8chains/node261_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_4_2 -p 599 -st topic261_4_1 -pt None -u 0.03802825422189904 > ./result_8chains/node261_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node261_5_2 -p 630 -st topic261_5_1 -pt None -u 0.015474488228286266 > ./result_8chains/node261_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_6_2 -p 695 -st topic261_6_1 -pt None -u 0.0031018154639648604 > ./result_8chains/node261_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node261_7_2 -p 858 -st topic261_7_1 -pt None -u 4.509572136594112e-06 > ./result_8chains/node261_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_0_0 -p 32 -st none -pt topic261_0_0 -u 0.04330318646287634 > ./result_8chains/node261_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node261_1_0 -p 218 -st none -pt topic261_1_0 -u 0.05462334379163125 > ./result_8chains/node261_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_2_0 -p 323 -st none -pt topic261_2_0 -u 0.006893345912519555 > ./result_8chains/node261_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node261_3_0 -p 426 -st none -pt topic261_3_0 -u 0.0025569668371643317 > ./result_8chains/node261_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_4_0 -p 599 -st none -pt topic261_4_0 -u 0.0035102777236833693 > ./result_8chains/node261_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node261_5_0 -p 630 -st none -pt topic261_5_0 -u 0.005031015313579863 > ./result_8chains/node261_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_6_0 -p 695 -st none -pt topic261_6_0 -u 0.014016396812664266 > ./result_8chains/node261_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node261_7_0 -p 858 -st none -pt topic261_7_0 -u 0.01742000190476706 > ./result_8chains/node261_7_0.txt &
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
    "./result_8chains/node261_0_0.txt 90"
    "./result_8chains/node261_0_2.txt 90"
    "./result_8chains/node261_1_0.txt 89"
    "./result_8chains/node261_1_2.txt 89"
    "./result_8chains/node261_2_0.txt 88"
    "./result_8chains/node261_2_2.txt 88"
    "./result_8chains/node261_3_0.txt 87"
    "./result_8chains/node261_3_2.txt 87"
    "./result_8chains/node261_4_0.txt 86"
    "./result_8chains/node261_4_2.txt 86"
    "./result_8chains/node261_5_0.txt 85"
    "./result_8chains/node261_5_2.txt 85"
    "./result_8chains/node261_6_0.txt 84"
    "./result_8chains/node261_6_2.txt 84"
    "./result_8chains/node261_7_0.txt 83"
    "./result_8chains/node261_7_2.txt 83"
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
