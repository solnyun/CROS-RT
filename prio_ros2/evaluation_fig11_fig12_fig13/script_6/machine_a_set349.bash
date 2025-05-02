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
ros2 run evaluation_3_randomdag uunifast_node -n node349_0_2 -p 192 -st topic349_0_1 -pt None -u 0.01832805240527402 > ./result_6chains/node349_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_1_2 -p 321 -st topic349_1_1 -pt None -u 0.017431184360178653 > ./result_6chains/node349_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_2_2 -p 696 -st topic349_2_1 -pt None -u 0.006240161643159325 > ./result_6chains/node349_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_3_2 -p 822 -st topic349_3_1 -pt None -u 0.036198448489581286 > ./result_6chains/node349_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_4_2 -p 950 -st topic349_4_1 -pt None -u 0.022252333184471243 > ./result_6chains/node349_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_5_2 -p 969 -st topic349_5_1 -pt None -u 0.03098174459385275 > ./result_6chains/node349_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_0_0 -p 192 -st none -pt topic349_0_0 -u 0.035671828058217725 > ./result_6chains/node349_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_1_0 -p 321 -st none -pt topic349_1_0 -u 0.0009473686548932547 > ./result_6chains/node349_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_2_0 -p 696 -st none -pt topic349_2_0 -u 0.024241501507011598 > ./result_6chains/node349_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_3_0 -p 822 -st none -pt topic349_3_0 -u 0.02603517503304517 > ./result_6chains/node349_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_4_0 -p 950 -st none -pt topic349_4_0 -u 0.0018440206460392239 > ./result_6chains/node349_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_5_0 -p 969 -st none -pt topic349_5_0 -u 0.030949889483380982 > ./result_6chains/node349_5_0.txt &
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
    "./result_6chains/node349_0_0.txt 90"
    "./result_6chains/node349_0_2.txt 90"
    "./result_6chains/node349_1_0.txt 89"
    "./result_6chains/node349_1_2.txt 89"
    "./result_6chains/node349_2_0.txt 88"
    "./result_6chains/node349_2_2.txt 88"
    "./result_6chains/node349_3_0.txt 87"
    "./result_6chains/node349_3_2.txt 87"
    "./result_6chains/node349_4_0.txt 86"
    "./result_6chains/node349_4_2.txt 86"
    "./result_6chains/node349_5_0.txt 85"
    "./result_6chains/node349_5_2.txt 85"
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
