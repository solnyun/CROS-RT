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
ros2 run evaluation_3_randomdag uunifast_node -n node138_0_2 -p 177 -st topic138_0_1 -pt None -u 0.017164724831244926 > ./result_6chains/node138_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_1_2 -p 282 -st topic138_1_1 -pt None -u 0.0033404466351455997 > ./result_6chains/node138_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_2_2 -p 355 -st topic138_2_1 -pt None -u 0.01158744964613545 > ./result_6chains/node138_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_3_2 -p 420 -st topic138_3_1 -pt None -u 0.07727258520818019 > ./result_6chains/node138_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_4_2 -p 469 -st topic138_4_1 -pt None -u 0.007512994394933407 > ./result_6chains/node138_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_5_2 -p 601 -st topic138_5_1 -pt None -u 0.0013228759394772593 > ./result_6chains/node138_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_0_0 -p 177 -st none -pt topic138_0_0 -u 0.04848266683556174 > ./result_6chains/node138_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_1_0 -p 282 -st none -pt topic138_1_0 -u 0.0004299284571326889 > ./result_6chains/node138_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_2_0 -p 355 -st none -pt topic138_2_0 -u 0.03723715694673485 > ./result_6chains/node138_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_3_0 -p 420 -st none -pt topic138_3_0 -u 0.006913704921465064 > ./result_6chains/node138_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_4_0 -p 469 -st none -pt topic138_4_0 -u 0.012620996301752473 > ./result_6chains/node138_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_5_0 -p 601 -st none -pt topic138_5_0 -u 0.002109320485606865 > ./result_6chains/node138_5_0.txt &
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
    "./result_6chains/node138_0_0.txt 90"
    "./result_6chains/node138_0_2.txt 90"
    "./result_6chains/node138_1_0.txt 89"
    "./result_6chains/node138_1_2.txt 89"
    "./result_6chains/node138_2_0.txt 88"
    "./result_6chains/node138_2_2.txt 88"
    "./result_6chains/node138_3_0.txt 87"
    "./result_6chains/node138_3_2.txt 87"
    "./result_6chains/node138_4_0.txt 86"
    "./result_6chains/node138_4_2.txt 86"
    "./result_6chains/node138_5_0.txt 85"
    "./result_6chains/node138_5_2.txt 85"
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
