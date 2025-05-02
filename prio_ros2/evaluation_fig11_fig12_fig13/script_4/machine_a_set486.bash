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
ros2 run evaluation_3_randomdag uunifast_node -n node486_0_2 -p 46 -st topic486_0_1 -pt None -u 0.02995905544060906 > ./result_4chains/node486_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node486_1_2 -p 319 -st topic486_1_1 -pt None -u 0.010551782418357303 > ./result_4chains/node486_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_2_2 -p 479 -st topic486_2_1 -pt None -u 0.12134477991554524 > ./result_4chains/node486_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node486_3_2 -p 893 -st topic486_3_1 -pt None -u 0.08917283156993124 > ./result_4chains/node486_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_0_0 -p 46 -st none -pt topic486_0_0 -u 0.003312101501883491 > ./result_4chains/node486_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node486_1_0 -p 319 -st none -pt topic486_1_0 -u 0.06107217560708195 > ./result_4chains/node486_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_2_0 -p 479 -st none -pt topic486_2_0 -u 0.043115855081547694 > ./result_4chains/node486_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node486_3_0 -p 893 -st none -pt topic486_3_0 -u 0.005131020851479651 > ./result_4chains/node486_3_0.txt &
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
    "./result_4chains/node486_0_0.txt 90"
    "./result_4chains/node486_0_2.txt 90"
    "./result_4chains/node486_1_0.txt 89"
    "./result_4chains/node486_1_2.txt 89"
    "./result_4chains/node486_2_0.txt 88"
    "./result_4chains/node486_2_2.txt 88"
    "./result_4chains/node486_3_0.txt 87"
    "./result_4chains/node486_3_2.txt 87"
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
