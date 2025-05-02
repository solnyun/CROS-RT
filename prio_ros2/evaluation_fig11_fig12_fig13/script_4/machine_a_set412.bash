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
ros2 run evaluation_3_randomdag uunifast_node -n node412_0_2 -p 93 -st topic412_0_1 -pt None -u 0.03789791817899296 > ./result_4chains/node412_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_1_2 -p 413 -st topic412_1_1 -pt None -u 0.017249230526064308 > ./result_4chains/node412_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_2_2 -p 797 -st topic412_2_1 -pt None -u 0.0689653469445963 > ./result_4chains/node412_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_3_2 -p 983 -st topic412_3_1 -pt None -u 0.004283225256425462 > ./result_4chains/node412_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_0_0 -p 93 -st none -pt topic412_0_0 -u 0.011370765073172473 > ./result_4chains/node412_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_1_0 -p 413 -st none -pt topic412_1_0 -u 0.007351017548065608 > ./result_4chains/node412_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_2_0 -p 797 -st none -pt topic412_2_0 -u 0.06050871686099818 > ./result_4chains/node412_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_3_0 -p 983 -st none -pt topic412_3_0 -u 0.04033069687324442 > ./result_4chains/node412_3_0.txt &
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
    "./result_4chains/node412_0_0.txt 90"
    "./result_4chains/node412_0_2.txt 90"
    "./result_4chains/node412_1_0.txt 89"
    "./result_4chains/node412_1_2.txt 89"
    "./result_4chains/node412_2_0.txt 88"
    "./result_4chains/node412_2_2.txt 88"
    "./result_4chains/node412_3_0.txt 87"
    "./result_4chains/node412_3_2.txt 87"
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
