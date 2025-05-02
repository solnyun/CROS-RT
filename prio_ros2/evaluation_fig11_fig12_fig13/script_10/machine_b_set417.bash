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
ros2 run evaluation_3_randomdag uunifast_node -n node417_0_1 -p 144 -st topic417_0_0 -pt topic417_0_1 -u 0.021600249286253925 > ./result_10chains/node417_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_1_1 -p 250 -st topic417_1_0 -pt topic417_1_1 -u 0.01610177116 > ./result_10chains/node417_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_2_1 -p 261 -st topic417_2_0 -pt topic417_2_1 -u 0.0021992574191019854 > ./result_10chains/node417_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_3_1 -p 402 -st topic417_3_0 -pt topic417_3_1 -u 0.015899645545421615 > ./result_10chains/node417_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_4_1 -p 404 -st topic417_4_0 -pt topic417_4_1 -u 0.006906459068491466 > ./result_10chains/node417_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_5_1 -p 506 -st topic417_5_0 -pt topic417_5_1 -u 0.02432721261422166 > ./result_10chains/node417_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_6_1 -p 655 -st topic417_6_0 -pt topic417_6_1 -u 0.032679729602720364 > ./result_10chains/node417_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_7_1 -p 682 -st topic417_7_0 -pt topic417_7_1 -u 0.006051740352664536 > ./result_10chains/node417_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_8_1 -p 745 -st topic417_8_0 -pt topic417_8_1 -u 0.03832911830904412 > ./result_10chains/node417_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_9_1 -p 772 -st topic417_9_0 -pt topic417_9_1 -u 0.03279445636624261 > ./result_10chains/node417_9_1.txt &
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
    "./result_10chains/node417_0_1.txt 90"
    "./result_10chains/node417_1_1.txt 89"
    "./result_10chains/node417_2_1.txt 88"
    "./result_10chains/node417_3_1.txt 87"
    "./result_10chains/node417_4_1.txt 86"
    "./result_10chains/node417_5_1.txt 85"
    "./result_10chains/node417_6_1.txt 84"
    "./result_10chains/node417_7_1.txt 83"
    "./result_10chains/node417_8_1.txt 82"
    "./result_10chains/node417_9_1.txt 81"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
