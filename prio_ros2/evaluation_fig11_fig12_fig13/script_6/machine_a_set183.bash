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
ros2 run evaluation_3_randomdag uunifast_node -n node183_0_2 -p 64 -st topic183_0_1 -pt None -u 0.035230679764134853 > ./result_6chains/node183_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_1_2 -p 168 -st topic183_1_1 -pt None -u 0.006078110866120645 > ./result_6chains/node183_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_2_2 -p 482 -st topic183_2_1 -pt None -u 0.01680087597083202 > ./result_6chains/node183_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_3_2 -p 723 -st topic183_3_1 -pt None -u 0.018663857897907088 > ./result_6chains/node183_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_4_2 -p 785 -st topic183_4_1 -pt None -u 0.014435408591296925 > ./result_6chains/node183_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_5_2 -p 797 -st topic183_5_1 -pt None -u 0.015699430985920363 > ./result_6chains/node183_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_0_0 -p 64 -st none -pt topic183_0_0 -u 0.0826658431970626 > ./result_6chains/node183_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_1_0 -p 168 -st none -pt topic183_1_0 -u 0.02485742468115476 > ./result_6chains/node183_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_2_0 -p 482 -st none -pt topic183_2_0 -u 0.049126457934207085 > ./result_6chains/node183_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_3_0 -p 723 -st none -pt topic183_3_0 -u 0.021708545630263837 > ./result_6chains/node183_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_4_0 -p 785 -st none -pt topic183_4_0 -u 0.009126636765469348 > ./result_6chains/node183_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_5_0 -p 797 -st none -pt topic183_5_0 -u 0.00594749532018439 > ./result_6chains/node183_5_0.txt &
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
    "./result_6chains/node183_0_0.txt 90"
    "./result_6chains/node183_0_2.txt 90"
    "./result_6chains/node183_1_0.txt 89"
    "./result_6chains/node183_1_2.txt 89"
    "./result_6chains/node183_2_0.txt 88"
    "./result_6chains/node183_2_2.txt 88"
    "./result_6chains/node183_3_0.txt 87"
    "./result_6chains/node183_3_2.txt 87"
    "./result_6chains/node183_4_0.txt 86"
    "./result_6chains/node183_4_2.txt 86"
    "./result_6chains/node183_5_0.txt 85"
    "./result_6chains/node183_5_2.txt 85"
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
