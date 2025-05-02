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
ros2 run evaluation_3_randomdag uunifast_node -n node48_0_2 -p 534 -st topic48_0_1 -pt None -u 0.004201756230782838 > ./result_2chains/node48_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_1_2 -p 946 -st topic48_1_1 -pt None -u 0.25281953399351154 > ./result_2chains/node48_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_0_0 -p 534 -st none -pt topic48_0_0 -u 0.016496855097084373 > ./result_2chains/node48_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_1_0 -p 946 -st none -pt topic48_1_0 -u 0.06807206767488766 > ./result_2chains/node48_1_0.txt &
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
    "./result_2chains/node48_0_0.txt 90"
    "./result_2chains/node48_0_2.txt 90"
    "./result_2chains/node48_1_0.txt 89"
    "./result_2chains/node48_1_2.txt 89"
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
sleep 100s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
