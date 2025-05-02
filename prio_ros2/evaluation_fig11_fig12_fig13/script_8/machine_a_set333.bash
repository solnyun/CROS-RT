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
ros2 run evaluation_3_randomdag uunifast_node -n node333_0_2 -p 119 -st topic333_0_1 -pt None -u 0.003668513956303854 > ./result_8chains/node333_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_1_2 -p 212 -st topic333_1_1 -pt None -u 0.00936000501918477 > ./result_8chains/node333_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_2_2 -p 300 -st topic333_2_1 -pt None -u 2.117697216286185e-05 > ./result_8chains/node333_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_3_2 -p 402 -st topic333_3_1 -pt None -u 0.013261736931717255 > ./result_8chains/node333_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_4_2 -p 604 -st topic333_4_1 -pt None -u 0.012622841048813171 > ./result_8chains/node333_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_5_2 -p 770 -st topic333_5_1 -pt None -u 0.011366611792354542 > ./result_8chains/node333_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_6_2 -p 798 -st topic333_6_1 -pt None -u 0.02922524340251295 > ./result_8chains/node333_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_7_2 -p 938 -st topic333_7_1 -pt None -u 0.022474954156755888 > ./result_8chains/node333_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_0_0 -p 119 -st none -pt topic333_0_0 -u 0.01194413955772522 > ./result_8chains/node333_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_1_0 -p 212 -st none -pt topic333_1_0 -u 0.04802674385250277 > ./result_8chains/node333_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_2_0 -p 300 -st none -pt topic333_2_0 -u 0.038299229568086346 > ./result_8chains/node333_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_3_0 -p 402 -st none -pt topic333_3_0 -u 0.002857420726611215 > ./result_8chains/node333_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_4_0 -p 604 -st none -pt topic333_4_0 -u 0.0002542332397981184 > ./result_8chains/node333_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_5_0 -p 770 -st none -pt topic333_5_0 -u 0.029241181333686084 > ./result_8chains/node333_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_6_0 -p 798 -st none -pt topic333_6_0 -u 0.04262084022691409 > ./result_8chains/node333_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_7_0 -p 938 -st none -pt topic333_7_0 -u 0.004507401017889691 > ./result_8chains/node333_7_0.txt &
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
    "./result_8chains/node333_0_0.txt 90"
    "./result_8chains/node333_0_2.txt 90"
    "./result_8chains/node333_1_0.txt 89"
    "./result_8chains/node333_1_2.txt 89"
    "./result_8chains/node333_2_0.txt 88"
    "./result_8chains/node333_2_2.txt 88"
    "./result_8chains/node333_3_0.txt 87"
    "./result_8chains/node333_3_2.txt 87"
    "./result_8chains/node333_4_0.txt 86"
    "./result_8chains/node333_4_2.txt 86"
    "./result_8chains/node333_5_0.txt 85"
    "./result_8chains/node333_5_2.txt 85"
    "./result_8chains/node333_6_0.txt 84"
    "./result_8chains/node333_6_2.txt 84"
    "./result_8chains/node333_7_0.txt 83"
    "./result_8chains/node333_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
