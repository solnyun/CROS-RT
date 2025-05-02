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
ros2 run evaluation_3_randomdag uunifast_node -n node383_0_2 -p 85 -st topic383_0_1 -pt None -u 0.05122108410431592 > ./result_6chains/node383_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_1_2 -p 289 -st topic383_1_1 -pt None -u 0.059672015013606305 > ./result_6chains/node383_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_2_2 -p 343 -st topic383_2_1 -pt None -u 0.030021569679607507 > ./result_6chains/node383_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_3_2 -p 431 -st topic383_3_1 -pt None -u 0.05864346289732589 > ./result_6chains/node383_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_4_2 -p 689 -st topic383_4_1 -pt None -u 0.04106465919329808 > ./result_6chains/node383_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_5_2 -p 863 -st topic383_5_1 -pt None -u 0.002663672249921505 > ./result_6chains/node383_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_0_0 -p 85 -st none -pt topic383_0_0 -u 0.03046443527631526 > ./result_6chains/node383_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_1_0 -p 289 -st none -pt topic383_1_0 -u 0.007300711000217952 > ./result_6chains/node383_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_2_0 -p 343 -st none -pt topic383_2_0 -u 0.07658825795273694 > ./result_6chains/node383_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_3_0 -p 431 -st none -pt topic383_3_0 -u 0.005214576077872485 > ./result_6chains/node383_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_4_0 -p 689 -st none -pt topic383_4_0 -u 0.005118967420584181 > ./result_6chains/node383_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_5_0 -p 863 -st none -pt topic383_5_0 -u 0.043081195412632556 > ./result_6chains/node383_5_0.txt &
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
    "./result_6chains/node383_0_0.txt 90"
    "./result_6chains/node383_0_2.txt 90"
    "./result_6chains/node383_1_0.txt 89"
    "./result_6chains/node383_1_2.txt 89"
    "./result_6chains/node383_2_0.txt 88"
    "./result_6chains/node383_2_2.txt 88"
    "./result_6chains/node383_3_0.txt 87"
    "./result_6chains/node383_3_2.txt 87"
    "./result_6chains/node383_4_0.txt 86"
    "./result_6chains/node383_4_2.txt 86"
    "./result_6chains/node383_5_0.txt 85"
    "./result_6chains/node383_5_2.txt 85"
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
