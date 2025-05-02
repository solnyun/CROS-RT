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
ros2 run evaluation_3_randomdag uunifast_node -n node180_0_2 -p 223 -st topic180_0_1 -pt None -u 0.02504996290295536 > ./result_4chains/node180_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_1_2 -p 377 -st topic180_1_1 -pt None -u 0.0479328018257823 > ./result_4chains/node180_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_2_2 -p 476 -st topic180_2_1 -pt None -u 0.02453433166783768 > ./result_4chains/node180_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_3_2 -p 630 -st topic180_3_1 -pt None -u 0.022897986017305798 > ./result_4chains/node180_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_0_0 -p 223 -st none -pt topic180_0_0 -u 0.001325671446926524 > ./result_4chains/node180_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_1_0 -p 377 -st none -pt topic180_1_0 -u 0.06436753945177043 > ./result_4chains/node180_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_2_0 -p 476 -st none -pt topic180_2_0 -u 0.11883673201198788 > ./result_4chains/node180_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_3_0 -p 630 -st none -pt topic180_3_0 -u 0.0016006695732226212 > ./result_4chains/node180_3_0.txt &
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
    "./result_4chains/node180_0_0.txt 90"
    "./result_4chains/node180_0_2.txt 90"
    "./result_4chains/node180_1_0.txt 89"
    "./result_4chains/node180_1_2.txt 89"
    "./result_4chains/node180_2_0.txt 88"
    "./result_4chains/node180_2_2.txt 88"
    "./result_4chains/node180_3_0.txt 87"
    "./result_4chains/node180_3_2.txt 87"
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
