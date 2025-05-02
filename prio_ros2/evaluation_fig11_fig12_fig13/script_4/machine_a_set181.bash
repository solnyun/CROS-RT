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
ros2 run evaluation_3_randomdag uunifast_node -n node181_0_2 -p 126 -st topic181_0_1 -pt None -u 0.028037248300435247 > ./result_4chains/node181_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node181_1_2 -p 419 -st topic181_1_1 -pt None -u 0.007536749976148116 > ./result_4chains/node181_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_2_2 -p 685 -st topic181_2_1 -pt None -u 0.014493092810405644 > ./result_4chains/node181_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node181_3_2 -p 728 -st topic181_3_1 -pt None -u 0.10624387342763486 > ./result_4chains/node181_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_0_0 -p 126 -st none -pt topic181_0_0 -u 0.04401483506711329 > ./result_4chains/node181_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node181_1_0 -p 419 -st none -pt topic181_1_0 -u 0.17884572065471738 > ./result_4chains/node181_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_2_0 -p 685 -st none -pt topic181_2_0 -u 0.03483225576851809 > ./result_4chains/node181_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node181_3_0 -p 728 -st none -pt topic181_3_0 -u 0.02295569438643176 > ./result_4chains/node181_3_0.txt &
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
    "./result_4chains/node181_0_0.txt 90"
    "./result_4chains/node181_0_2.txt 90"
    "./result_4chains/node181_1_0.txt 89"
    "./result_4chains/node181_1_2.txt 89"
    "./result_4chains/node181_2_0.txt 88"
    "./result_4chains/node181_2_2.txt 88"
    "./result_4chains/node181_3_0.txt 87"
    "./result_4chains/node181_3_2.txt 87"
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
