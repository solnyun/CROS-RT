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
ros2 run evaluation_3_randomdag uunifast_node -n node421_0_2 -p 224 -st topic421_0_1 -pt None -u 0.022805054249009693 > ./result_4chains/node421_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node421_1_2 -p 435 -st topic421_1_1 -pt None -u 0.0800508308370825 > ./result_4chains/node421_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node421_2_2 -p 563 -st topic421_2_1 -pt None -u 0.05041066246752195 > ./result_4chains/node421_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node421_3_2 -p 811 -st topic421_3_1 -pt None -u 0.0011258979282502812 > ./result_4chains/node421_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node421_0_0 -p 224 -st none -pt topic421_0_0 -u 0.04278220048453324 > ./result_4chains/node421_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node421_1_0 -p 435 -st none -pt topic421_1_0 -u 0.12390849243378205 > ./result_4chains/node421_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node421_2_0 -p 563 -st none -pt topic421_2_0 -u 0.05103359217766354 > ./result_4chains/node421_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node421_3_0 -p 811 -st none -pt topic421_3_0 -u 0.04985735270101914 > ./result_4chains/node421_3_0.txt &
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
    "./result_4chains/node421_0_0.txt 90"
    "./result_4chains/node421_0_2.txt 90"
    "./result_4chains/node421_1_0.txt 89"
    "./result_4chains/node421_1_2.txt 89"
    "./result_4chains/node421_2_0.txt 88"
    "./result_4chains/node421_2_2.txt 88"
    "./result_4chains/node421_3_0.txt 87"
    "./result_4chains/node421_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
