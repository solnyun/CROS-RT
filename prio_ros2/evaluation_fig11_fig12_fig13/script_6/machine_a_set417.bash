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
ros2 run evaluation_3_randomdag uunifast_node -n node417_0_2 -p 10 -st topic417_0_1 -pt None -u 0.008819627753779757 > ./result_6chains/node417_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_1_2 -p 214 -st topic417_1_1 -pt None -u 0.00859826157081195 > ./result_6chains/node417_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_2_2 -p 353 -st topic417_2_1 -pt None -u 0.01714308018574906 > ./result_6chains/node417_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_3_2 -p 466 -st topic417_3_1 -pt None -u 0.0024457251039974592 > ./result_6chains/node417_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_4_2 -p 907 -st topic417_4_1 -pt None -u 0.035450129633532446 > ./result_6chains/node417_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_5_2 -p 974 -st topic417_5_1 -pt None -u 0.017652740162255487 > ./result_6chains/node417_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_0_0 -p 10 -st none -pt topic417_0_0 -u 0.02405482946529508 > ./result_6chains/node417_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_1_0 -p 214 -st none -pt topic417_1_0 -u 0.02130576673799972 > ./result_6chains/node417_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_2_0 -p 353 -st none -pt topic417_2_0 -u 0.030703203083530195 > ./result_6chains/node417_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_3_0 -p 466 -st none -pt topic417_3_0 -u 0.0326087181766217 > ./result_6chains/node417_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_4_0 -p 907 -st none -pt topic417_4_0 -u 0.013681181191391445 > ./result_6chains/node417_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_5_0 -p 974 -st none -pt topic417_5_0 -u 0.009276717869677514 > ./result_6chains/node417_5_0.txt &
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
    "./result_6chains/node417_0_0.txt 90"
    "./result_6chains/node417_0_2.txt 90"
    "./result_6chains/node417_1_0.txt 89"
    "./result_6chains/node417_1_2.txt 89"
    "./result_6chains/node417_2_0.txt 88"
    "./result_6chains/node417_2_2.txt 88"
    "./result_6chains/node417_3_0.txt 87"
    "./result_6chains/node417_3_2.txt 87"
    "./result_6chains/node417_4_0.txt 86"
    "./result_6chains/node417_4_2.txt 86"
    "./result_6chains/node417_5_0.txt 85"
    "./result_6chains/node417_5_2.txt 85"
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
