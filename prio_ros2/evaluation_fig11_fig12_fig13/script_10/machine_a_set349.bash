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
ros2 run evaluation_3_randomdag uunifast_node -n node349_0_2 -p 195 -st topic349_0_1 -pt None -u 0.01494812851845867 > ./result_10chains/node349_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_1_2 -p 381 -st topic349_1_1 -pt None -u 0.02338650802936748 > ./result_10chains/node349_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_2_2 -p 390 -st topic349_2_1 -pt None -u 0.009273548919761454 > ./result_10chains/node349_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_3_2 -p 404 -st topic349_3_1 -pt None -u 0.016421084098471095 > ./result_10chains/node349_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_4_2 -p 567 -st topic349_4_1 -pt None -u 0.005137759576853529 > ./result_10chains/node349_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_5_2 -p 703 -st topic349_5_1 -pt None -u 0.04775075959948605 > ./result_10chains/node349_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_6_2 -p 933 -st topic349_6_1 -pt None -u 0.04149659785517004 > ./result_10chains/node349_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_7_2 -p 956 -st topic349_7_1 -pt None -u 0.006241576259208598 > ./result_10chains/node349_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_8_2 -p 977 -st topic349_8_1 -pt None -u 0.01439000399962078 > ./result_10chains/node349_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_9_2 -p 978 -st topic349_9_1 -pt None -u 0.020562310657879654 > ./result_10chains/node349_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_0_0 -p 195 -st none -pt topic349_0_0 -u 0.02093695970820042 > ./result_10chains/node349_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_1_0 -p 381 -st none -pt topic349_1_0 -u 0.0009240013247145407 > ./result_10chains/node349_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_2_0 -p 390 -st none -pt topic349_2_0 -u 0.010852879723063147 > ./result_10chains/node349_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_3_0 -p 404 -st none -pt topic349_3_0 -u 0.04727245960707449 > ./result_10chains/node349_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_4_0 -p 567 -st none -pt topic349_4_0 -u 0.00950630432368832 > ./result_10chains/node349_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_5_0 -p 703 -st none -pt topic349_5_0 -u 0.0047577177139057625 > ./result_10chains/node349_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_6_0 -p 933 -st none -pt topic349_6_0 -u 0.018598593856069406 > ./result_10chains/node349_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_7_0 -p 956 -st none -pt topic349_7_0 -u 0.007438063486775143 > ./result_10chains/node349_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_8_0 -p 977 -st none -pt topic349_8_0 -u 0.010295968084050991 > ./result_10chains/node349_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_9_0 -p 978 -st none -pt topic349_9_0 -u 0.01589996053530229 > ./result_10chains/node349_9_0.txt &
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
    "./result_10chains/node349_0_0.txt 90"
    "./result_10chains/node349_0_2.txt 90"
    "./result_10chains/node349_1_0.txt 89"
    "./result_10chains/node349_1_2.txt 89"
    "./result_10chains/node349_2_0.txt 88"
    "./result_10chains/node349_2_2.txt 88"
    "./result_10chains/node349_3_0.txt 87"
    "./result_10chains/node349_3_2.txt 87"
    "./result_10chains/node349_4_0.txt 86"
    "./result_10chains/node349_4_2.txt 86"
    "./result_10chains/node349_5_0.txt 85"
    "./result_10chains/node349_5_2.txt 85"
    "./result_10chains/node349_6_0.txt 84"
    "./result_10chains/node349_6_2.txt 84"
    "./result_10chains/node349_7_0.txt 83"
    "./result_10chains/node349_7_2.txt 83"
    "./result_10chains/node349_8_0.txt 82"
    "./result_10chains/node349_8_2.txt 82"
    "./result_10chains/node349_9_0.txt 81"
    "./result_10chains/node349_9_2.txt 81"
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
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
