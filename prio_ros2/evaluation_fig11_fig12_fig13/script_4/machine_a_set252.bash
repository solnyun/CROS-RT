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
ros2 run evaluation_3_randomdag uunifast_node -n node252_0_2 -p 113 -st topic252_0_1 -pt None -u 0.10791052695930614 > ./result_4chains/node252_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_1_2 -p 324 -st topic252_1_1 -pt None -u 0.026302473195777054 > ./result_4chains/node252_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_2_2 -p 378 -st topic252_2_1 -pt None -u 0.0021409374843041062 > ./result_4chains/node252_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_3_2 -p 808 -st topic252_3_1 -pt None -u 0.07748541624063728 > ./result_4chains/node252_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_0_0 -p 113 -st none -pt topic252_0_0 -u 0.007865197922967582 > ./result_4chains/node252_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_1_0 -p 324 -st none -pt topic252_1_0 -u 0.04977225961914772 > ./result_4chains/node252_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_2_0 -p 378 -st none -pt topic252_2_0 -u 0.01710082285971226 > ./result_4chains/node252_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_3_0 -p 808 -st none -pt topic252_3_0 -u 0.10373516976225257 > ./result_4chains/node252_3_0.txt &
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
    "./result_4chains/node252_0_0.txt 90"
    "./result_4chains/node252_0_2.txt 90"
    "./result_4chains/node252_1_0.txt 89"
    "./result_4chains/node252_1_2.txt 89"
    "./result_4chains/node252_2_0.txt 88"
    "./result_4chains/node252_2_2.txt 88"
    "./result_4chains/node252_3_0.txt 87"
    "./result_4chains/node252_3_2.txt 87"
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
