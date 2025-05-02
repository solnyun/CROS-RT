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
ros2 run evaluation_3_randomdag uunifast_node -n node63_0_2 -p 46 -st topic63_0_1 -pt None -u 0.017466467076132808 > ./result_6chains/node63_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_1_2 -p 77 -st topic63_1_1 -pt None -u 0.042782454083262755 > ./result_6chains/node63_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_2_2 -p 245 -st topic63_2_1 -pt None -u 0.005240009554665803 > ./result_6chains/node63_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_3_2 -p 403 -st topic63_3_1 -pt None -u 0.025510684590111132 > ./result_6chains/node63_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_4_2 -p 716 -st topic63_4_1 -pt None -u 0.002272943528417351 > ./result_6chains/node63_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_5_2 -p 955 -st topic63_5_1 -pt None -u 0.0355653348795952 > ./result_6chains/node63_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_0_0 -p 46 -st none -pt topic63_0_0 -u 0.10297537964357567 > ./result_6chains/node63_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_1_0 -p 77 -st none -pt topic63_1_0 -u 0.01729172900912096 > ./result_6chains/node63_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_2_0 -p 245 -st none -pt topic63_2_0 -u 0.027387512124959046 > ./result_6chains/node63_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_3_0 -p 403 -st none -pt topic63_3_0 -u 0.02511901632647348 > ./result_6chains/node63_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_4_0 -p 716 -st none -pt topic63_4_0 -u 0.012979496389351142 > ./result_6chains/node63_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_5_0 -p 955 -st none -pt topic63_5_0 -u 0.035610277482500466 > ./result_6chains/node63_5_0.txt &
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
    "./result_6chains/node63_0_0.txt 90"
    "./result_6chains/node63_0_2.txt 90"
    "./result_6chains/node63_1_0.txt 89"
    "./result_6chains/node63_1_2.txt 89"
    "./result_6chains/node63_2_0.txt 88"
    "./result_6chains/node63_2_2.txt 88"
    "./result_6chains/node63_3_0.txt 87"
    "./result_6chains/node63_3_2.txt 87"
    "./result_6chains/node63_4_0.txt 86"
    "./result_6chains/node63_4_2.txt 86"
    "./result_6chains/node63_5_0.txt 85"
    "./result_6chains/node63_5_2.txt 85"
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
