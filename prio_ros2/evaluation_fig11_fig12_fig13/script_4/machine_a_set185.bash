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
ros2 run evaluation_3_randomdag uunifast_node -n node185_0_2 -p 46 -st topic185_0_1 -pt None -u 0.02266804169142911 > ./result_4chains/node185_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_1_2 -p 94 -st topic185_1_1 -pt None -u 0.031272066649284 > ./result_4chains/node185_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_2_2 -p 133 -st topic185_2_1 -pt None -u 0.04634772860437493 > ./result_4chains/node185_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_3_2 -p 990 -st topic185_3_1 -pt None -u 0.011193915588649878 > ./result_4chains/node185_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_0_0 -p 46 -st none -pt topic185_0_0 -u 0.0015011228808216037 > ./result_4chains/node185_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_1_0 -p 94 -st none -pt topic185_1_0 -u 0.1229103047579338 > ./result_4chains/node185_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_2_0 -p 133 -st none -pt topic185_2_0 -u 0.14182084160630926 > ./result_4chains/node185_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_3_0 -p 990 -st none -pt topic185_3_0 -u 0.012867867109743466 > ./result_4chains/node185_3_0.txt &
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
    "./result_4chains/node185_0_0.txt 90"
    "./result_4chains/node185_0_2.txt 90"
    "./result_4chains/node185_1_0.txt 89"
    "./result_4chains/node185_1_2.txt 89"
    "./result_4chains/node185_2_0.txt 88"
    "./result_4chains/node185_2_2.txt 88"
    "./result_4chains/node185_3_0.txt 87"
    "./result_4chains/node185_3_2.txt 87"
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
