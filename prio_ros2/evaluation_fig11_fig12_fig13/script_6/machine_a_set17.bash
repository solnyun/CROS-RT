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
ros2 run evaluation_3_randomdag uunifast_node -n node17_0_2 -p 338 -st topic17_0_1 -pt None -u 0.09042985770294831 > ./result_6chains/node17_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_1_2 -p 639 -st topic17_1_1 -pt None -u 0.003547956155082077 > ./result_6chains/node17_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_2_2 -p 646 -st topic17_2_1 -pt None -u 0.0017237470340637495 > ./result_6chains/node17_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_3_2 -p 921 -st topic17_3_1 -pt None -u 0.005611593694084427 > ./result_6chains/node17_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_4_2 -p 937 -st topic17_4_1 -pt None -u 0.012684703985480467 > ./result_6chains/node17_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_5_2 -p 962 -st topic17_5_1 -pt None -u 0.015211333874058956 > ./result_6chains/node17_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_0_0 -p 338 -st none -pt topic17_0_0 -u 0.010915463193232666 > ./result_6chains/node17_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_1_0 -p 639 -st none -pt topic17_1_0 -u 0.017671776082735235 > ./result_6chains/node17_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_2_0 -p 646 -st none -pt topic17_2_0 -u 0.008760553882040556 > ./result_6chains/node17_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_3_0 -p 921 -st none -pt topic17_3_0 -u 0.011754472897871404 > ./result_6chains/node17_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_4_0 -p 937 -st none -pt topic17_4_0 -u 0.06369070295554635 > ./result_6chains/node17_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_5_0 -p 962 -st none -pt topic17_5_0 -u 0.11652996559595413 > ./result_6chains/node17_5_0.txt &
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
    "./result_6chains/node17_0_0.txt 90"
    "./result_6chains/node17_0_2.txt 90"
    "./result_6chains/node17_1_0.txt 89"
    "./result_6chains/node17_1_2.txt 89"
    "./result_6chains/node17_2_0.txt 88"
    "./result_6chains/node17_2_2.txt 88"
    "./result_6chains/node17_3_0.txt 87"
    "./result_6chains/node17_3_2.txt 87"
    "./result_6chains/node17_4_0.txt 86"
    "./result_6chains/node17_4_2.txt 86"
    "./result_6chains/node17_5_0.txt 85"
    "./result_6chains/node17_5_2.txt 85"
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
