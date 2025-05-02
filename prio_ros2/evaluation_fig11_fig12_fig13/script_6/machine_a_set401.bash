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
ros2 run evaluation_3_randomdag uunifast_node -n node401_0_2 -p 176 -st topic401_0_1 -pt None -u 0.03227812227525151 > ./result_6chains/node401_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_1_2 -p 221 -st topic401_1_1 -pt None -u 0.12692831597487716 > ./result_6chains/node401_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_2_2 -p 455 -st topic401_2_1 -pt None -u 0.008185463985145247 > ./result_6chains/node401_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_3_2 -p 497 -st topic401_3_1 -pt None -u 0.024292057592144617 > ./result_6chains/node401_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_4_2 -p 514 -st topic401_4_1 -pt None -u 0.031540671143772334 > ./result_6chains/node401_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_5_2 -p 957 -st topic401_5_1 -pt None -u 0.04234457180584369 > ./result_6chains/node401_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_0_0 -p 176 -st none -pt topic401_0_0 -u 0.03007964921966816 > ./result_6chains/node401_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_1_0 -p 221 -st none -pt topic401_1_0 -u 0.033532689939425986 > ./result_6chains/node401_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_2_0 -p 455 -st none -pt topic401_2_0 -u 0.0354784379885931 > ./result_6chains/node401_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_3_0 -p 497 -st none -pt topic401_3_0 -u 0.004483270583222176 > ./result_6chains/node401_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_4_0 -p 514 -st none -pt topic401_4_0 -u 0.0225149719972748 > ./result_6chains/node401_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_5_0 -p 957 -st none -pt topic401_5_0 -u 0.00838954759205953 > ./result_6chains/node401_5_0.txt &
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
    "./result_6chains/node401_0_0.txt 90"
    "./result_6chains/node401_0_2.txt 90"
    "./result_6chains/node401_1_0.txt 89"
    "./result_6chains/node401_1_2.txt 89"
    "./result_6chains/node401_2_0.txt 88"
    "./result_6chains/node401_2_2.txt 88"
    "./result_6chains/node401_3_0.txt 87"
    "./result_6chains/node401_3_2.txt 87"
    "./result_6chains/node401_4_0.txt 86"
    "./result_6chains/node401_4_2.txt 86"
    "./result_6chains/node401_5_0.txt 85"
    "./result_6chains/node401_5_2.txt 85"
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
