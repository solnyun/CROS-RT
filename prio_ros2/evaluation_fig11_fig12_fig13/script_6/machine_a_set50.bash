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
ros2 run evaluation_3_randomdag uunifast_node -n node50_0_2 -p 12 -st topic50_0_1 -pt None -u 0.07644564991651448 > ./result_6chains/node50_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node50_1_2 -p 374 -st topic50_1_1 -pt None -u 0.004392455835390829 > ./result_6chains/node50_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node50_2_2 -p 536 -st topic50_2_1 -pt None -u 0.03841422251897414 > ./result_6chains/node50_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node50_3_2 -p 552 -st topic50_3_1 -pt None -u 0.041366313223628826 > ./result_6chains/node50_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node50_4_2 -p 659 -st topic50_4_1 -pt None -u 0.030055561709868076 > ./result_6chains/node50_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node50_5_2 -p 773 -st topic50_5_1 -pt None -u 0.006253626639375831 > ./result_6chains/node50_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node50_0_0 -p 12 -st none -pt topic50_0_0 -u 0.023505069002824397 > ./result_6chains/node50_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node50_1_0 -p 374 -st none -pt topic50_1_0 -u 0.013072274618792123 > ./result_6chains/node50_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node50_2_0 -p 536 -st none -pt topic50_2_0 -u 0.024970738283083327 > ./result_6chains/node50_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node50_3_0 -p 552 -st none -pt topic50_3_0 -u 0.024102819532196673 > ./result_6chains/node50_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node50_4_0 -p 659 -st none -pt topic50_4_0 -u 0.05563422433909483 > ./result_6chains/node50_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node50_5_0 -p 773 -st none -pt topic50_5_0 -u 0.027757190844082125 > ./result_6chains/node50_5_0.txt &
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
    "./result_6chains/node50_0_0.txt 90"
    "./result_6chains/node50_0_2.txt 90"
    "./result_6chains/node50_1_0.txt 89"
    "./result_6chains/node50_1_2.txt 89"
    "./result_6chains/node50_2_0.txt 88"
    "./result_6chains/node50_2_2.txt 88"
    "./result_6chains/node50_3_0.txt 87"
    "./result_6chains/node50_3_2.txt 87"
    "./result_6chains/node50_4_0.txt 86"
    "./result_6chains/node50_4_2.txt 86"
    "./result_6chains/node50_5_0.txt 85"
    "./result_6chains/node50_5_2.txt 85"
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
