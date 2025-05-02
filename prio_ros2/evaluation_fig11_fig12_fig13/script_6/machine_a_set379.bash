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
ros2 run evaluation_3_randomdag uunifast_node -n node379_0_2 -p 25 -st topic379_0_1 -pt None -u 0.0004975075918169369 > ./result_6chains/node379_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_1_2 -p 153 -st topic379_1_1 -pt None -u 0.03002431710484782 > ./result_6chains/node379_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_2_2 -p 629 -st topic379_2_1 -pt None -u 0.003890187369827991 > ./result_6chains/node379_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_3_2 -p 757 -st topic379_3_1 -pt None -u 0.06113044518837593 > ./result_6chains/node379_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_4_2 -p 925 -st topic379_4_1 -pt None -u 0.03404808088591275 > ./result_6chains/node379_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_5_2 -p 979 -st topic379_5_1 -pt None -u 0.0011447412039478032 > ./result_6chains/node379_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_0_0 -p 25 -st none -pt topic379_0_0 -u 0.007131149004009074 > ./result_6chains/node379_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_1_0 -p 153 -st none -pt topic379_1_0 -u 0.039884832945700055 > ./result_6chains/node379_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_2_0 -p 629 -st none -pt topic379_2_0 -u 0.032623391747888864 > ./result_6chains/node379_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_3_0 -p 757 -st none -pt topic379_3_0 -u 0.041124064020671064 > ./result_6chains/node379_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_4_0 -p 925 -st none -pt topic379_4_0 -u 0.05258820535288794 > ./result_6chains/node379_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_5_0 -p 979 -st none -pt topic379_5_0 -u 0.02307232751517783 > ./result_6chains/node379_5_0.txt &
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
    "./result_6chains/node379_0_0.txt 90"
    "./result_6chains/node379_0_2.txt 90"
    "./result_6chains/node379_1_0.txt 89"
    "./result_6chains/node379_1_2.txt 89"
    "./result_6chains/node379_2_0.txt 88"
    "./result_6chains/node379_2_2.txt 88"
    "./result_6chains/node379_3_0.txt 87"
    "./result_6chains/node379_3_2.txt 87"
    "./result_6chains/node379_4_0.txt 86"
    "./result_6chains/node379_4_2.txt 86"
    "./result_6chains/node379_5_0.txt 85"
    "./result_6chains/node379_5_2.txt 85"
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
