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
ros2 run evaluation_3_randomdag uunifast_node -n node75_0_2 -p 64 -st topic75_0_1 -pt None -u 0.00703198679586492 > ./result_6chains/node75_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_1_2 -p 144 -st topic75_1_1 -pt None -u 0.007751600674057002 > ./result_6chains/node75_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_2_2 -p 391 -st topic75_2_1 -pt None -u 0.0464096036839981 > ./result_6chains/node75_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_3_2 -p 397 -st topic75_3_1 -pt None -u 0.010971482417820144 > ./result_6chains/node75_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_4_2 -p 791 -st topic75_4_1 -pt None -u 0.020551616582359045 > ./result_6chains/node75_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_5_2 -p 841 -st topic75_5_1 -pt None -u 0.14867597746901176 > ./result_6chains/node75_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_0_0 -p 64 -st none -pt topic75_0_0 -u 0.01909655353743317 > ./result_6chains/node75_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_1_0 -p 144 -st none -pt topic75_1_0 -u 0.01795845407064106 > ./result_6chains/node75_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_2_0 -p 391 -st none -pt topic75_2_0 -u 0.010980503328088864 > ./result_6chains/node75_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_3_0 -p 397 -st none -pt topic75_3_0 -u 0.018502747830389576 > ./result_6chains/node75_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_4_0 -p 791 -st none -pt topic75_4_0 -u 0.038094266698712825 > ./result_6chains/node75_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_5_0 -p 841 -st none -pt topic75_5_0 -u 0.005403566534164378 > ./result_6chains/node75_5_0.txt &
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
    "./result_6chains/node75_0_0.txt 90"
    "./result_6chains/node75_0_2.txt 90"
    "./result_6chains/node75_1_0.txt 89"
    "./result_6chains/node75_1_2.txt 89"
    "./result_6chains/node75_2_0.txt 88"
    "./result_6chains/node75_2_2.txt 88"
    "./result_6chains/node75_3_0.txt 87"
    "./result_6chains/node75_3_2.txt 87"
    "./result_6chains/node75_4_0.txt 86"
    "./result_6chains/node75_4_2.txt 86"
    "./result_6chains/node75_5_0.txt 85"
    "./result_6chains/node75_5_2.txt 85"
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
