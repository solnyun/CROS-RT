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
ros2 run evaluation_3_randomdag uunifast_node -n node398_0_2 -p 130 -st topic398_0_1 -pt None -u 0.0008060051700179982 > ./result_4chains/node398_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_1_2 -p 145 -st topic398_1_1 -pt None -u 0.010877552797381895 > ./result_4chains/node398_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_2_2 -p 452 -st topic398_2_1 -pt None -u 0.04284123524812257 > ./result_4chains/node398_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_3_2 -p 639 -st topic398_3_1 -pt None -u 0.03708701855617042 > ./result_4chains/node398_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_0_0 -p 130 -st none -pt topic398_0_0 -u 0.2551465380773854 > ./result_4chains/node398_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_1_0 -p 145 -st none -pt topic398_1_0 -u 0.03745085490166525 > ./result_4chains/node398_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_2_0 -p 452 -st none -pt topic398_2_0 -u 0.009317387690080614 > ./result_4chains/node398_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_3_0 -p 639 -st none -pt topic398_3_0 -u 0.022147992231952407 > ./result_4chains/node398_3_0.txt &
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
    "./result_4chains/node398_0_0.txt 90"
    "./result_4chains/node398_0_2.txt 90"
    "./result_4chains/node398_1_0.txt 89"
    "./result_4chains/node398_1_2.txt 89"
    "./result_4chains/node398_2_0.txt 88"
    "./result_4chains/node398_2_2.txt 88"
    "./result_4chains/node398_3_0.txt 87"
    "./result_4chains/node398_3_2.txt 87"
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
