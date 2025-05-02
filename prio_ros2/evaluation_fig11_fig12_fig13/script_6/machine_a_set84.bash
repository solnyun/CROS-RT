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
ros2 run evaluation_3_randomdag uunifast_node -n node84_0_2 -p 84 -st topic84_0_1 -pt None -u 0.04660628279385398 > ./result_6chains/node84_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_1_2 -p 129 -st topic84_1_1 -pt None -u 0.004384454156781348 > ./result_6chains/node84_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_2_2 -p 302 -st topic84_2_1 -pt None -u 0.04062467644285228 > ./result_6chains/node84_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_3_2 -p 326 -st topic84_3_1 -pt None -u 0.026478916248642764 > ./result_6chains/node84_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_4_2 -p 349 -st topic84_4_1 -pt None -u 0.036177726631300894 > ./result_6chains/node84_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_5_2 -p 916 -st topic84_5_1 -pt None -u 0.005917108406286171 > ./result_6chains/node84_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_0_0 -p 84 -st none -pt topic84_0_0 -u 0.008597262714054088 > ./result_6chains/node84_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_1_0 -p 129 -st none -pt topic84_1_0 -u 0.015172887695068193 > ./result_6chains/node84_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_2_0 -p 302 -st none -pt topic84_2_0 -u 0.004609921545405182 > ./result_6chains/node84_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_3_0 -p 326 -st none -pt topic84_3_0 -u 0.02336863030860975 > ./result_6chains/node84_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_4_0 -p 349 -st none -pt topic84_4_0 -u 0.026766687114277377 > ./result_6chains/node84_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_5_0 -p 916 -st none -pt topic84_5_0 -u 0.028217677514627587 > ./result_6chains/node84_5_0.txt &
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
    "./result_6chains/node84_0_0.txt 90"
    "./result_6chains/node84_0_2.txt 90"
    "./result_6chains/node84_1_0.txt 89"
    "./result_6chains/node84_1_2.txt 89"
    "./result_6chains/node84_2_0.txt 88"
    "./result_6chains/node84_2_2.txt 88"
    "./result_6chains/node84_3_0.txt 87"
    "./result_6chains/node84_3_2.txt 87"
    "./result_6chains/node84_4_0.txt 86"
    "./result_6chains/node84_4_2.txt 86"
    "./result_6chains/node84_5_0.txt 85"
    "./result_6chains/node84_5_2.txt 85"
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
