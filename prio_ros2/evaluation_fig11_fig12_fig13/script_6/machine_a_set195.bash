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
ros2 run evaluation_3_randomdag uunifast_node -n node195_0_2 -p 240 -st topic195_0_1 -pt None -u 0.030883429233906357 > ./result_6chains/node195_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_1_2 -p 408 -st topic195_1_1 -pt None -u 0.09385565719800204 > ./result_6chains/node195_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_2_2 -p 424 -st topic195_2_1 -pt None -u 0.031482129765477374 > ./result_6chains/node195_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_3_2 -p 466 -st topic195_3_1 -pt None -u 0.05486587487190106 > ./result_6chains/node195_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_4_2 -p 834 -st topic195_4_1 -pt None -u 0.0011898772245838851 > ./result_6chains/node195_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_5_2 -p 918 -st topic195_5_1 -pt None -u 0.03135009623714804 > ./result_6chains/node195_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_0_0 -p 240 -st none -pt topic195_0_0 -u 0.0403448727379232 > ./result_6chains/node195_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_1_0 -p 408 -st none -pt topic195_1_0 -u 0.00620776125243333 > ./result_6chains/node195_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_2_0 -p 424 -st none -pt topic195_2_0 -u 0.01136706434205803 > ./result_6chains/node195_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_3_0 -p 466 -st none -pt topic195_3_0 -u 0.008337461561049614 > ./result_6chains/node195_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_4_0 -p 834 -st none -pt topic195_4_0 -u 0.01988181919068205 > ./result_6chains/node195_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_5_0 -p 918 -st none -pt topic195_5_0 -u 0.008605032872571208 > ./result_6chains/node195_5_0.txt &
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
    "./result_6chains/node195_0_0.txt 90"
    "./result_6chains/node195_0_2.txt 90"
    "./result_6chains/node195_1_0.txt 89"
    "./result_6chains/node195_1_2.txt 89"
    "./result_6chains/node195_2_0.txt 88"
    "./result_6chains/node195_2_2.txt 88"
    "./result_6chains/node195_3_0.txt 87"
    "./result_6chains/node195_3_2.txt 87"
    "./result_6chains/node195_4_0.txt 86"
    "./result_6chains/node195_4_2.txt 86"
    "./result_6chains/node195_5_0.txt 85"
    "./result_6chains/node195_5_2.txt 85"
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
