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
ros2 run evaluation_3_randomdag uunifast_node -n node351_0_2 -p 24 -st topic351_0_1 -pt None -u 0.024143536159138113 > ./result_6chains/node351_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_1_2 -p 469 -st topic351_1_1 -pt None -u 0.04672077150466852 > ./result_6chains/node351_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_2_2 -p 498 -st topic351_2_1 -pt None -u 0.010432253016699589 > ./result_6chains/node351_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_3_2 -p 574 -st topic351_3_1 -pt None -u 0.04723242922507112 > ./result_6chains/node351_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_4_2 -p 586 -st topic351_4_1 -pt None -u 0.015684080694484667 > ./result_6chains/node351_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_5_2 -p 757 -st topic351_5_1 -pt None -u 0.10899588086276833 > ./result_6chains/node351_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_0_0 -p 24 -st none -pt topic351_0_0 -u 0.005557813919231491 > ./result_6chains/node351_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_1_0 -p 469 -st none -pt topic351_1_0 -u 0.031019238581758313 > ./result_6chains/node351_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_2_0 -p 498 -st none -pt topic351_2_0 -u 0.033091568244763114 > ./result_6chains/node351_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_3_0 -p 574 -st none -pt topic351_3_0 -u 0.03792585117876596 > ./result_6chains/node351_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_4_0 -p 586 -st none -pt topic351_4_0 -u 0.018021798143152468 > ./result_6chains/node351_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_5_0 -p 757 -st none -pt topic351_5_0 -u 0.011058937789991771 > ./result_6chains/node351_5_0.txt &
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
    "./result_6chains/node351_0_0.txt 90"
    "./result_6chains/node351_0_2.txt 90"
    "./result_6chains/node351_1_0.txt 89"
    "./result_6chains/node351_1_2.txt 89"
    "./result_6chains/node351_2_0.txt 88"
    "./result_6chains/node351_2_2.txt 88"
    "./result_6chains/node351_3_0.txt 87"
    "./result_6chains/node351_3_2.txt 87"
    "./result_6chains/node351_4_0.txt 86"
    "./result_6chains/node351_4_2.txt 86"
    "./result_6chains/node351_5_0.txt 85"
    "./result_6chains/node351_5_2.txt 85"
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
