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
ros2 run evaluation_3_randomdag uunifast_node -n node26_0_2 -p 257 -st topic26_0_1 -pt None -u 0.005163160309246795 > ./result_6chains/node26_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_1_2 -p 588 -st topic26_1_1 -pt None -u 0.0004755376969660663 > ./result_6chains/node26_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_2_2 -p 704 -st topic26_2_1 -pt None -u 0.08687194934618342 > ./result_6chains/node26_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_3_2 -p 839 -st topic26_3_1 -pt None -u 0.018277452906398067 > ./result_6chains/node26_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_4_2 -p 915 -st topic26_4_1 -pt None -u 0.024390708080740522 > ./result_6chains/node26_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_5_2 -p 955 -st topic26_5_1 -pt None -u 0.05134028085189596 > ./result_6chains/node26_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_0_0 -p 257 -st none -pt topic26_0_0 -u 2.037615166322615e-05 > ./result_6chains/node26_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_1_0 -p 588 -st none -pt topic26_1_0 -u 0.05466756564174646 > ./result_6chains/node26_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_2_0 -p 704 -st none -pt topic26_2_0 -u 0.01389820790213514 > ./result_6chains/node26_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_3_0 -p 839 -st none -pt topic26_3_0 -u 0.008616630847005091 > ./result_6chains/node26_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_4_0 -p 915 -st none -pt topic26_4_0 -u 0.020726640427604137 > ./result_6chains/node26_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_5_0 -p 955 -st none -pt topic26_5_0 -u 0.03232896263637687 > ./result_6chains/node26_5_0.txt &
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
    "./result_6chains/node26_0_0.txt 90"
    "./result_6chains/node26_0_2.txt 90"
    "./result_6chains/node26_1_0.txt 89"
    "./result_6chains/node26_1_2.txt 89"
    "./result_6chains/node26_2_0.txt 88"
    "./result_6chains/node26_2_2.txt 88"
    "./result_6chains/node26_3_0.txt 87"
    "./result_6chains/node26_3_2.txt 87"
    "./result_6chains/node26_4_0.txt 86"
    "./result_6chains/node26_4_2.txt 86"
    "./result_6chains/node26_5_0.txt 85"
    "./result_6chains/node26_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
