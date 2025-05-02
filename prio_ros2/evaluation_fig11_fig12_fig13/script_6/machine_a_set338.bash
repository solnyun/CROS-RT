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
ros2 run evaluation_3_randomdag uunifast_node -n node338_0_2 -p 98 -st topic338_0_1 -pt None -u 0.016345956676262652 > ./result_6chains/node338_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_1_2 -p 453 -st topic338_1_1 -pt None -u 0.023112177145401314 > ./result_6chains/node338_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_2_2 -p 610 -st topic338_2_1 -pt None -u 0.02796294012473799 > ./result_6chains/node338_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_3_2 -p 769 -st topic338_3_1 -pt None -u 0.00019827054769935848 > ./result_6chains/node338_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_4_2 -p 869 -st topic338_4_1 -pt None -u 0.006038565088885776 > ./result_6chains/node338_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_5_2 -p 936 -st topic338_5_1 -pt None -u 0.010570826711334762 > ./result_6chains/node338_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_0_0 -p 98 -st none -pt topic338_0_0 -u 0.006309869618900954 > ./result_6chains/node338_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_1_0 -p 453 -st none -pt topic338_1_0 -u 0.0277671089599566 > ./result_6chains/node338_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_2_0 -p 610 -st none -pt topic338_2_0 -u 0.01741593096154065 > ./result_6chains/node338_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_3_0 -p 769 -st none -pt topic338_3_0 -u 0.051368148720175685 > ./result_6chains/node338_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_4_0 -p 869 -st none -pt topic338_4_0 -u 0.0027149895154938986 > ./result_6chains/node338_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_5_0 -p 936 -st none -pt topic338_5_0 -u 0.0425358831309433 > ./result_6chains/node338_5_0.txt &
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
    "./result_6chains/node338_0_0.txt 90"
    "./result_6chains/node338_0_2.txt 90"
    "./result_6chains/node338_1_0.txt 89"
    "./result_6chains/node338_1_2.txt 89"
    "./result_6chains/node338_2_0.txt 88"
    "./result_6chains/node338_2_2.txt 88"
    "./result_6chains/node338_3_0.txt 87"
    "./result_6chains/node338_3_2.txt 87"
    "./result_6chains/node338_4_0.txt 86"
    "./result_6chains/node338_4_2.txt 86"
    "./result_6chains/node338_5_0.txt 85"
    "./result_6chains/node338_5_2.txt 85"
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
