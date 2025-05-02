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
ros2 run evaluation_3_randomdag uunifast_node -n node41_0_2 -p 29 -st topic41_0_1 -pt None -u 0.031014496567502103 > ./result_6chains/node41_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_1_2 -p 462 -st topic41_1_1 -pt None -u 0.009120107095713037 > ./result_6chains/node41_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_2_2 -p 559 -st topic41_2_1 -pt None -u 0.024252736809834696 > ./result_6chains/node41_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_3_2 -p 628 -st topic41_3_1 -pt None -u 0.009950701879882617 > ./result_6chains/node41_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_4_2 -p 764 -st topic41_4_1 -pt None -u 0.05657001953962791 > ./result_6chains/node41_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_5_2 -p 935 -st topic41_5_1 -pt None -u 0.004790314284239628 > ./result_6chains/node41_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_0_0 -p 29 -st none -pt topic41_0_0 -u 0.014741223070985687 > ./result_6chains/node41_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_1_0 -p 462 -st none -pt topic41_1_0 -u 0.011461297553738536 > ./result_6chains/node41_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_2_0 -p 559 -st none -pt topic41_2_0 -u 0.008172382467116213 > ./result_6chains/node41_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_3_0 -p 628 -st none -pt topic41_3_0 -u 0.021856921227111692 > ./result_6chains/node41_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_4_0 -p 764 -st none -pt topic41_4_0 -u 0.07408768153645034 > ./result_6chains/node41_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_5_0 -p 935 -st none -pt topic41_5_0 -u 0.05499871106954266 > ./result_6chains/node41_5_0.txt &
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
    "./result_6chains/node41_0_0.txt 90"
    "./result_6chains/node41_0_2.txt 90"
    "./result_6chains/node41_1_0.txt 89"
    "./result_6chains/node41_1_2.txt 89"
    "./result_6chains/node41_2_0.txt 88"
    "./result_6chains/node41_2_2.txt 88"
    "./result_6chains/node41_3_0.txt 87"
    "./result_6chains/node41_3_2.txt 87"
    "./result_6chains/node41_4_0.txt 86"
    "./result_6chains/node41_4_2.txt 86"
    "./result_6chains/node41_5_0.txt 85"
    "./result_6chains/node41_5_2.txt 85"
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
