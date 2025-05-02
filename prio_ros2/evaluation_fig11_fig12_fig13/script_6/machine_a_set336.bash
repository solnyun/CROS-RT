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
ros2 run evaluation_3_randomdag uunifast_node -n node336_0_2 -p 128 -st topic336_0_1 -pt None -u 0.015465389566480692 > ./result_6chains/node336_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_1_2 -p 427 -st topic336_1_1 -pt None -u 0.0006604143873429336 > ./result_6chains/node336_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_2_2 -p 564 -st topic336_2_1 -pt None -u 0.016908444028166214 > ./result_6chains/node336_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_3_2 -p 581 -st topic336_3_1 -pt None -u 0.01685348920957315 > ./result_6chains/node336_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_4_2 -p 676 -st topic336_4_1 -pt None -u 0.02650967542476293 > ./result_6chains/node336_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_5_2 -p 818 -st topic336_5_1 -pt None -u 0.048011397250658096 > ./result_6chains/node336_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_0_0 -p 128 -st none -pt topic336_0_0 -u 0.04339167045924519 > ./result_6chains/node336_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_1_0 -p 427 -st none -pt topic336_1_0 -u 0.0059551996582369315 > ./result_6chains/node336_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_2_0 -p 564 -st none -pt topic336_2_0 -u 0.05094151815711678 > ./result_6chains/node336_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_3_0 -p 581 -st none -pt topic336_3_0 -u 0.01122039724526469 > ./result_6chains/node336_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_4_0 -p 676 -st none -pt topic336_4_0 -u 0.010153484463808843 > ./result_6chains/node336_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_5_0 -p 818 -st none -pt topic336_5_0 -u 0.024756666662998965 > ./result_6chains/node336_5_0.txt &
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
    "./result_6chains/node336_0_0.txt 90"
    "./result_6chains/node336_0_2.txt 90"
    "./result_6chains/node336_1_0.txt 89"
    "./result_6chains/node336_1_2.txt 89"
    "./result_6chains/node336_2_0.txt 88"
    "./result_6chains/node336_2_2.txt 88"
    "./result_6chains/node336_3_0.txt 87"
    "./result_6chains/node336_3_2.txt 87"
    "./result_6chains/node336_4_0.txt 86"
    "./result_6chains/node336_4_2.txt 86"
    "./result_6chains/node336_5_0.txt 85"
    "./result_6chains/node336_5_2.txt 85"
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
