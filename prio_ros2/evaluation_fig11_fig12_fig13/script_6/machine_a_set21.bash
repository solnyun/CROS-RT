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
ros2 run evaluation_3_randomdag uunifast_node -n node21_0_2 -p 83 -st topic21_0_1 -pt None -u 0.00526988847435389 > ./result_6chains/node21_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_1_2 -p 215 -st topic21_1_1 -pt None -u 0.0538390237824663 > ./result_6chains/node21_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_2_2 -p 595 -st topic21_2_1 -pt None -u 0.029976558239937834 > ./result_6chains/node21_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_3_2 -p 676 -st topic21_3_1 -pt None -u 0.0034473834769887524 > ./result_6chains/node21_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_4_2 -p 728 -st topic21_4_1 -pt None -u 0.016104035272695924 > ./result_6chains/node21_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_5_2 -p 850 -st topic21_5_1 -pt None -u 0.05272313614961927 > ./result_6chains/node21_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_0_0 -p 83 -st none -pt topic21_0_0 -u 0.012302327571569238 > ./result_6chains/node21_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_1_0 -p 215 -st none -pt topic21_1_0 -u 0.03401158412444183 > ./result_6chains/node21_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_2_0 -p 595 -st none -pt topic21_2_0 -u 0.0024458350216556846 > ./result_6chains/node21_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_3_0 -p 676 -st none -pt topic21_3_0 -u 0.07109526601839156 > ./result_6chains/node21_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_4_0 -p 728 -st none -pt topic21_4_0 -u 0.1022852383501206 > ./result_6chains/node21_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_5_0 -p 850 -st none -pt topic21_5_0 -u 0.04271323990301852 > ./result_6chains/node21_5_0.txt &
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
    "./result_6chains/node21_0_0.txt 90"
    "./result_6chains/node21_0_2.txt 90"
    "./result_6chains/node21_1_0.txt 89"
    "./result_6chains/node21_1_2.txt 89"
    "./result_6chains/node21_2_0.txt 88"
    "./result_6chains/node21_2_2.txt 88"
    "./result_6chains/node21_3_0.txt 87"
    "./result_6chains/node21_3_2.txt 87"
    "./result_6chains/node21_4_0.txt 86"
    "./result_6chains/node21_4_2.txt 86"
    "./result_6chains/node21_5_0.txt 85"
    "./result_6chains/node21_5_2.txt 85"
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
