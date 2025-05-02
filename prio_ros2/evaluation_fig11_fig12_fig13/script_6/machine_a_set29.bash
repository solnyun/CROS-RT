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
ros2 run evaluation_3_randomdag uunifast_node -n node29_0_2 -p 171 -st topic29_0_1 -pt None -u 0.059508363270495246 > ./result_6chains/node29_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_1_2 -p 263 -st topic29_1_1 -pt None -u 0.003514426041137997 > ./result_6chains/node29_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_2_2 -p 346 -st topic29_2_1 -pt None -u 0.02649567755339416 > ./result_6chains/node29_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_3_2 -p 431 -st topic29_3_1 -pt None -u 0.02712592642064851 > ./result_6chains/node29_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_4_2 -p 586 -st topic29_4_1 -pt None -u 0.01619517233888866 > ./result_6chains/node29_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_5_2 -p 637 -st topic29_5_1 -pt None -u 0.04474280152700309 > ./result_6chains/node29_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_0_0 -p 171 -st none -pt topic29_0_0 -u 0.03796745410542374 > ./result_6chains/node29_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_1_0 -p 263 -st none -pt topic29_1_0 -u 0.007015824819273375 > ./result_6chains/node29_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_2_0 -p 346 -st none -pt topic29_2_0 -u 0.08864960222937002 > ./result_6chains/node29_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_3_0 -p 431 -st none -pt topic29_3_0 -u 0.0235585997301265 > ./result_6chains/node29_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_4_0 -p 586 -st none -pt topic29_4_0 -u 0.07756708142088638 > ./result_6chains/node29_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_5_0 -p 637 -st none -pt topic29_5_0 -u 0.01637590764859255 > ./result_6chains/node29_5_0.txt &
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
    "./result_6chains/node29_0_0.txt 90"
    "./result_6chains/node29_0_2.txt 90"
    "./result_6chains/node29_1_0.txt 89"
    "./result_6chains/node29_1_2.txt 89"
    "./result_6chains/node29_2_0.txt 88"
    "./result_6chains/node29_2_2.txt 88"
    "./result_6chains/node29_3_0.txt 87"
    "./result_6chains/node29_3_2.txt 87"
    "./result_6chains/node29_4_0.txt 86"
    "./result_6chains/node29_4_2.txt 86"
    "./result_6chains/node29_5_0.txt 85"
    "./result_6chains/node29_5_2.txt 85"
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
