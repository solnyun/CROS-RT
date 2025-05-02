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
ros2 run evaluation_3_randomdag uunifast_node -n node64_0_2 -p 114 -st topic64_0_1 -pt None -u 0.0036640009941030782 > ./result_6chains/node64_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_1_2 -p 316 -st topic64_1_1 -pt None -u 0.0321340423724652 > ./result_6chains/node64_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_2_2 -p 420 -st topic64_2_1 -pt None -u 0.06394313379477995 > ./result_6chains/node64_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_3_2 -p 498 -st topic64_3_1 -pt None -u 0.05322425021689087 > ./result_6chains/node64_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_4_2 -p 549 -st topic64_4_1 -pt None -u 0.0007070802940406656 > ./result_6chains/node64_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_5_2 -p 811 -st topic64_5_1 -pt None -u 0.015345955660253343 > ./result_6chains/node64_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_0_0 -p 114 -st none -pt topic64_0_0 -u 0.00042196422053980553 > ./result_6chains/node64_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_1_0 -p 316 -st none -pt topic64_1_0 -u 0.012099876594753478 > ./result_6chains/node64_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_2_0 -p 420 -st none -pt topic64_2_0 -u 0.06116743607711511 > ./result_6chains/node64_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_3_0 -p 498 -st none -pt topic64_3_0 -u 0.09091565940902233 > ./result_6chains/node64_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_4_0 -p 549 -st none -pt topic64_4_0 -u 0.013797358962661349 > ./result_6chains/node64_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_5_0 -p 811 -st none -pt topic64_5_0 -u 0.04781859770475159 > ./result_6chains/node64_5_0.txt &
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
    "./result_6chains/node64_0_0.txt 90"
    "./result_6chains/node64_0_2.txt 90"
    "./result_6chains/node64_1_0.txt 89"
    "./result_6chains/node64_1_2.txt 89"
    "./result_6chains/node64_2_0.txt 88"
    "./result_6chains/node64_2_2.txt 88"
    "./result_6chains/node64_3_0.txt 87"
    "./result_6chains/node64_3_2.txt 87"
    "./result_6chains/node64_4_0.txt 86"
    "./result_6chains/node64_4_2.txt 86"
    "./result_6chains/node64_5_0.txt 85"
    "./result_6chains/node64_5_2.txt 85"
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
