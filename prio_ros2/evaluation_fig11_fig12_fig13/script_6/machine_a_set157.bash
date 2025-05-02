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
ros2 run evaluation_3_randomdag uunifast_node -n node157_0_2 -p 65 -st topic157_0_1 -pt None -u 0.10222159033847622 > ./result_6chains/node157_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_1_2 -p 166 -st topic157_1_1 -pt None -u 0.029384929562273565 > ./result_6chains/node157_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_2_2 -p 236 -st topic157_2_1 -pt None -u 0.002663062845676245 > ./result_6chains/node157_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_3_2 -p 704 -st topic157_3_1 -pt None -u 0.010724768182737501 > ./result_6chains/node157_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_4_2 -p 756 -st topic157_4_1 -pt None -u 0.023824351731060886 > ./result_6chains/node157_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_5_2 -p 968 -st topic157_5_1 -pt None -u 0.056221254349536356 > ./result_6chains/node157_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_0_0 -p 65 -st none -pt topic157_0_0 -u 0.008135258515243604 > ./result_6chains/node157_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_1_0 -p 166 -st none -pt topic157_1_0 -u 0.016638797028833974 > ./result_6chains/node157_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_2_0 -p 236 -st none -pt topic157_2_0 -u 0.007090153015124778 > ./result_6chains/node157_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_3_0 -p 704 -st none -pt topic157_3_0 -u 0.11087804780285002 > ./result_6chains/node157_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_4_0 -p 756 -st none -pt topic157_4_0 -u 0.006851101426676567 > ./result_6chains/node157_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node157_5_0 -p 968 -st none -pt topic157_5_0 -u 0.0035137183484062473 > ./result_6chains/node157_5_0.txt &
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
    "./result_6chains/node157_0_0.txt 90"
    "./result_6chains/node157_0_2.txt 90"
    "./result_6chains/node157_1_0.txt 89"
    "./result_6chains/node157_1_2.txt 89"
    "./result_6chains/node157_2_0.txt 88"
    "./result_6chains/node157_2_2.txt 88"
    "./result_6chains/node157_3_0.txt 87"
    "./result_6chains/node157_3_2.txt 87"
    "./result_6chains/node157_4_0.txt 86"
    "./result_6chains/node157_4_2.txt 86"
    "./result_6chains/node157_5_0.txt 85"
    "./result_6chains/node157_5_2.txt 85"
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
