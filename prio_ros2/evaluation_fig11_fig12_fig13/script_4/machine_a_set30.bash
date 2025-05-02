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
ros2 run evaluation_3_randomdag uunifast_node -n node30_0_2 -p 79 -st topic30_0_1 -pt None -u 0.027858285048293296 > ./result_4chains/node30_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_1_2 -p 131 -st topic30_1_1 -pt None -u 0.07067187276977388 > ./result_4chains/node30_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_2_2 -p 253 -st topic30_2_1 -pt None -u 0.05306654774661876 > ./result_4chains/node30_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_3_2 -p 350 -st topic30_3_1 -pt None -u 0.09777003368685318 > ./result_4chains/node30_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_0_0 -p 79 -st none -pt topic30_0_0 -u 0.022869926743993407 > ./result_4chains/node30_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_1_0 -p 131 -st none -pt topic30_1_0 -u 0.004231894276337689 > ./result_4chains/node30_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_2_0 -p 253 -st none -pt topic30_2_0 -u 0.029777785669341472 > ./result_4chains/node30_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_3_0 -p 350 -st none -pt topic30_3_0 -u 0.0018588686297981577 > ./result_4chains/node30_3_0.txt &
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
    "./result_4chains/node30_0_0.txt 90"
    "./result_4chains/node30_0_2.txt 90"
    "./result_4chains/node30_1_0.txt 89"
    "./result_4chains/node30_1_2.txt 89"
    "./result_4chains/node30_2_0.txt 88"
    "./result_4chains/node30_2_2.txt 88"
    "./result_4chains/node30_3_0.txt 87"
    "./result_4chains/node30_3_2.txt 87"
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
sleep 70s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 40s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
