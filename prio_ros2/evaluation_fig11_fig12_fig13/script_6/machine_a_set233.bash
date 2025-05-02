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
ros2 run evaluation_3_randomdag uunifast_node -n node233_0_2 -p 106 -st topic233_0_1 -pt None -u 0.022496972089912637 > ./result_6chains/node233_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_1_2 -p 114 -st topic233_1_1 -pt None -u 0.04015111601606397 > ./result_6chains/node233_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_2_2 -p 321 -st topic233_2_1 -pt None -u 0.002956794077383973 > ./result_6chains/node233_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_3_2 -p 477 -st topic233_3_1 -pt None -u 0.04744276169272951 > ./result_6chains/node233_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_4_2 -p 494 -st topic233_4_1 -pt None -u 0.0032681000308721064 > ./result_6chains/node233_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_5_2 -p 941 -st topic233_5_1 -pt None -u 0.027848736791064647 > ./result_6chains/node233_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_0_0 -p 106 -st none -pt topic233_0_0 -u 0.006466855317771192 > ./result_6chains/node233_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_1_0 -p 114 -st none -pt topic233_1_0 -u 0.08466675301405929 > ./result_6chains/node233_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_2_0 -p 321 -st none -pt topic233_2_0 -u 0.005583017284205405 > ./result_6chains/node233_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_3_0 -p 477 -st none -pt topic233_3_0 -u 0.017241495087234437 > ./result_6chains/node233_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_4_0 -p 494 -st none -pt topic233_4_0 -u 0.011704004399378937 > ./result_6chains/node233_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node233_5_0 -p 941 -st none -pt topic233_5_0 -u 0.00636374931487349 > ./result_6chains/node233_5_0.txt &
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
    "./result_6chains/node233_0_0.txt 90"
    "./result_6chains/node233_0_2.txt 90"
    "./result_6chains/node233_1_0.txt 89"
    "./result_6chains/node233_1_2.txt 89"
    "./result_6chains/node233_2_0.txt 88"
    "./result_6chains/node233_2_2.txt 88"
    "./result_6chains/node233_3_0.txt 87"
    "./result_6chains/node233_3_2.txt 87"
    "./result_6chains/node233_4_0.txt 86"
    "./result_6chains/node233_4_2.txt 86"
    "./result_6chains/node233_5_0.txt 85"
    "./result_6chains/node233_5_2.txt 85"
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
