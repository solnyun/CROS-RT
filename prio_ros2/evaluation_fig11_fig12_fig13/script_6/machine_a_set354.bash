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
ros2 run evaluation_3_randomdag uunifast_node -n node354_0_2 -p 372 -st topic354_0_1 -pt None -u 0.012723656810570305 > ./result_6chains/node354_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_1_2 -p 458 -st topic354_1_1 -pt None -u 0.01291832584968522 > ./result_6chains/node354_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_2_2 -p 768 -st topic354_2_1 -pt None -u 0.005817313441421668 > ./result_6chains/node354_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_3_2 -p 859 -st topic354_3_1 -pt None -u 0.04750043763031894 > ./result_6chains/node354_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_4_2 -p 921 -st topic354_4_1 -pt None -u 0.007644950625260827 > ./result_6chains/node354_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_5_2 -p 922 -st topic354_5_1 -pt None -u 0.003568620564494577 > ./result_6chains/node354_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_0_0 -p 372 -st none -pt topic354_0_0 -u 0.05361359401125598 > ./result_6chains/node354_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_1_0 -p 458 -st none -pt topic354_1_0 -u 0.04878039519067323 > ./result_6chains/node354_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_2_0 -p 768 -st none -pt topic354_2_0 -u 0.023207432132784978 > ./result_6chains/node354_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_3_0 -p 859 -st none -pt topic354_3_0 -u 0.027399215574860858 > ./result_6chains/node354_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_4_0 -p 921 -st none -pt topic354_4_0 -u 0.004992395841229957 > ./result_6chains/node354_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_5_0 -p 922 -st none -pt topic354_5_0 -u 0.14388799736234953 > ./result_6chains/node354_5_0.txt &
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
    "./result_6chains/node354_0_0.txt 90"
    "./result_6chains/node354_0_2.txt 90"
    "./result_6chains/node354_1_0.txt 89"
    "./result_6chains/node354_1_2.txt 89"
    "./result_6chains/node354_2_0.txt 88"
    "./result_6chains/node354_2_2.txt 88"
    "./result_6chains/node354_3_0.txt 87"
    "./result_6chains/node354_3_2.txt 87"
    "./result_6chains/node354_4_0.txt 86"
    "./result_6chains/node354_4_2.txt 86"
    "./result_6chains/node354_5_0.txt 85"
    "./result_6chains/node354_5_2.txt 85"
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
