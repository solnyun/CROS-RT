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
ros2 run evaluation_3_randomdag uunifast_node -n node403_0_2 -p 58 -st topic403_0_1 -pt None -u 0.010535787760207749 > ./result_6chains/node403_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_1_2 -p 103 -st topic403_1_1 -pt None -u 0.019131275244751056 > ./result_6chains/node403_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_2_2 -p 469 -st topic403_2_1 -pt None -u 0.02307752257322626 > ./result_6chains/node403_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_3_2 -p 508 -st topic403_3_1 -pt None -u 0.02883744695632756 > ./result_6chains/node403_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_4_2 -p 904 -st topic403_4_1 -pt None -u 0.040077287773483516 > ./result_6chains/node403_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_5_2 -p 981 -st topic403_5_1 -pt None -u 0.0037535913091884926 > ./result_6chains/node403_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_0_0 -p 58 -st none -pt topic403_0_0 -u 8.196539271232428e-05 > ./result_6chains/node403_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_1_0 -p 103 -st none -pt topic403_1_0 -u 0.006447852679879018 > ./result_6chains/node403_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_2_0 -p 469 -st none -pt topic403_2_0 -u 0.04457940634980467 > ./result_6chains/node403_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_3_0 -p 508 -st none -pt topic403_3_0 -u 0.02827152614423306 > ./result_6chains/node403_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_4_0 -p 904 -st none -pt topic403_4_0 -u 0.02120469558712393 > ./result_6chains/node403_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_5_0 -p 981 -st none -pt topic403_5_0 -u 0.1231580793025222 > ./result_6chains/node403_5_0.txt &
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
    "./result_6chains/node403_0_0.txt 90"
    "./result_6chains/node403_0_2.txt 90"
    "./result_6chains/node403_1_0.txt 89"
    "./result_6chains/node403_1_2.txt 89"
    "./result_6chains/node403_2_0.txt 88"
    "./result_6chains/node403_2_2.txt 88"
    "./result_6chains/node403_3_0.txt 87"
    "./result_6chains/node403_3_2.txt 87"
    "./result_6chains/node403_4_0.txt 86"
    "./result_6chains/node403_4_2.txt 86"
    "./result_6chains/node403_5_0.txt 85"
    "./result_6chains/node403_5_2.txt 85"
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
