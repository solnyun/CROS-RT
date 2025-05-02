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
ros2 run evaluation_3_randomdag uunifast_node -n node200_0_2 -p 69 -st topic200_0_1 -pt None -u 0.025079470047747243 > ./result_6chains/node200_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_1_2 -p 256 -st topic200_1_1 -pt None -u 0.045117762439802755 > ./result_6chains/node200_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_2_2 -p 670 -st topic200_2_1 -pt None -u 0.015864575441797313 > ./result_6chains/node200_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_3_2 -p 815 -st topic200_3_1 -pt None -u 0.034153645578799297 > ./result_6chains/node200_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_4_2 -p 891 -st topic200_4_1 -pt None -u 0.04339500869903945 > ./result_6chains/node200_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_5_2 -p 924 -st topic200_5_1 -pt None -u 0.12519778051108596 > ./result_6chains/node200_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_0_0 -p 69 -st none -pt topic200_0_0 -u 0.02858969880172707 > ./result_6chains/node200_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_1_0 -p 256 -st none -pt topic200_1_0 -u 0.03266488934079276 > ./result_6chains/node200_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_2_0 -p 670 -st none -pt topic200_2_0 -u 0.00520670803132578 > ./result_6chains/node200_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_3_0 -p 815 -st none -pt topic200_3_0 -u 0.029495301560636678 > ./result_6chains/node200_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_4_0 -p 891 -st none -pt topic200_4_0 -u 0.030616122168340698 > ./result_6chains/node200_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_5_0 -p 924 -st none -pt topic200_5_0 -u 0.01123141582721815 > ./result_6chains/node200_5_0.txt &
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
    "./result_6chains/node200_0_0.txt 90"
    "./result_6chains/node200_0_2.txt 90"
    "./result_6chains/node200_1_0.txt 89"
    "./result_6chains/node200_1_2.txt 89"
    "./result_6chains/node200_2_0.txt 88"
    "./result_6chains/node200_2_2.txt 88"
    "./result_6chains/node200_3_0.txt 87"
    "./result_6chains/node200_3_2.txt 87"
    "./result_6chains/node200_4_0.txt 86"
    "./result_6chains/node200_4_2.txt 86"
    "./result_6chains/node200_5_0.txt 85"
    "./result_6chains/node200_5_2.txt 85"
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
