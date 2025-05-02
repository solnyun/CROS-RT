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
ros2 run evaluation_3_randomdag uunifast_node -n node225_0_2 -p 120 -st topic225_0_1 -pt None -u 0.0054556550061369835 > ./result_6chains/node225_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_1_2 -p 134 -st topic225_1_1 -pt None -u 0.05890626413877054 > ./result_6chains/node225_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_2_2 -p 216 -st topic225_2_1 -pt None -u 0.04907041374200238 > ./result_6chains/node225_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_3_2 -p 357 -st topic225_3_1 -pt None -u 0.011877029072612483 > ./result_6chains/node225_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_4_2 -p 647 -st topic225_4_1 -pt None -u 0.0633116927196046 > ./result_6chains/node225_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_5_2 -p 668 -st topic225_5_1 -pt None -u 0.001406011079954144 > ./result_6chains/node225_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_0_0 -p 120 -st none -pt topic225_0_0 -u 0.006570366774703906 > ./result_6chains/node225_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_1_0 -p 134 -st none -pt topic225_1_0 -u 0.04542645098642295 > ./result_6chains/node225_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_2_0 -p 216 -st none -pt topic225_2_0 -u 0.0250185290655926 > ./result_6chains/node225_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_3_0 -p 357 -st none -pt topic225_3_0 -u 0.05895971486684934 > ./result_6chains/node225_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_4_0 -p 647 -st none -pt topic225_4_0 -u 0.0007291103337846161 > ./result_6chains/node225_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_5_0 -p 668 -st none -pt topic225_5_0 -u 0.04657562281607762 > ./result_6chains/node225_5_0.txt &
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
    "./result_6chains/node225_0_0.txt 90"
    "./result_6chains/node225_0_2.txt 90"
    "./result_6chains/node225_1_0.txt 89"
    "./result_6chains/node225_1_2.txt 89"
    "./result_6chains/node225_2_0.txt 88"
    "./result_6chains/node225_2_2.txt 88"
    "./result_6chains/node225_3_0.txt 87"
    "./result_6chains/node225_3_2.txt 87"
    "./result_6chains/node225_4_0.txt 86"
    "./result_6chains/node225_4_2.txt 86"
    "./result_6chains/node225_5_0.txt 85"
    "./result_6chains/node225_5_2.txt 85"
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
