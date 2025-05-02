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
ros2 run evaluation_3_randomdag uunifast_node -n node281_0_2 -p 295 -st topic281_0_1 -pt None -u 0.026566287543462908 > ./result_4chains/node281_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_1_2 -p 325 -st topic281_1_1 -pt None -u 0.007712387641090335 > ./result_4chains/node281_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_2_2 -p 612 -st topic281_2_1 -pt None -u 0.09114345141653511 > ./result_4chains/node281_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_3_2 -p 858 -st topic281_3_1 -pt None -u 0.023136346387672 > ./result_4chains/node281_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_0_0 -p 295 -st none -pt topic281_0_0 -u 0.10875079096102591 > ./result_4chains/node281_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_1_0 -p 325 -st none -pt topic281_1_0 -u 0.04198424126447581 > ./result_4chains/node281_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_2_0 -p 612 -st none -pt topic281_2_0 -u 0.006354324955726909 > ./result_4chains/node281_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_3_0 -p 858 -st none -pt topic281_3_0 -u 0.05942196938232854 > ./result_4chains/node281_3_0.txt &
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
    "./result_4chains/node281_0_0.txt 90"
    "./result_4chains/node281_0_2.txt 90"
    "./result_4chains/node281_1_0.txt 89"
    "./result_4chains/node281_1_2.txt 89"
    "./result_4chains/node281_2_0.txt 88"
    "./result_4chains/node281_2_2.txt 88"
    "./result_4chains/node281_3_0.txt 87"
    "./result_4chains/node281_3_2.txt 87"
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
