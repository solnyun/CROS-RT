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
ros2 run evaluation_3_randomdag uunifast_node -n node46_0_2 -p 58 -st topic46_0_1 -pt None -u 0.005407055364008817 > ./result_10chains/node46_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_1_2 -p 127 -st topic46_1_1 -pt None -u 0.022523382228701982 > ./result_10chains/node46_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_2_2 -p 156 -st topic46_2_1 -pt None -u 0.004148202027510817 > ./result_10chains/node46_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_3_2 -p 222 -st topic46_3_1 -pt None -u 0.01345041353546289 > ./result_10chains/node46_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_4_2 -p 419 -st topic46_4_1 -pt None -u 0.00500456461223564 > ./result_10chains/node46_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_5_2 -p 728 -st topic46_5_1 -pt None -u 0.007508096932042518 > ./result_10chains/node46_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_6_2 -p 801 -st topic46_6_1 -pt None -u 0.018408251209103443 > ./result_10chains/node46_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_7_2 -p 939 -st topic46_7_1 -pt None -u 0.00822812680854812 > ./result_10chains/node46_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_8_2 -p 950 -st topic46_8_1 -pt None -u 0.046392086104375146 > ./result_10chains/node46_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_9_2 -p 973 -st topic46_9_1 -pt None -u 0.0004345611786289941 > ./result_10chains/node46_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_0_0 -p 58 -st none -pt topic46_0_0 -u 0.05327571317710411 > ./result_10chains/node46_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_1_0 -p 127 -st none -pt topic46_1_0 -u 0.004547695815821484 > ./result_10chains/node46_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_2_0 -p 156 -st none -pt topic46_2_0 -u 0.018620776868226996 > ./result_10chains/node46_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_3_0 -p 222 -st none -pt topic46_3_0 -u 0.005810020080584455 > ./result_10chains/node46_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_4_0 -p 419 -st none -pt topic46_4_0 -u 0.013695417656637732 > ./result_10chains/node46_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_5_0 -p 728 -st none -pt topic46_5_0 -u 0.010888742332500312 > ./result_10chains/node46_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_6_0 -p 801 -st none -pt topic46_6_0 -u 0.03917061406941458 > ./result_10chains/node46_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_7_0 -p 939 -st none -pt topic46_7_0 -u 0.0695603098342781 > ./result_10chains/node46_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_8_0 -p 950 -st none -pt topic46_8_0 -u 0.009536221210317344 > ./result_10chains/node46_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_9_0 -p 973 -st none -pt topic46_9_0 -u 0.004797962834825108 > ./result_10chains/node46_9_0.txt &
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
    "./result_10chains/node46_0_0.txt 90"
    "./result_10chains/node46_0_2.txt 90"
    "./result_10chains/node46_1_0.txt 89"
    "./result_10chains/node46_1_2.txt 89"
    "./result_10chains/node46_2_0.txt 88"
    "./result_10chains/node46_2_2.txt 88"
    "./result_10chains/node46_3_0.txt 87"
    "./result_10chains/node46_3_2.txt 87"
    "./result_10chains/node46_4_0.txt 86"
    "./result_10chains/node46_4_2.txt 86"
    "./result_10chains/node46_5_0.txt 85"
    "./result_10chains/node46_5_2.txt 85"
    "./result_10chains/node46_6_0.txt 84"
    "./result_10chains/node46_6_2.txt 84"
    "./result_10chains/node46_7_0.txt 83"
    "./result_10chains/node46_7_2.txt 83"
    "./result_10chains/node46_8_0.txt 82"
    "./result_10chains/node46_8_2.txt 82"
    "./result_10chains/node46_9_0.txt 81"
    "./result_10chains/node46_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
