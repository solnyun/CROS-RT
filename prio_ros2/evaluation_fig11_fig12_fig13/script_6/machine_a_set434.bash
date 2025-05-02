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
ros2 run evaluation_3_randomdag uunifast_node -n node434_0_2 -p 42 -st topic434_0_1 -pt None -u 0.09146765021813191 > ./result_6chains/node434_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_1_2 -p 224 -st topic434_1_1 -pt None -u 0.04373130833276273 > ./result_6chains/node434_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_2_2 -p 868 -st topic434_2_1 -pt None -u 0.00012860927312347004 > ./result_6chains/node434_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_3_2 -p 897 -st topic434_3_1 -pt None -u 0.06566147269030082 > ./result_6chains/node434_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_4_2 -p 953 -st topic434_4_1 -pt None -u 0.013901245781691607 > ./result_6chains/node434_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_5_2 -p 980 -st topic434_5_1 -pt None -u 0.03461130074604625 > ./result_6chains/node434_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_0_0 -p 42 -st none -pt topic434_0_0 -u 0.014028864446178013 > ./result_6chains/node434_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_1_0 -p 224 -st none -pt topic434_1_0 -u 0.01551086849662453 > ./result_6chains/node434_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_2_0 -p 868 -st none -pt topic434_2_0 -u 0.08730222847512273 > ./result_6chains/node434_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_3_0 -p 897 -st none -pt topic434_3_0 -u 0.01461109872917582 > ./result_6chains/node434_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_4_0 -p 953 -st none -pt topic434_4_0 -u 0.0022014915383201383 > ./result_6chains/node434_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_5_0 -p 980 -st none -pt topic434_5_0 -u 0.013515048143076053 > ./result_6chains/node434_5_0.txt &
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
    "./result_6chains/node434_0_0.txt 90"
    "./result_6chains/node434_0_2.txt 90"
    "./result_6chains/node434_1_0.txt 89"
    "./result_6chains/node434_1_2.txt 89"
    "./result_6chains/node434_2_0.txt 88"
    "./result_6chains/node434_2_2.txt 88"
    "./result_6chains/node434_3_0.txt 87"
    "./result_6chains/node434_3_2.txt 87"
    "./result_6chains/node434_4_0.txt 86"
    "./result_6chains/node434_4_2.txt 86"
    "./result_6chains/node434_5_0.txt 85"
    "./result_6chains/node434_5_2.txt 85"
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
