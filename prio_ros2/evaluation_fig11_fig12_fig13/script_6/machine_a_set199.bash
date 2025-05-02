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
ros2 run evaluation_3_randomdag uunifast_node -n node199_0_2 -p 279 -st topic199_0_1 -pt None -u 0.01817231640321587 > ./result_6chains/node199_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_1_2 -p 551 -st topic199_1_1 -pt None -u 0.053743457793010985 > ./result_6chains/node199_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_2_2 -p 563 -st topic199_2_1 -pt None -u 0.017246715001899893 > ./result_6chains/node199_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_3_2 -p 658 -st topic199_3_1 -pt None -u 0.00022099519615390029 > ./result_6chains/node199_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_4_2 -p 663 -st topic199_4_1 -pt None -u 0.023214495868143448 > ./result_6chains/node199_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_5_2 -p 866 -st topic199_5_1 -pt None -u 0.028694978231756502 > ./result_6chains/node199_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_0_0 -p 279 -st none -pt topic199_0_0 -u 0.01304857838088641 > ./result_6chains/node199_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_1_0 -p 551 -st none -pt topic199_1_0 -u 0.00972924995429425 > ./result_6chains/node199_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_2_0 -p 563 -st none -pt topic199_2_0 -u 0.09010526949567954 > ./result_6chains/node199_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_3_0 -p 658 -st none -pt topic199_3_0 -u 0.06023808385416893 > ./result_6chains/node199_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_4_0 -p 663 -st none -pt topic199_4_0 -u 0.013843878039303426 > ./result_6chains/node199_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_5_0 -p 866 -st none -pt topic199_5_0 -u 0.008578545235634671 > ./result_6chains/node199_5_0.txt &
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
    "./result_6chains/node199_0_0.txt 90"
    "./result_6chains/node199_0_2.txt 90"
    "./result_6chains/node199_1_0.txt 89"
    "./result_6chains/node199_1_2.txt 89"
    "./result_6chains/node199_2_0.txt 88"
    "./result_6chains/node199_2_2.txt 88"
    "./result_6chains/node199_3_0.txt 87"
    "./result_6chains/node199_3_2.txt 87"
    "./result_6chains/node199_4_0.txt 86"
    "./result_6chains/node199_4_2.txt 86"
    "./result_6chains/node199_5_0.txt 85"
    "./result_6chains/node199_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
