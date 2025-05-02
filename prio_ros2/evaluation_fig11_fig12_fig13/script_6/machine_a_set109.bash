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
ros2 run evaluation_3_randomdag uunifast_node -n node109_0_2 -p 165 -st topic109_0_1 -pt None -u 1.4406200570415972e-05 > ./result_6chains/node109_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_1_2 -p 173 -st topic109_1_1 -pt None -u 0.023018956092033582 > ./result_6chains/node109_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_2_2 -p 211 -st topic109_2_1 -pt None -u 0.017283437826893067 > ./result_6chains/node109_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_3_2 -p 338 -st topic109_3_1 -pt None -u 0.012499706528162069 > ./result_6chains/node109_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_4_2 -p 599 -st topic109_4_1 -pt None -u 0.03990350589505648 > ./result_6chains/node109_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_5_2 -p 717 -st topic109_5_1 -pt None -u 0.051920051816532364 > ./result_6chains/node109_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_0_0 -p 165 -st none -pt topic109_0_0 -u 0.00022695011804052534 > ./result_6chains/node109_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_1_0 -p 173 -st none -pt topic109_1_0 -u 0.06299485106325486 > ./result_6chains/node109_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_2_0 -p 211 -st none -pt topic109_2_0 -u 0.011294904590714583 > ./result_6chains/node109_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_3_0 -p 338 -st none -pt topic109_3_0 -u 0.03756011220833222 > ./result_6chains/node109_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_4_0 -p 599 -st none -pt topic109_4_0 -u 0.018907007678178378 > ./result_6chains/node109_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_5_0 -p 717 -st none -pt topic109_5_0 -u 0.07143053572876992 > ./result_6chains/node109_5_0.txt &
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
    "./result_6chains/node109_0_0.txt 90"
    "./result_6chains/node109_0_2.txt 90"
    "./result_6chains/node109_1_0.txt 89"
    "./result_6chains/node109_1_2.txt 89"
    "./result_6chains/node109_2_0.txt 88"
    "./result_6chains/node109_2_2.txt 88"
    "./result_6chains/node109_3_0.txt 87"
    "./result_6chains/node109_3_2.txt 87"
    "./result_6chains/node109_4_0.txt 86"
    "./result_6chains/node109_4_2.txt 86"
    "./result_6chains/node109_5_0.txt 85"
    "./result_6chains/node109_5_2.txt 85"
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
