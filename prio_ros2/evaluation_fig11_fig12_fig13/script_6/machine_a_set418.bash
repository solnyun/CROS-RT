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
ros2 run evaluation_3_randomdag uunifast_node -n node418_0_2 -p 28 -st topic418_0_1 -pt None -u 0.0022596270520379713 > ./result_6chains/node418_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_1_2 -p 246 -st topic418_1_1 -pt None -u 0.022646261631324716 > ./result_6chains/node418_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_2_2 -p 451 -st topic418_2_1 -pt None -u 0.017429322742765097 > ./result_6chains/node418_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_3_2 -p 584 -st topic418_3_1 -pt None -u 0.09412443734826256 > ./result_6chains/node418_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_4_2 -p 749 -st topic418_4_1 -pt None -u 0.008585744810972074 > ./result_6chains/node418_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_5_2 -p 793 -st topic418_5_1 -pt None -u 0.06454649515342384 > ./result_6chains/node418_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_0_0 -p 28 -st none -pt topic418_0_0 -u 0.027628770943801395 > ./result_6chains/node418_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_1_0 -p 246 -st none -pt topic418_1_0 -u 0.032242957968230346 > ./result_6chains/node418_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_2_0 -p 451 -st none -pt topic418_2_0 -u 0.05686464275211167 > ./result_6chains/node418_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_3_0 -p 584 -st none -pt topic418_3_0 -u 0.06142236139622731 > ./result_6chains/node418_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_4_0 -p 749 -st none -pt topic418_4_0 -u 0.005075209274304576 > ./result_6chains/node418_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_5_0 -p 793 -st none -pt topic418_5_0 -u 0.02475921346330258 > ./result_6chains/node418_5_0.txt &
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
    "./result_6chains/node418_0_0.txt 90"
    "./result_6chains/node418_0_2.txt 90"
    "./result_6chains/node418_1_0.txt 89"
    "./result_6chains/node418_1_2.txt 89"
    "./result_6chains/node418_2_0.txt 88"
    "./result_6chains/node418_2_2.txt 88"
    "./result_6chains/node418_3_0.txt 87"
    "./result_6chains/node418_3_2.txt 87"
    "./result_6chains/node418_4_0.txt 86"
    "./result_6chains/node418_4_2.txt 86"
    "./result_6chains/node418_5_0.txt 85"
    "./result_6chains/node418_5_2.txt 85"
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
