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
ros2 run evaluation_3_randomdag uunifast_node -n node400_0_2 -p 137 -st topic400_0_1 -pt None -u 0.011518675363065833 > ./result_6chains/node400_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_1_2 -p 436 -st topic400_1_1 -pt None -u 0.013559853710273795 > ./result_6chains/node400_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_2_2 -p 644 -st topic400_2_1 -pt None -u 0.005554394643879773 > ./result_6chains/node400_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_3_2 -p 659 -st topic400_3_1 -pt None -u 0.012865283752264756 > ./result_6chains/node400_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_4_2 -p 923 -st topic400_4_1 -pt None -u 0.019943359860658448 > ./result_6chains/node400_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_5_2 -p 937 -st topic400_5_1 -pt None -u 0.0005681770171767467 > ./result_6chains/node400_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_0_0 -p 137 -st none -pt topic400_0_0 -u 0.03194614220100922 > ./result_6chains/node400_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_1_0 -p 436 -st none -pt topic400_1_0 -u 0.023962094171233406 > ./result_6chains/node400_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_2_0 -p 644 -st none -pt topic400_2_0 -u 0.01758997863838574 > ./result_6chains/node400_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_3_0 -p 659 -st none -pt topic400_3_0 -u 0.024069899011286255 > ./result_6chains/node400_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_4_0 -p 923 -st none -pt topic400_4_0 -u 0.012903240739511351 > ./result_6chains/node400_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_5_0 -p 937 -st none -pt topic400_5_0 -u 0.015797969379903968 > ./result_6chains/node400_5_0.txt &
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
    "./result_6chains/node400_0_0.txt 90"
    "./result_6chains/node400_0_2.txt 90"
    "./result_6chains/node400_1_0.txt 89"
    "./result_6chains/node400_1_2.txt 89"
    "./result_6chains/node400_2_0.txt 88"
    "./result_6chains/node400_2_2.txt 88"
    "./result_6chains/node400_3_0.txt 87"
    "./result_6chains/node400_3_2.txt 87"
    "./result_6chains/node400_4_0.txt 86"
    "./result_6chains/node400_4_2.txt 86"
    "./result_6chains/node400_5_0.txt 85"
    "./result_6chains/node400_5_2.txt 85"
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
