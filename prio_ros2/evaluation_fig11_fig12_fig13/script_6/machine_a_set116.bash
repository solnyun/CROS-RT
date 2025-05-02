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
ros2 run evaluation_3_randomdag uunifast_node -n node116_0_2 -p 44 -st topic116_0_1 -pt None -u 0.06502354660370874 > ./result_6chains/node116_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_1_2 -p 153 -st topic116_1_1 -pt None -u 0.03267735316004278 > ./result_6chains/node116_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_2_2 -p 174 -st topic116_2_1 -pt None -u 0.008649660682380877 > ./result_6chains/node116_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_3_2 -p 221 -st topic116_3_1 -pt None -u 0.05876823831690925 > ./result_6chains/node116_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_4_2 -p 314 -st topic116_4_1 -pt None -u 0.015560980974692377 > ./result_6chains/node116_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_5_2 -p 913 -st topic116_5_1 -pt None -u 0.0023566513669865106 > ./result_6chains/node116_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_0_0 -p 44 -st none -pt topic116_0_0 -u 0.03085603444948698 > ./result_6chains/node116_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_1_0 -p 153 -st none -pt topic116_1_0 -u 0.024282595514473426 > ./result_6chains/node116_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_2_0 -p 174 -st none -pt topic116_2_0 -u 0.005617644970905167 > ./result_6chains/node116_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_3_0 -p 221 -st none -pt topic116_3_0 -u 0.014871662435440663 > ./result_6chains/node116_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_4_0 -p 314 -st none -pt topic116_4_0 -u 0.05301588539055056 > ./result_6chains/node116_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_5_0 -p 913 -st none -pt topic116_5_0 -u 0.008856732883180882 > ./result_6chains/node116_5_0.txt &
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
    "./result_6chains/node116_0_0.txt 90"
    "./result_6chains/node116_0_2.txt 90"
    "./result_6chains/node116_1_0.txt 89"
    "./result_6chains/node116_1_2.txt 89"
    "./result_6chains/node116_2_0.txt 88"
    "./result_6chains/node116_2_2.txt 88"
    "./result_6chains/node116_3_0.txt 87"
    "./result_6chains/node116_3_2.txt 87"
    "./result_6chains/node116_4_0.txt 86"
    "./result_6chains/node116_4_2.txt 86"
    "./result_6chains/node116_5_0.txt 85"
    "./result_6chains/node116_5_2.txt 85"
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
