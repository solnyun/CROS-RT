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
ros2 run evaluation_3_randomdag uunifast_node -n node497_0_2 -p 158 -st topic497_0_1 -pt None -u 0.005045842275561319 > ./result_6chains/node497_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_1_2 -p 438 -st topic497_1_1 -pt None -u 0.011141983903492025 > ./result_6chains/node497_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_2_2 -p 645 -st topic497_2_1 -pt None -u 0.027494428261725046 > ./result_6chains/node497_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_3_2 -p 769 -st topic497_3_1 -pt None -u 0.0308083931047006 > ./result_6chains/node497_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_4_2 -p 780 -st topic497_4_1 -pt None -u 0.0018141355414804453 > ./result_6chains/node497_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_5_2 -p 930 -st topic497_5_1 -pt None -u 0.0014043406782705621 > ./result_6chains/node497_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_0_0 -p 158 -st none -pt topic497_0_0 -u 0.007020939027988282 > ./result_6chains/node497_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_1_0 -p 438 -st none -pt topic497_1_0 -u 0.03600084933462633 > ./result_6chains/node497_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_2_0 -p 645 -st none -pt topic497_2_0 -u 0.17428613301139229 > ./result_6chains/node497_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_3_0 -p 769 -st none -pt topic497_3_0 -u 0.06412792968698011 > ./result_6chains/node497_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_4_0 -p 780 -st none -pt topic497_4_0 -u 0.004284039926047534 > ./result_6chains/node497_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_5_0 -p 930 -st none -pt topic497_5_0 -u 0.001544898178516059 > ./result_6chains/node497_5_0.txt &
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
    "./result_6chains/node497_0_0.txt 90"
    "./result_6chains/node497_0_2.txt 90"
    "./result_6chains/node497_1_0.txt 89"
    "./result_6chains/node497_1_2.txt 89"
    "./result_6chains/node497_2_0.txt 88"
    "./result_6chains/node497_2_2.txt 88"
    "./result_6chains/node497_3_0.txt 87"
    "./result_6chains/node497_3_2.txt 87"
    "./result_6chains/node497_4_0.txt 86"
    "./result_6chains/node497_4_2.txt 86"
    "./result_6chains/node497_5_0.txt 85"
    "./result_6chains/node497_5_2.txt 85"
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
