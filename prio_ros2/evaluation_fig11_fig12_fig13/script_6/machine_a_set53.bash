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
ros2 run evaluation_3_randomdag uunifast_node -n node53_0_2 -p 108 -st topic53_0_1 -pt None -u 0.024031819600919324 > ./result_6chains/node53_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_1_2 -p 250 -st topic53_1_1 -pt None -u 0.023798091786393305 > ./result_6chains/node53_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_2_2 -p 349 -st topic53_2_1 -pt None -u 0.005005477373750344 > ./result_6chains/node53_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_3_2 -p 372 -st topic53_3_1 -pt None -u 0.027948848422679584 > ./result_6chains/node53_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_4_2 -p 823 -st topic53_4_1 -pt None -u 0.024157654553177657 > ./result_6chains/node53_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_5_2 -p 894 -st topic53_5_1 -pt None -u 0.04896172444772433 > ./result_6chains/node53_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_0_0 -p 108 -st none -pt topic53_0_0 -u 0.030480313463233988 > ./result_6chains/node53_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_1_0 -p 250 -st none -pt topic53_1_0 -u 0.039267941313547716 > ./result_6chains/node53_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_2_0 -p 349 -st none -pt topic53_2_0 -u 0.012603033112384976 > ./result_6chains/node53_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_3_0 -p 372 -st none -pt topic53_3_0 -u 0.0035450081004086975 > ./result_6chains/node53_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_4_0 -p 823 -st none -pt topic53_4_0 -u 0.12516581967011106 > ./result_6chains/node53_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_5_0 -p 894 -st none -pt topic53_5_0 -u 0.013590477835608877 > ./result_6chains/node53_5_0.txt &
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
    "./result_6chains/node53_0_0.txt 90"
    "./result_6chains/node53_0_2.txt 90"
    "./result_6chains/node53_1_0.txt 89"
    "./result_6chains/node53_1_2.txt 89"
    "./result_6chains/node53_2_0.txt 88"
    "./result_6chains/node53_2_2.txt 88"
    "./result_6chains/node53_3_0.txt 87"
    "./result_6chains/node53_3_2.txt 87"
    "./result_6chains/node53_4_0.txt 86"
    "./result_6chains/node53_4_2.txt 86"
    "./result_6chains/node53_5_0.txt 85"
    "./result_6chains/node53_5_2.txt 85"
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
