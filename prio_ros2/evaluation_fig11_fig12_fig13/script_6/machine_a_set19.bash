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
ros2 run evaluation_3_randomdag uunifast_node -n node19_0_2 -p 225 -st topic19_0_1 -pt None -u 0.000940878468034978 > ./result_6chains/node19_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_1_2 -p 323 -st topic19_1_1 -pt None -u 0.03084695969888457 > ./result_6chains/node19_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_2_2 -p 330 -st topic19_2_1 -pt None -u 0.022512734356278485 > ./result_6chains/node19_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_3_2 -p 530 -st topic19_3_1 -pt None -u 0.006884299213709699 > ./result_6chains/node19_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_4_2 -p 687 -st topic19_4_1 -pt None -u 0.1347026776101142 > ./result_6chains/node19_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_5_2 -p 776 -st topic19_5_1 -pt None -u 0.0058090672107903385 > ./result_6chains/node19_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_0_0 -p 225 -st none -pt topic19_0_0 -u 0.032257021455445734 > ./result_6chains/node19_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_1_0 -p 323 -st none -pt topic19_1_0 -u 0.03060962358495456 > ./result_6chains/node19_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_2_0 -p 330 -st none -pt topic19_2_0 -u 0.02371474261445844 > ./result_6chains/node19_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_3_0 -p 530 -st none -pt topic19_3_0 -u 0.04743661096313542 > ./result_6chains/node19_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_4_0 -p 687 -st none -pt topic19_4_0 -u 0.03458883290351167 > ./result_6chains/node19_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_5_0 -p 776 -st none -pt topic19_5_0 -u 0.002155040328264142 > ./result_6chains/node19_5_0.txt &
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
    "./result_6chains/node19_0_0.txt 90"
    "./result_6chains/node19_0_2.txt 90"
    "./result_6chains/node19_1_0.txt 89"
    "./result_6chains/node19_1_2.txt 89"
    "./result_6chains/node19_2_0.txt 88"
    "./result_6chains/node19_2_2.txt 88"
    "./result_6chains/node19_3_0.txt 87"
    "./result_6chains/node19_3_2.txt 87"
    "./result_6chains/node19_4_0.txt 86"
    "./result_6chains/node19_4_2.txt 86"
    "./result_6chains/node19_5_0.txt 85"
    "./result_6chains/node19_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
