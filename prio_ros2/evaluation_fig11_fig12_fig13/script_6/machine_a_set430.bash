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
ros2 run evaluation_3_randomdag uunifast_node -n node430_0_2 -p 26 -st topic430_0_1 -pt None -u 0.008740845024535593 > ./result_6chains/node430_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_1_2 -p 194 -st topic430_1_1 -pt None -u 0.06931327263215342 > ./result_6chains/node430_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_2_2 -p 289 -st topic430_2_1 -pt None -u 0.005233515853696691 > ./result_6chains/node430_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_3_2 -p 782 -st topic430_3_1 -pt None -u 0.03743088888041432 > ./result_6chains/node430_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_4_2 -p 822 -st topic430_4_1 -pt None -u 0.006825417764894565 > ./result_6chains/node430_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_5_2 -p 968 -st topic430_5_1 -pt None -u 0.1625860218497818 > ./result_6chains/node430_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_0_0 -p 26 -st none -pt topic430_0_0 -u 0.017567373025810185 > ./result_6chains/node430_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_1_0 -p 194 -st none -pt topic430_1_0 -u 0.0065409108986868025 > ./result_6chains/node430_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_2_0 -p 289 -st none -pt topic430_2_0 -u 0.04109203017494495 > ./result_6chains/node430_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_3_0 -p 782 -st none -pt topic430_3_0 -u 0.00701838243266617 > ./result_6chains/node430_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_4_0 -p 822 -st none -pt topic430_4_0 -u 0.02696678036851341 > ./result_6chains/node430_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_5_0 -p 968 -st none -pt topic430_5_0 -u 0.022139573161590653 > ./result_6chains/node430_5_0.txt &
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
    "./result_6chains/node430_0_0.txt 90"
    "./result_6chains/node430_0_2.txt 90"
    "./result_6chains/node430_1_0.txt 89"
    "./result_6chains/node430_1_2.txt 89"
    "./result_6chains/node430_2_0.txt 88"
    "./result_6chains/node430_2_2.txt 88"
    "./result_6chains/node430_3_0.txt 87"
    "./result_6chains/node430_3_2.txt 87"
    "./result_6chains/node430_4_0.txt 86"
    "./result_6chains/node430_4_2.txt 86"
    "./result_6chains/node430_5_0.txt 85"
    "./result_6chains/node430_5_2.txt 85"
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
