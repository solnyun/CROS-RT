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
ros2 run evaluation_3_randomdag uunifast_node -n node327_0_2 -p 152 -st topic327_0_1 -pt None -u 0.04158632108578375 > ./result_6chains/node327_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_1_2 -p 281 -st topic327_1_1 -pt None -u 0.008593888958362772 > ./result_6chains/node327_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_2_2 -p 471 -st topic327_2_1 -pt None -u 0.004731202894121045 > ./result_6chains/node327_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_3_2 -p 570 -st topic327_3_1 -pt None -u 0.0034441425398657466 > ./result_6chains/node327_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_4_2 -p 832 -st topic327_4_1 -pt None -u 0.03295215571141065 > ./result_6chains/node327_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_5_2 -p 989 -st topic327_5_1 -pt None -u 0.015626548106442845 > ./result_6chains/node327_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_0_0 -p 152 -st none -pt topic327_0_0 -u 0.01890051767927703 > ./result_6chains/node327_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_1_0 -p 281 -st none -pt topic327_1_0 -u 0.032148705981230485 > ./result_6chains/node327_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_2_0 -p 471 -st none -pt topic327_2_0 -u 0.05529816653267716 > ./result_6chains/node327_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_3_0 -p 570 -st none -pt topic327_3_0 -u 0.0480080080310486 > ./result_6chains/node327_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_4_0 -p 832 -st none -pt topic327_4_0 -u 0.04385919139560751 > ./result_6chains/node327_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_5_0 -p 989 -st none -pt topic327_5_0 -u 0.0203374294240192 > ./result_6chains/node327_5_0.txt &
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
    "./result_6chains/node327_0_0.txt 90"
    "./result_6chains/node327_0_2.txt 90"
    "./result_6chains/node327_1_0.txt 89"
    "./result_6chains/node327_1_2.txt 89"
    "./result_6chains/node327_2_0.txt 88"
    "./result_6chains/node327_2_2.txt 88"
    "./result_6chains/node327_3_0.txt 87"
    "./result_6chains/node327_3_2.txt 87"
    "./result_6chains/node327_4_0.txt 86"
    "./result_6chains/node327_4_2.txt 86"
    "./result_6chains/node327_5_0.txt 85"
    "./result_6chains/node327_5_2.txt 85"
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
