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
ros2 run evaluation_3_randomdag uunifast_node -n node182_0_2 -p 236 -st topic182_0_1 -pt None -u 0.08071964059346737 > ./result_6chains/node182_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_1_2 -p 449 -st topic182_1_1 -pt None -u 0.010409802326749706 > ./result_6chains/node182_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_2_2 -p 508 -st topic182_2_1 -pt None -u 0.05769936357452354 > ./result_6chains/node182_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_3_2 -p 610 -st topic182_3_1 -pt None -u 0.012169292179457503 > ./result_6chains/node182_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_4_2 -p 675 -st topic182_4_1 -pt None -u 0.0472850212160429 > ./result_6chains/node182_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_5_2 -p 934 -st topic182_5_1 -pt None -u 0.01784196847602246 > ./result_6chains/node182_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_0_0 -p 236 -st none -pt topic182_0_0 -u 0.039903693415560604 > ./result_6chains/node182_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_1_0 -p 449 -st none -pt topic182_1_0 -u 0.03401705589108622 > ./result_6chains/node182_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_2_0 -p 508 -st none -pt topic182_2_0 -u 0.01599709290061241 > ./result_6chains/node182_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_3_0 -p 610 -st none -pt topic182_3_0 -u 0.04118458889410931 > ./result_6chains/node182_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_4_0 -p 675 -st none -pt topic182_4_0 -u 0.011148909820245578 > ./result_6chains/node182_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_5_0 -p 934 -st none -pt topic182_5_0 -u 0.02053295008856126 > ./result_6chains/node182_5_0.txt &
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
    "./result_6chains/node182_0_0.txt 90"
    "./result_6chains/node182_0_2.txt 90"
    "./result_6chains/node182_1_0.txt 89"
    "./result_6chains/node182_1_2.txt 89"
    "./result_6chains/node182_2_0.txt 88"
    "./result_6chains/node182_2_2.txt 88"
    "./result_6chains/node182_3_0.txt 87"
    "./result_6chains/node182_3_2.txt 87"
    "./result_6chains/node182_4_0.txt 86"
    "./result_6chains/node182_4_2.txt 86"
    "./result_6chains/node182_5_0.txt 85"
    "./result_6chains/node182_5_2.txt 85"
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
