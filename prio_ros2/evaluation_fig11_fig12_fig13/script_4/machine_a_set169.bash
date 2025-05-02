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
ros2 run evaluation_3_randomdag uunifast_node -n node169_0_2 -p 193 -st topic169_0_1 -pt None -u 0.015212835180243522 > ./result_4chains/node169_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_1_2 -p 203 -st topic169_1_1 -pt None -u 0.058480578298975794 > ./result_4chains/node169_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_2_2 -p 429 -st topic169_2_1 -pt None -u 0.004308039961750457 > ./result_4chains/node169_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_3_2 -p 510 -st topic169_3_1 -pt None -u 0.032549157473707624 > ./result_4chains/node169_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_0_0 -p 193 -st none -pt topic169_0_0 -u 0.03566541056991407 > ./result_4chains/node169_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_1_0 -p 203 -st none -pt topic169_1_0 -u 0.09771045237257148 > ./result_4chains/node169_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_2_0 -p 429 -st none -pt topic169_2_0 -u 0.06361747135864484 > ./result_4chains/node169_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_3_0 -p 510 -st none -pt topic169_3_0 -u 0.0747139510076566 > ./result_4chains/node169_3_0.txt &
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
    "./result_4chains/node169_0_0.txt 90"
    "./result_4chains/node169_0_2.txt 90"
    "./result_4chains/node169_1_0.txt 89"
    "./result_4chains/node169_1_2.txt 89"
    "./result_4chains/node169_2_0.txt 88"
    "./result_4chains/node169_2_2.txt 88"
    "./result_4chains/node169_3_0.txt 87"
    "./result_4chains/node169_3_2.txt 87"
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
