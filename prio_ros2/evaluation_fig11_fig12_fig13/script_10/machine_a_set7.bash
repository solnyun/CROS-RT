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
ros2 run evaluation_3_randomdag uunifast_node -n node7_0_2 -p 25 -st topic7_0_1 -pt None -u 0.02157621794425285 > ./result_10chains/node7_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_1_2 -p 115 -st topic7_1_1 -pt None -u 0.004608810177466616 > ./result_10chains/node7_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_2_2 -p 236 -st topic7_2_1 -pt None -u 0.04798026715194359 > ./result_10chains/node7_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_3_2 -p 267 -st topic7_3_1 -pt None -u 0.0023437993125914325 > ./result_10chains/node7_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_4_2 -p 273 -st topic7_4_1 -pt None -u 0.02149394482455544 > ./result_10chains/node7_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_5_2 -p 331 -st topic7_5_1 -pt None -u 0.0009099045475802203 > ./result_10chains/node7_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_6_2 -p 471 -st topic7_6_1 -pt None -u 0.004488707356300248 > ./result_10chains/node7_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_7_2 -p 670 -st topic7_7_1 -pt None -u 0.007494987650920937 > ./result_10chains/node7_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_8_2 -p 742 -st topic7_8_1 -pt None -u 0.0020723610615097157 > ./result_10chains/node7_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_9_2 -p 820 -st topic7_9_1 -pt None -u 0.008808354632206136 > ./result_10chains/node7_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_0_0 -p 25 -st none -pt topic7_0_0 -u 0.014234286695014975 > ./result_10chains/node7_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_1_0 -p 115 -st none -pt topic7_1_0 -u 0.01134072403851838 > ./result_10chains/node7_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_2_0 -p 236 -st none -pt topic7_2_0 -u 0.0013557598752129696 > ./result_10chains/node7_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_3_0 -p 267 -st none -pt topic7_3_0 -u 0.0017200516239762598 > ./result_10chains/node7_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_4_0 -p 273 -st none -pt topic7_4_0 -u 0.04905897017511776 > ./result_10chains/node7_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_5_0 -p 331 -st none -pt topic7_5_0 -u 0.027037523040101735 > ./result_10chains/node7_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_6_0 -p 471 -st none -pt topic7_6_0 -u 0.028045191032194022 > ./result_10chains/node7_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_7_0 -p 670 -st none -pt topic7_7_0 -u 0.003126270404673004 > ./result_10chains/node7_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_8_0 -p 742 -st none -pt topic7_8_0 -u 0.06764515352163333 > ./result_10chains/node7_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_9_0 -p 820 -st none -pt topic7_9_0 -u 0.009954877911148753 > ./result_10chains/node7_9_0.txt &
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
    "./result_10chains/node7_0_0.txt 90"
    "./result_10chains/node7_0_2.txt 90"
    "./result_10chains/node7_1_0.txt 89"
    "./result_10chains/node7_1_2.txt 89"
    "./result_10chains/node7_2_0.txt 88"
    "./result_10chains/node7_2_2.txt 88"
    "./result_10chains/node7_3_0.txt 87"
    "./result_10chains/node7_3_2.txt 87"
    "./result_10chains/node7_4_0.txt 86"
    "./result_10chains/node7_4_2.txt 86"
    "./result_10chains/node7_5_0.txt 85"
    "./result_10chains/node7_5_2.txt 85"
    "./result_10chains/node7_6_0.txt 84"
    "./result_10chains/node7_6_2.txt 84"
    "./result_10chains/node7_7_0.txt 83"
    "./result_10chains/node7_7_2.txt 83"
    "./result_10chains/node7_8_0.txt 82"
    "./result_10chains/node7_8_2.txt 82"
    "./result_10chains/node7_9_0.txt 81"
    "./result_10chains/node7_9_2.txt 81"
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
