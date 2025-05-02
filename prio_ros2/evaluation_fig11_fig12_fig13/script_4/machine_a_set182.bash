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
ros2 run evaluation_3_randomdag uunifast_node -n node182_0_2 -p 335 -st topic182_0_1 -pt None -u 0.02855178320241214 > ./result_4chains/node182_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_1_2 -p 480 -st topic182_1_1 -pt None -u 0.0647267964650651 > ./result_4chains/node182_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_2_2 -p 803 -st topic182_2_1 -pt None -u 0.060300538102612516 > ./result_4chains/node182_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_3_2 -p 901 -st topic182_3_1 -pt None -u 0.013158065875341449 > ./result_4chains/node182_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_0_0 -p 335 -st none -pt topic182_0_0 -u 0.11633849465514984 > ./result_4chains/node182_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_1_0 -p 480 -st none -pt topic182_1_0 -u 0.010902693428824661 > ./result_4chains/node182_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_2_0 -p 803 -st none -pt topic182_2_0 -u 0.004946608018225468 > ./result_4chains/node182_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_3_0 -p 901 -st none -pt topic182_3_0 -u 0.08802601403601258 > ./result_4chains/node182_3_0.txt &
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
    "./result_4chains/node182_0_0.txt 90"
    "./result_4chains/node182_0_2.txt 90"
    "./result_4chains/node182_1_0.txt 89"
    "./result_4chains/node182_1_2.txt 89"
    "./result_4chains/node182_2_0.txt 88"
    "./result_4chains/node182_2_2.txt 88"
    "./result_4chains/node182_3_0.txt 87"
    "./result_4chains/node182_3_2.txt 87"
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
