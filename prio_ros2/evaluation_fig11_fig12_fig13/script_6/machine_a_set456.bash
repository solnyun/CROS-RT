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
ros2 run evaluation_3_randomdag uunifast_node -n node456_0_2 -p 82 -st topic456_0_1 -pt None -u 0.07554866707722208 > ./result_6chains/node456_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_1_2 -p 385 -st topic456_1_1 -pt None -u 0.0853164761036499 > ./result_6chains/node456_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_2_2 -p 434 -st topic456_2_1 -pt None -u 0.0016755029524089249 > ./result_6chains/node456_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_3_2 -p 602 -st topic456_3_1 -pt None -u 0.015959355104153278 > ./result_6chains/node456_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_4_2 -p 657 -st topic456_4_1 -pt None -u 0.025053276081528505 > ./result_6chains/node456_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_5_2 -p 946 -st topic456_5_1 -pt None -u 0.06175925998785337 > ./result_6chains/node456_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_0_0 -p 82 -st none -pt topic456_0_0 -u 0.0016171202364283488 > ./result_6chains/node456_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_1_0 -p 385 -st none -pt topic456_1_0 -u 0.005298573519633365 > ./result_6chains/node456_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_2_0 -p 434 -st none -pt topic456_2_0 -u 0.008596026660779021 > ./result_6chains/node456_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_3_0 -p 602 -st none -pt topic456_3_0 -u 0.04058061789728551 > ./result_6chains/node456_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_4_0 -p 657 -st none -pt topic456_4_0 -u 0.04264007118874491 > ./result_6chains/node456_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_5_0 -p 946 -st none -pt topic456_5_0 -u 0.016967568722982218 > ./result_6chains/node456_5_0.txt &
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
    "./result_6chains/node456_0_0.txt 90"
    "./result_6chains/node456_0_2.txt 90"
    "./result_6chains/node456_1_0.txt 89"
    "./result_6chains/node456_1_2.txt 89"
    "./result_6chains/node456_2_0.txt 88"
    "./result_6chains/node456_2_2.txt 88"
    "./result_6chains/node456_3_0.txt 87"
    "./result_6chains/node456_3_2.txt 87"
    "./result_6chains/node456_4_0.txt 86"
    "./result_6chains/node456_4_2.txt 86"
    "./result_6chains/node456_5_0.txt 85"
    "./result_6chains/node456_5_2.txt 85"
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
