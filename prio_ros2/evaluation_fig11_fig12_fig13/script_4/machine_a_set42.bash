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
ros2 run evaluation_3_randomdag uunifast_node -n node42_0_2 -p 352 -st topic42_0_1 -pt None -u 0.06671401604975016 > ./result_4chains/node42_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_1_2 -p 479 -st topic42_1_1 -pt None -u 0.02249266866189517 > ./result_4chains/node42_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_2_2 -p 777 -st topic42_2_1 -pt None -u 0.028505055128739465 > ./result_4chains/node42_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_3_2 -p 862 -st topic42_3_1 -pt None -u 0.022585601603271218 > ./result_4chains/node42_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_0_0 -p 352 -st none -pt topic42_0_0 -u 0.1026147670635364 > ./result_4chains/node42_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_1_0 -p 479 -st none -pt topic42_1_0 -u 0.0314289474397971 > ./result_4chains/node42_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_2_0 -p 777 -st none -pt topic42_2_0 -u 0.00336277983997027 > ./result_4chains/node42_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_3_0 -p 862 -st none -pt topic42_3_0 -u 0.009280290867727217 > ./result_4chains/node42_3_0.txt &
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
    "./result_4chains/node42_0_0.txt 90"
    "./result_4chains/node42_0_2.txt 90"
    "./result_4chains/node42_1_0.txt 89"
    "./result_4chains/node42_1_2.txt 89"
    "./result_4chains/node42_2_0.txt 88"
    "./result_4chains/node42_2_2.txt 88"
    "./result_4chains/node42_3_0.txt 87"
    "./result_4chains/node42_3_2.txt 87"
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
sleep 70s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 40s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
