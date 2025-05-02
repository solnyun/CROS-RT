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
ros2 run evaluation_3_randomdag uunifast_node -n node229_0_2 -p 191 -st topic229_0_1 -pt None -u 0.09571616036650599 > ./result_6chains/node229_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_1_2 -p 533 -st topic229_1_1 -pt None -u 0.04602532598992509 > ./result_6chains/node229_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_2_2 -p 570 -st topic229_2_1 -pt None -u 0.02395792730728802 > ./result_6chains/node229_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_3_2 -p 697 -st topic229_3_1 -pt None -u 0.05285098255634918 > ./result_6chains/node229_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_4_2 -p 731 -st topic229_4_1 -pt None -u 0.0034877090528236676 > ./result_6chains/node229_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_5_2 -p 743 -st topic229_5_1 -pt None -u 0.009437012080863016 > ./result_6chains/node229_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_0_0 -p 191 -st none -pt topic229_0_0 -u 0.008207437866913803 > ./result_6chains/node229_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_1_0 -p 533 -st none -pt topic229_1_0 -u 0.042598005785302484 > ./result_6chains/node229_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_2_0 -p 570 -st none -pt topic229_2_0 -u 0.031043184797235723 > ./result_6chains/node229_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_3_0 -p 697 -st none -pt topic229_3_0 -u 0.015514811038661258 > ./result_6chains/node229_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_4_0 -p 731 -st none -pt topic229_4_0 -u 0.00602848434816268 > ./result_6chains/node229_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_5_0 -p 743 -st none -pt topic229_5_0 -u 0.00918079508905937 > ./result_6chains/node229_5_0.txt &
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
    "./result_6chains/node229_0_0.txt 90"
    "./result_6chains/node229_0_2.txt 90"
    "./result_6chains/node229_1_0.txt 89"
    "./result_6chains/node229_1_2.txt 89"
    "./result_6chains/node229_2_0.txt 88"
    "./result_6chains/node229_2_2.txt 88"
    "./result_6chains/node229_3_0.txt 87"
    "./result_6chains/node229_3_2.txt 87"
    "./result_6chains/node229_4_0.txt 86"
    "./result_6chains/node229_4_2.txt 86"
    "./result_6chains/node229_5_0.txt 85"
    "./result_6chains/node229_5_2.txt 85"
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
