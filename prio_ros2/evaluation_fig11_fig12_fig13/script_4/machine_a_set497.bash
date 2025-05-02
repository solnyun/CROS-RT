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
ros2 run evaluation_3_randomdag uunifast_node -n node497_0_2 -p 161 -st topic497_0_1 -pt None -u 0.009531972578371128 > ./result_4chains/node497_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_1_2 -p 167 -st topic497_1_1 -pt None -u 0.09060255248447283 > ./result_4chains/node497_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_2_2 -p 697 -st topic497_2_1 -pt None -u 0.037956515609422786 > ./result_4chains/node497_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_3_2 -p 829 -st topic497_3_1 -pt None -u 0.013916275588245547 > ./result_4chains/node497_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_0_0 -p 161 -st none -pt topic497_0_0 -u 0.005962559468611017 > ./result_4chains/node497_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_1_0 -p 167 -st none -pt topic497_1_0 -u 0.0013251847013975304 > ./result_4chains/node497_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_2_0 -p 697 -st none -pt topic497_2_0 -u 0.048692912815225614 > ./result_4chains/node497_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_3_0 -p 829 -st none -pt topic497_3_0 -u 0.10745944587289336 > ./result_4chains/node497_3_0.txt &
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
    "./result_4chains/node497_0_0.txt 90"
    "./result_4chains/node497_0_2.txt 90"
    "./result_4chains/node497_1_0.txt 89"
    "./result_4chains/node497_1_2.txt 89"
    "./result_4chains/node497_2_0.txt 88"
    "./result_4chains/node497_2_2.txt 88"
    "./result_4chains/node497_3_0.txt 87"
    "./result_4chains/node497_3_2.txt 87"
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
