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
ros2 run evaluation_3_randomdag uunifast_node -n node163_0_2 -p 24 -st topic163_0_1 -pt None -u 0.07509802638405871 > ./result_6chains/node163_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_1_2 -p 328 -st topic163_1_1 -pt None -u 0.1170525039559962 > ./result_6chains/node163_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_2_2 -p 612 -st topic163_2_1 -pt None -u 0.016851220814602247 > ./result_6chains/node163_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_3_2 -p 622 -st topic163_3_1 -pt None -u 0.030090573572336188 > ./result_6chains/node163_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_4_2 -p 703 -st topic163_4_1 -pt None -u 0.034090447670439845 > ./result_6chains/node163_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_5_2 -p 715 -st topic163_5_1 -pt None -u 0.021436801000869598 > ./result_6chains/node163_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_0_0 -p 24 -st none -pt topic163_0_0 -u 0.026617342828583135 > ./result_6chains/node163_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_1_0 -p 328 -st none -pt topic163_1_0 -u 0.006807673391247826 > ./result_6chains/node163_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_2_0 -p 612 -st none -pt topic163_2_0 -u 0.026936536475272332 > ./result_6chains/node163_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_3_0 -p 622 -st none -pt topic163_3_0 -u 0.02276303372495797 > ./result_6chains/node163_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_4_0 -p 703 -st none -pt topic163_4_0 -u 0.013451970935325824 > ./result_6chains/node163_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_5_0 -p 715 -st none -pt topic163_5_0 -u 0.00041866918417880067 > ./result_6chains/node163_5_0.txt &
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
    "./result_6chains/node163_0_0.txt 90"
    "./result_6chains/node163_0_2.txt 90"
    "./result_6chains/node163_1_0.txt 89"
    "./result_6chains/node163_1_2.txt 89"
    "./result_6chains/node163_2_0.txt 88"
    "./result_6chains/node163_2_2.txt 88"
    "./result_6chains/node163_3_0.txt 87"
    "./result_6chains/node163_3_2.txt 87"
    "./result_6chains/node163_4_0.txt 86"
    "./result_6chains/node163_4_2.txt 86"
    "./result_6chains/node163_5_0.txt 85"
    "./result_6chains/node163_5_2.txt 85"
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
