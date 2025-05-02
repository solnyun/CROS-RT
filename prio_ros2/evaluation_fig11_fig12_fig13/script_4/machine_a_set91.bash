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
ros2 run evaluation_3_randomdag uunifast_node -n node91_0_2 -p 262 -st topic91_0_1 -pt None -u 0.006342992607407394 > ./result_4chains/node91_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_1_2 -p 630 -st topic91_1_1 -pt None -u 0.0625933807072061 > ./result_4chains/node91_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_2_2 -p 658 -st topic91_2_1 -pt None -u 0.04155399932816245 > ./result_4chains/node91_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_3_2 -p 958 -st topic91_3_1 -pt None -u 0.13544989369422686 > ./result_4chains/node91_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_0_0 -p 262 -st none -pt topic91_0_0 -u 0.05930676775186566 > ./result_4chains/node91_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_1_0 -p 630 -st none -pt topic91_1_0 -u 0.02838330176502102 > ./result_4chains/node91_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_2_0 -p 658 -st none -pt topic91_2_0 -u 0.016484038709856264 > ./result_4chains/node91_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_3_0 -p 958 -st none -pt topic91_3_0 -u 0.014769369503385976 > ./result_4chains/node91_3_0.txt &
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
    "./result_4chains/node91_0_0.txt 90"
    "./result_4chains/node91_0_2.txt 90"
    "./result_4chains/node91_1_0.txt 89"
    "./result_4chains/node91_1_2.txt 89"
    "./result_4chains/node91_2_0.txt 88"
    "./result_4chains/node91_2_2.txt 88"
    "./result_4chains/node91_3_0.txt 87"
    "./result_4chains/node91_3_2.txt 87"
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
