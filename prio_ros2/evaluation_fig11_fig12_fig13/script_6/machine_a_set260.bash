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
ros2 run evaluation_3_randomdag uunifast_node -n node260_0_2 -p 142 -st topic260_0_1 -pt None -u 0.01240574272054068 > ./result_6chains/node260_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_1_2 -p 299 -st topic260_1_1 -pt None -u 0.01944092934813324 > ./result_6chains/node260_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_2_2 -p 678 -st topic260_2_1 -pt None -u 0.019424684594107733 > ./result_6chains/node260_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_3_2 -p 743 -st topic260_3_1 -pt None -u 0.005103854863832108 > ./result_6chains/node260_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_4_2 -p 957 -st topic260_4_1 -pt None -u 0.06859505251193534 > ./result_6chains/node260_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_5_2 -p 988 -st topic260_5_1 -pt None -u 0.03437219487785806 > ./result_6chains/node260_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_0_0 -p 142 -st none -pt topic260_0_0 -u 0.06951303242059059 > ./result_6chains/node260_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_1_0 -p 299 -st none -pt topic260_1_0 -u 0.025654465719602892 > ./result_6chains/node260_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_2_0 -p 678 -st none -pt topic260_2_0 -u 0.0455876508452942 > ./result_6chains/node260_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_3_0 -p 743 -st none -pt topic260_3_0 -u 0.06469576887203685 > ./result_6chains/node260_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_4_0 -p 957 -st none -pt topic260_4_0 -u 0.025115644792359004 > ./result_6chains/node260_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_5_0 -p 988 -st none -pt topic260_5_0 -u 0.01798391903221476 > ./result_6chains/node260_5_0.txt &
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
    "./result_6chains/node260_0_0.txt 90"
    "./result_6chains/node260_0_2.txt 90"
    "./result_6chains/node260_1_0.txt 89"
    "./result_6chains/node260_1_2.txt 89"
    "./result_6chains/node260_2_0.txt 88"
    "./result_6chains/node260_2_2.txt 88"
    "./result_6chains/node260_3_0.txt 87"
    "./result_6chains/node260_3_2.txt 87"
    "./result_6chains/node260_4_0.txt 86"
    "./result_6chains/node260_4_2.txt 86"
    "./result_6chains/node260_5_0.txt 85"
    "./result_6chains/node260_5_2.txt 85"
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
