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
ros2 run evaluation_3_randomdag uunifast_node -n node431_0_2 -p 97 -st topic431_0_1 -pt None -u 0.043977351759623806 > ./result_6chains/node431_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_1_2 -p 574 -st topic431_1_1 -pt None -u 0.10064788785153603 > ./result_6chains/node431_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_2_2 -p 678 -st topic431_2_1 -pt None -u 0.011741601626268 > ./result_6chains/node431_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_3_2 -p 751 -st topic431_3_1 -pt None -u 0.014879493974448446 > ./result_6chains/node431_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_4_2 -p 815 -st topic431_4_1 -pt None -u 0.010905131970070973 > ./result_6chains/node431_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_5_2 -p 914 -st topic431_5_1 -pt None -u 0.007955067385444967 > ./result_6chains/node431_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_0_0 -p 97 -st none -pt topic431_0_0 -u 0.07161873155819132 > ./result_6chains/node431_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_1_0 -p 574 -st none -pt topic431_1_0 -u 0.024972266787927466 > ./result_6chains/node431_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_2_0 -p 678 -st none -pt topic431_2_0 -u 0.03412789644061648 > ./result_6chains/node431_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_3_0 -p 751 -st none -pt topic431_3_0 -u 0.013479445599915763 > ./result_6chains/node431_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_4_0 -p 815 -st none -pt topic431_4_0 -u 0.036113684463124185 > ./result_6chains/node431_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_5_0 -p 914 -st none -pt topic431_5_0 -u 0.005470784746360216 > ./result_6chains/node431_5_0.txt &
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
    "./result_6chains/node431_0_0.txt 90"
    "./result_6chains/node431_0_2.txt 90"
    "./result_6chains/node431_1_0.txt 89"
    "./result_6chains/node431_1_2.txt 89"
    "./result_6chains/node431_2_0.txt 88"
    "./result_6chains/node431_2_2.txt 88"
    "./result_6chains/node431_3_0.txt 87"
    "./result_6chains/node431_3_2.txt 87"
    "./result_6chains/node431_4_0.txt 86"
    "./result_6chains/node431_4_2.txt 86"
    "./result_6chains/node431_5_0.txt 85"
    "./result_6chains/node431_5_2.txt 85"
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
