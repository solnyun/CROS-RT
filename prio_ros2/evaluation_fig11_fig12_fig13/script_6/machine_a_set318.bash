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
ros2 run evaluation_3_randomdag uunifast_node -n node318_0_2 -p 18 -st topic318_0_1 -pt None -u 0.0413161604626921 > ./result_6chains/node318_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_1_2 -p 203 -st topic318_1_1 -pt None -u 0.010811565376935284 > ./result_6chains/node318_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_2_2 -p 438 -st topic318_2_1 -pt None -u 0.0601648482276779 > ./result_6chains/node318_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_3_2 -p 462 -st topic318_3_1 -pt None -u 0.01273102846303692 > ./result_6chains/node318_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_4_2 -p 669 -st topic318_4_1 -pt None -u 0.02915566671854744 > ./result_6chains/node318_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_5_2 -p 950 -st topic318_5_1 -pt None -u 0.018732537391717846 > ./result_6chains/node318_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_0_0 -p 18 -st none -pt topic318_0_0 -u 0.010272584432167331 > ./result_6chains/node318_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_1_0 -p 203 -st none -pt topic318_1_0 -u 0.027447786843342536 > ./result_6chains/node318_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_2_0 -p 438 -st none -pt topic318_2_0 -u 0.020730062142979344 > ./result_6chains/node318_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_3_0 -p 462 -st none -pt topic318_3_0 -u 0.01831867385136038 > ./result_6chains/node318_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_4_0 -p 669 -st none -pt topic318_4_0 -u 0.016898511834959856 > ./result_6chains/node318_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_5_0 -p 950 -st none -pt topic318_5_0 -u 0.04570059349581619 > ./result_6chains/node318_5_0.txt &
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
    "./result_6chains/node318_0_0.txt 90"
    "./result_6chains/node318_0_2.txt 90"
    "./result_6chains/node318_1_0.txt 89"
    "./result_6chains/node318_1_2.txt 89"
    "./result_6chains/node318_2_0.txt 88"
    "./result_6chains/node318_2_2.txt 88"
    "./result_6chains/node318_3_0.txt 87"
    "./result_6chains/node318_3_2.txt 87"
    "./result_6chains/node318_4_0.txt 86"
    "./result_6chains/node318_4_2.txt 86"
    "./result_6chains/node318_5_0.txt 85"
    "./result_6chains/node318_5_2.txt 85"
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
