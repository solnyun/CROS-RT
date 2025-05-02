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
ros2 run evaluation_3_randomdag uunifast_node -n node254_0_2 -p 88 -st topic254_0_1 -pt None -u 0.002511913439228408 > ./result_6chains/node254_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_1_2 -p 117 -st topic254_1_1 -pt None -u 0.042669027409161064 > ./result_6chains/node254_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_2_2 -p 275 -st topic254_2_1 -pt None -u 0.0031659658830481274 > ./result_6chains/node254_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_3_2 -p 307 -st topic254_3_1 -pt None -u 0.02680346980184134 > ./result_6chains/node254_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_4_2 -p 320 -st topic254_4_1 -pt None -u 0.0019778413913086323 > ./result_6chains/node254_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_5_2 -p 813 -st topic254_5_1 -pt None -u 0.012956316176878991 > ./result_6chains/node254_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_0_0 -p 88 -st none -pt topic254_0_0 -u 0.013944022307991188 > ./result_6chains/node254_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_1_0 -p 117 -st none -pt topic254_1_0 -u 0.026178965759009964 > ./result_6chains/node254_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_2_0 -p 275 -st none -pt topic254_2_0 -u 0.015779447585131834 > ./result_6chains/node254_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_3_0 -p 307 -st none -pt topic254_3_0 -u 0.006808944796401206 > ./result_6chains/node254_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_4_0 -p 320 -st none -pt topic254_4_0 -u 0.06994565225767072 > ./result_6chains/node254_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_5_0 -p 813 -st none -pt topic254_5_0 -u 0.08536441861702654 > ./result_6chains/node254_5_0.txt &
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
    "./result_6chains/node254_0_0.txt 90"
    "./result_6chains/node254_0_2.txt 90"
    "./result_6chains/node254_1_0.txt 89"
    "./result_6chains/node254_1_2.txt 89"
    "./result_6chains/node254_2_0.txt 88"
    "./result_6chains/node254_2_2.txt 88"
    "./result_6chains/node254_3_0.txt 87"
    "./result_6chains/node254_3_2.txt 87"
    "./result_6chains/node254_4_0.txt 86"
    "./result_6chains/node254_4_2.txt 86"
    "./result_6chains/node254_5_0.txt 85"
    "./result_6chains/node254_5_2.txt 85"
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
