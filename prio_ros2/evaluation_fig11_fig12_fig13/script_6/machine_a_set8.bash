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
ros2 run evaluation_3_randomdag uunifast_node -n node8_0_2 -p 465 -st topic8_0_1 -pt None -u 0.05853413234037774 > ./result_6chains/node8_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_1_2 -p 491 -st topic8_1_1 -pt None -u 0.04043870574890435 > ./result_6chains/node8_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_2_2 -p 771 -st topic8_2_1 -pt None -u 0.04524080306450862 > ./result_6chains/node8_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_3_2 -p 773 -st topic8_3_1 -pt None -u 0.005048327867810204 > ./result_6chains/node8_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_4_2 -p 807 -st topic8_4_1 -pt None -u 0.00035037510477516076 > ./result_6chains/node8_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_5_2 -p 871 -st topic8_5_1 -pt None -u 0.020915742918934135 > ./result_6chains/node8_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_0_0 -p 465 -st none -pt topic8_0_0 -u 0.005370611716653151 > ./result_6chains/node8_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_1_0 -p 491 -st none -pt topic8_1_0 -u 0.007169488453154682 > ./result_6chains/node8_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_2_0 -p 771 -st none -pt topic8_2_0 -u 0.0027682603399584726 > ./result_6chains/node8_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_3_0 -p 773 -st none -pt topic8_3_0 -u 0.042498607936535815 > ./result_6chains/node8_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_4_0 -p 807 -st none -pt topic8_4_0 -u 0.007192537385320205 > ./result_6chains/node8_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_5_0 -p 871 -st none -pt topic8_5_0 -u 0.03038449801372279 > ./result_6chains/node8_5_0.txt &
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
    "./result_6chains/node8_0_0.txt 90"
    "./result_6chains/node8_0_2.txt 90"
    "./result_6chains/node8_1_0.txt 89"
    "./result_6chains/node8_1_2.txt 89"
    "./result_6chains/node8_2_0.txt 88"
    "./result_6chains/node8_2_2.txt 88"
    "./result_6chains/node8_3_0.txt 87"
    "./result_6chains/node8_3_2.txt 87"
    "./result_6chains/node8_4_0.txt 86"
    "./result_6chains/node8_4_2.txt 86"
    "./result_6chains/node8_5_0.txt 85"
    "./result_6chains/node8_5_2.txt 85"
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
