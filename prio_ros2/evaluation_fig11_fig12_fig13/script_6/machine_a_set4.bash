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
ros2 run evaluation_3_randomdag uunifast_node -n node4_0_2 -p 84 -st topic4_0_1 -pt None -u 0.0008936674371563536 > ./result_6chains/node4_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_1_2 -p 164 -st topic4_1_1 -pt None -u 0.024024545396141406 > ./result_6chains/node4_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_2_2 -p 723 -st topic4_2_1 -pt None -u 0.020563427467754802 > ./result_6chains/node4_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_3_2 -p 797 -st topic4_3_1 -pt None -u 0.010869673511095745 > ./result_6chains/node4_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_4_2 -p 825 -st topic4_4_1 -pt None -u 0.07111552593440132 > ./result_6chains/node4_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_5_2 -p 901 -st topic4_5_1 -pt None -u 0.005491912008357981 > ./result_6chains/node4_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_0_0 -p 84 -st none -pt topic4_0_0 -u 0.051350425190150095 > ./result_6chains/node4_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_1_0 -p 164 -st none -pt topic4_1_0 -u 0.02467738647589368 > ./result_6chains/node4_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_2_0 -p 723 -st none -pt topic4_2_0 -u 0.004133687295074573 > ./result_6chains/node4_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_3_0 -p 797 -st none -pt topic4_3_0 -u 0.0031963035565912845 > ./result_6chains/node4_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_4_0 -p 825 -st none -pt topic4_4_0 -u 0.08417871874131119 > ./result_6chains/node4_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_5_0 -p 901 -st none -pt topic4_5_0 -u 0.06154160746832954 > ./result_6chains/node4_5_0.txt &
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
    "./result_6chains/node4_0_0.txt 90"
    "./result_6chains/node4_0_2.txt 90"
    "./result_6chains/node4_1_0.txt 89"
    "./result_6chains/node4_1_2.txt 89"
    "./result_6chains/node4_2_0.txt 88"
    "./result_6chains/node4_2_2.txt 88"
    "./result_6chains/node4_3_0.txt 87"
    "./result_6chains/node4_3_2.txt 87"
    "./result_6chains/node4_4_0.txt 86"
    "./result_6chains/node4_4_2.txt 86"
    "./result_6chains/node4_5_0.txt 85"
    "./result_6chains/node4_5_2.txt 85"
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
