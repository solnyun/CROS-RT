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
ros2 run evaluation_3_randomdag uunifast_node -n node36_0_2 -p 120 -st topic36_0_1 -pt None -u 0.03205910740870127 > ./result_6chains/node36_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_1_2 -p 342 -st topic36_1_1 -pt None -u 0.01872866001968987 > ./result_6chains/node36_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_2_2 -p 476 -st topic36_2_1 -pt None -u 0.011398458979500647 > ./result_6chains/node36_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_3_2 -p 572 -st topic36_3_1 -pt None -u 0.04473329455739408 > ./result_6chains/node36_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_4_2 -p 806 -st topic36_4_1 -pt None -u 0.033952821036450254 > ./result_6chains/node36_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_5_2 -p 913 -st topic36_5_1 -pt None -u 0.0006942035668020528 > ./result_6chains/node36_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_0_0 -p 120 -st none -pt topic36_0_0 -u 0.07507963711291471 > ./result_6chains/node36_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_1_0 -p 342 -st none -pt topic36_1_0 -u 0.023363064997957372 > ./result_6chains/node36_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_2_0 -p 476 -st none -pt topic36_2_0 -u 0.0015158368664865973 > ./result_6chains/node36_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_3_0 -p 572 -st none -pt topic36_3_0 -u 0.007003438656278782 > ./result_6chains/node36_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_4_0 -p 806 -st none -pt topic36_4_0 -u 0.00313257807533468 > ./result_6chains/node36_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_5_0 -p 913 -st none -pt topic36_5_0 -u 0.04345936537053566 > ./result_6chains/node36_5_0.txt &
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
    "./result_6chains/node36_0_0.txt 90"
    "./result_6chains/node36_0_2.txt 90"
    "./result_6chains/node36_1_0.txt 89"
    "./result_6chains/node36_1_2.txt 89"
    "./result_6chains/node36_2_0.txt 88"
    "./result_6chains/node36_2_2.txt 88"
    "./result_6chains/node36_3_0.txt 87"
    "./result_6chains/node36_3_2.txt 87"
    "./result_6chains/node36_4_0.txt 86"
    "./result_6chains/node36_4_2.txt 86"
    "./result_6chains/node36_5_0.txt 85"
    "./result_6chains/node36_5_2.txt 85"
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
