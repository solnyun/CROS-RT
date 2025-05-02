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
ros2 run evaluation_3_randomdag uunifast_node -n node27_0_2 -p 123 -st topic27_0_1 -pt None -u 0.061536250342998644 > ./result_6chains/node27_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_1_2 -p 183 -st topic27_1_1 -pt None -u 0.03354921624226004 > ./result_6chains/node27_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_2_2 -p 408 -st topic27_2_1 -pt None -u 0.02326329982630501 > ./result_6chains/node27_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_3_2 -p 414 -st topic27_3_1 -pt None -u 0.023861284424095658 > ./result_6chains/node27_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_4_2 -p 437 -st topic27_4_1 -pt None -u 0.0089557069215273 > ./result_6chains/node27_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_5_2 -p 867 -st topic27_5_1 -pt None -u 0.012526667288244111 > ./result_6chains/node27_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_0_0 -p 123 -st none -pt topic27_0_0 -u 0.03859570551573477 > ./result_6chains/node27_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_1_0 -p 183 -st none -pt topic27_1_0 -u 0.0025862335781047796 > ./result_6chains/node27_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_2_0 -p 408 -st none -pt topic27_2_0 -u 0.07521053023589896 > ./result_6chains/node27_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_3_0 -p 414 -st none -pt topic27_3_0 -u 0.055443259221339414 > ./result_6chains/node27_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_4_0 -p 437 -st none -pt topic27_4_0 -u 0.016715616441890888 > ./result_6chains/node27_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_5_0 -p 867 -st none -pt topic27_5_0 -u 0.020897900685405417 > ./result_6chains/node27_5_0.txt &
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
    "./result_6chains/node27_0_0.txt 90"
    "./result_6chains/node27_0_2.txt 90"
    "./result_6chains/node27_1_0.txt 89"
    "./result_6chains/node27_1_2.txt 89"
    "./result_6chains/node27_2_0.txt 88"
    "./result_6chains/node27_2_2.txt 88"
    "./result_6chains/node27_3_0.txt 87"
    "./result_6chains/node27_3_2.txt 87"
    "./result_6chains/node27_4_0.txt 86"
    "./result_6chains/node27_4_2.txt 86"
    "./result_6chains/node27_5_0.txt 85"
    "./result_6chains/node27_5_2.txt 85"
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
