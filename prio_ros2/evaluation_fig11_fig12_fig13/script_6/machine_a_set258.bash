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
ros2 run evaluation_3_randomdag uunifast_node -n node258_0_2 -p 292 -st topic258_0_1 -pt None -u 0.047415443630054455 > ./result_6chains/node258_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_1_2 -p 438 -st topic258_1_1 -pt None -u 0.10500071375894487 > ./result_6chains/node258_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_2_2 -p 537 -st topic258_2_1 -pt None -u 0.013045601773806953 > ./result_6chains/node258_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_3_2 -p 571 -st topic258_3_1 -pt None -u 0.012915050892286783 > ./result_6chains/node258_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_4_2 -p 578 -st topic258_4_1 -pt None -u 0.05587691071671284 > ./result_6chains/node258_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_5_2 -p 997 -st topic258_5_1 -pt None -u 0.006843766852551831 > ./result_6chains/node258_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_0_0 -p 292 -st none -pt topic258_0_0 -u 0.009136914890542192 > ./result_6chains/node258_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_1_0 -p 438 -st none -pt topic258_1_0 -u 0.0070443126670928224 > ./result_6chains/node258_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_2_0 -p 537 -st none -pt topic258_2_0 -u 0.057295609959213234 > ./result_6chains/node258_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_3_0 -p 571 -st none -pt topic258_3_0 -u 0.0017401685399162925 > ./result_6chains/node258_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_4_0 -p 578 -st none -pt topic258_4_0 -u 0.02196694630780857 > ./result_6chains/node258_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_5_0 -p 997 -st none -pt topic258_5_0 -u 0.004944077677029438 > ./result_6chains/node258_5_0.txt &
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
    "./result_6chains/node258_0_0.txt 90"
    "./result_6chains/node258_0_2.txt 90"
    "./result_6chains/node258_1_0.txt 89"
    "./result_6chains/node258_1_2.txt 89"
    "./result_6chains/node258_2_0.txt 88"
    "./result_6chains/node258_2_2.txt 88"
    "./result_6chains/node258_3_0.txt 87"
    "./result_6chains/node258_3_2.txt 87"
    "./result_6chains/node258_4_0.txt 86"
    "./result_6chains/node258_4_2.txt 86"
    "./result_6chains/node258_5_0.txt 85"
    "./result_6chains/node258_5_2.txt 85"
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
