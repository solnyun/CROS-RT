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
ros2 run evaluation_3_randomdag uunifast_node -n node3_0_2 -p 15 -st topic3_0_1 -pt None -u 0.02068568708092916 > ./result_8chains/node3_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_1_2 -p 42 -st topic3_1_1 -pt None -u 0.034369067452189206 > ./result_8chains/node3_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_2_2 -p 50 -st topic3_2_1 -pt None -u 0.0028861257524506745 > ./result_8chains/node3_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_3_2 -p 158 -st topic3_3_1 -pt None -u 0.019323893693044103 > ./result_8chains/node3_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_4_2 -p 160 -st topic3_4_1 -pt None -u 0.0033479777503938324 > ./result_8chains/node3_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_5_2 -p 435 -st topic3_5_1 -pt None -u 0.0007937108946498017 > ./result_8chains/node3_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_6_2 -p 669 -st topic3_6_1 -pt None -u 0.04175090824074153 > ./result_8chains/node3_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_7_2 -p 803 -st topic3_7_1 -pt None -u 0.023663801006642084 > ./result_8chains/node3_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_0_0 -p 15 -st none -pt topic3_0_0 -u 0.08149105025726805 > ./result_8chains/node3_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_1_0 -p 42 -st none -pt topic3_1_0 -u 0.02913385799782986 > ./result_8chains/node3_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_2_0 -p 50 -st none -pt topic3_2_0 -u 0.0048202459260361374 > ./result_8chains/node3_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_3_0 -p 158 -st none -pt topic3_3_0 -u 0.03744937901034673 > ./result_8chains/node3_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_4_0 -p 160 -st none -pt topic3_4_0 -u 0.01866345809265224 > ./result_8chains/node3_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_5_0 -p 435 -st none -pt topic3_5_0 -u 0.001129228975177865 > ./result_8chains/node3_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_6_0 -p 669 -st none -pt topic3_6_0 -u 0.007628872623298449 > ./result_8chains/node3_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_7_0 -p 803 -st none -pt topic3_7_0 -u 0.0016670034340579842 > ./result_8chains/node3_7_0.txt &
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
    "./result_8chains/node3_0_0.txt 90"
    "./result_8chains/node3_0_2.txt 90"
    "./result_8chains/node3_1_0.txt 89"
    "./result_8chains/node3_1_2.txt 89"
    "./result_8chains/node3_2_0.txt 88"
    "./result_8chains/node3_2_2.txt 88"
    "./result_8chains/node3_3_0.txt 87"
    "./result_8chains/node3_3_2.txt 87"
    "./result_8chains/node3_4_0.txt 86"
    "./result_8chains/node3_4_2.txt 86"
    "./result_8chains/node3_5_0.txt 85"
    "./result_8chains/node3_5_2.txt 85"
    "./result_8chains/node3_6_0.txt 84"
    "./result_8chains/node3_6_2.txt 84"
    "./result_8chains/node3_7_0.txt 83"
    "./result_8chains/node3_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
