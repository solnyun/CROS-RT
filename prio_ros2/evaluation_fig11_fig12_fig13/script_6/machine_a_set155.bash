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
ros2 run evaluation_3_randomdag uunifast_node -n node155_0_2 -p 189 -st topic155_0_1 -pt None -u 0.06321139418795646 > ./result_6chains/node155_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_1_2 -p 315 -st topic155_1_1 -pt None -u 0.03213914825802522 > ./result_6chains/node155_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_2_2 -p 339 -st topic155_2_1 -pt None -u 0.06582026499117033 > ./result_6chains/node155_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_3_2 -p 766 -st topic155_3_1 -pt None -u 0.06234488636430978 > ./result_6chains/node155_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_4_2 -p 914 -st topic155_4_1 -pt None -u 0.014951251700430802 > ./result_6chains/node155_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_5_2 -p 923 -st topic155_5_1 -pt None -u 0.002076374514888076 > ./result_6chains/node155_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_0_0 -p 189 -st none -pt topic155_0_0 -u 0.023700423460698117 > ./result_6chains/node155_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_1_0 -p 315 -st none -pt topic155_1_0 -u 0.016351626230985683 > ./result_6chains/node155_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_2_0 -p 339 -st none -pt topic155_2_0 -u 0.010273544893591113 > ./result_6chains/node155_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_3_0 -p 766 -st none -pt topic155_3_0 -u 0.032668267983220145 > ./result_6chains/node155_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_4_0 -p 914 -st none -pt topic155_4_0 -u 0.02692277436565567 > ./result_6chains/node155_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_5_0 -p 923 -st none -pt topic155_5_0 -u 0.03870656242354782 > ./result_6chains/node155_5_0.txt &
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
    "./result_6chains/node155_0_0.txt 90"
    "./result_6chains/node155_0_2.txt 90"
    "./result_6chains/node155_1_0.txt 89"
    "./result_6chains/node155_1_2.txt 89"
    "./result_6chains/node155_2_0.txt 88"
    "./result_6chains/node155_2_2.txt 88"
    "./result_6chains/node155_3_0.txt 87"
    "./result_6chains/node155_3_2.txt 87"
    "./result_6chains/node155_4_0.txt 86"
    "./result_6chains/node155_4_2.txt 86"
    "./result_6chains/node155_5_0.txt 85"
    "./result_6chains/node155_5_2.txt 85"
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
