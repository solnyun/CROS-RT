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
ros2 run evaluation_3_randomdag uunifast_node -n node132_0_2 -p 220 -st topic132_0_1 -pt None -u 0.0031312339416031953 > ./result_6chains/node132_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_1_2 -p 270 -st topic132_1_1 -pt None -u 0.08275449736750384 > ./result_6chains/node132_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_2_2 -p 379 -st topic132_2_1 -pt None -u 0.0008635969500521701 > ./result_6chains/node132_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_3_2 -p 529 -st topic132_3_1 -pt None -u 0.0204510827248105 > ./result_6chains/node132_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_4_2 -p 918 -st topic132_4_1 -pt None -u 0.07566477180283472 > ./result_6chains/node132_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_5_2 -p 942 -st topic132_5_1 -pt None -u 0.03441271036082651 > ./result_6chains/node132_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_0_0 -p 220 -st none -pt topic132_0_0 -u 0.0013112960262706141 > ./result_6chains/node132_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_1_0 -p 270 -st none -pt topic132_1_0 -u 0.01242795573577743 > ./result_6chains/node132_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_2_0 -p 379 -st none -pt topic132_2_0 -u 0.026380686786762864 > ./result_6chains/node132_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_3_0 -p 529 -st none -pt topic132_3_0 -u 0.05654437849057026 > ./result_6chains/node132_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_4_0 -p 918 -st none -pt topic132_4_0 -u 0.00373028901504438 > ./result_6chains/node132_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_5_0 -p 942 -st none -pt topic132_5_0 -u 0.019650645436383084 > ./result_6chains/node132_5_0.txt &
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
    "./result_6chains/node132_0_0.txt 90"
    "./result_6chains/node132_0_2.txt 90"
    "./result_6chains/node132_1_0.txt 89"
    "./result_6chains/node132_1_2.txt 89"
    "./result_6chains/node132_2_0.txt 88"
    "./result_6chains/node132_2_2.txt 88"
    "./result_6chains/node132_3_0.txt 87"
    "./result_6chains/node132_3_2.txt 87"
    "./result_6chains/node132_4_0.txt 86"
    "./result_6chains/node132_4_2.txt 86"
    "./result_6chains/node132_5_0.txt 85"
    "./result_6chains/node132_5_2.txt 85"
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
