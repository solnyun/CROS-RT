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
ros2 run evaluation_3_randomdag uunifast_node -n node289_0_2 -p 24 -st topic289_0_1 -pt None -u 0.02034979252413388 > ./result_6chains/node289_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_1_2 -p 364 -st topic289_1_1 -pt None -u 0.02151206178544912 > ./result_6chains/node289_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_2_2 -p 453 -st topic289_2_1 -pt None -u 0.03857382609598853 > ./result_6chains/node289_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_3_2 -p 464 -st topic289_3_1 -pt None -u 0.052697252674431025 > ./result_6chains/node289_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_4_2 -p 711 -st topic289_4_1 -pt None -u 0.0071011682496004425 > ./result_6chains/node289_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_5_2 -p 786 -st topic289_5_1 -pt None -u 0.01358383535520904 > ./result_6chains/node289_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_0_0 -p 24 -st none -pt topic289_0_0 -u 0.019366796731242586 > ./result_6chains/node289_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_1_0 -p 364 -st none -pt topic289_1_0 -u 0.015067821433938144 > ./result_6chains/node289_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_2_0 -p 453 -st none -pt topic289_2_0 -u 0.14216063250528213 > ./result_6chains/node289_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_3_0 -p 464 -st none -pt topic289_3_0 -u 0.04816424915480738 > ./result_6chains/node289_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_4_0 -p 711 -st none -pt topic289_4_0 -u 0.0059160363882873115 > ./result_6chains/node289_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_5_0 -p 786 -st none -pt topic289_5_0 -u 0.01581259450208862 > ./result_6chains/node289_5_0.txt &
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
    "./result_6chains/node289_0_0.txt 90"
    "./result_6chains/node289_0_2.txt 90"
    "./result_6chains/node289_1_0.txt 89"
    "./result_6chains/node289_1_2.txt 89"
    "./result_6chains/node289_2_0.txt 88"
    "./result_6chains/node289_2_2.txt 88"
    "./result_6chains/node289_3_0.txt 87"
    "./result_6chains/node289_3_2.txt 87"
    "./result_6chains/node289_4_0.txt 86"
    "./result_6chains/node289_4_2.txt 86"
    "./result_6chains/node289_5_0.txt 85"
    "./result_6chains/node289_5_2.txt 85"
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
