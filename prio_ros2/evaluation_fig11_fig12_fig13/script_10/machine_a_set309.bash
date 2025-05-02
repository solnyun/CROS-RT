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
ros2 run evaluation_3_randomdag uunifast_node -n node309_0_2 -p 78 -st topic309_0_1 -pt None -u 0.0022067346174339253 > ./result_10chains/node309_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_1_2 -p 143 -st topic309_1_1 -pt None -u 0.03026990093116877 > ./result_10chains/node309_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_2_2 -p 546 -st topic309_2_1 -pt None -u 0.0037959159283924016 > ./result_10chains/node309_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_3_2 -p 553 -st topic309_3_1 -pt None -u 0.023923992058396737 > ./result_10chains/node309_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_4_2 -p 706 -st topic309_4_1 -pt None -u 0.010707893860898043 > ./result_10chains/node309_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_5_2 -p 788 -st topic309_5_1 -pt None -u 0.019350171743806988 > ./result_10chains/node309_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_6_2 -p 856 -st topic309_6_1 -pt None -u 0.010258693814709563 > ./result_10chains/node309_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_7_2 -p 939 -st topic309_7_1 -pt None -u 0.0006592035982529998 > ./result_10chains/node309_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_8_2 -p 955 -st topic309_8_1 -pt None -u 0.016687502558802386 > ./result_10chains/node309_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_9_2 -p 959 -st topic309_9_1 -pt None -u 0.08768153464419653 > ./result_10chains/node309_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_0_0 -p 78 -st none -pt topic309_0_0 -u 0.01517221630044352 > ./result_10chains/node309_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_1_0 -p 143 -st none -pt topic309_1_0 -u 0.00844779927018996 > ./result_10chains/node309_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_2_0 -p 546 -st none -pt topic309_2_0 -u 0.0044981743286097164 > ./result_10chains/node309_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_3_0 -p 553 -st none -pt topic309_3_0 -u 0.036639512721068745 > ./result_10chains/node309_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_4_0 -p 706 -st none -pt topic309_4_0 -u 0.020829573565345594 > ./result_10chains/node309_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_5_0 -p 788 -st none -pt topic309_5_0 -u 0.043712933255765224 > ./result_10chains/node309_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_6_0 -p 856 -st none -pt topic309_6_0 -u 0.003739095810871451 > ./result_10chains/node309_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_7_0 -p 939 -st none -pt topic309_7_0 -u 0.02407919472769457 > ./result_10chains/node309_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_8_0 -p 955 -st none -pt topic309_8_0 -u 0.0019324781777857458 > ./result_10chains/node309_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_9_0 -p 959 -st none -pt topic309_9_0 -u 0.026848920036683585 > ./result_10chains/node309_9_0.txt &
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
    "./result_10chains/node309_0_0.txt 90"
    "./result_10chains/node309_0_2.txt 90"
    "./result_10chains/node309_1_0.txt 89"
    "./result_10chains/node309_1_2.txt 89"
    "./result_10chains/node309_2_0.txt 88"
    "./result_10chains/node309_2_2.txt 88"
    "./result_10chains/node309_3_0.txt 87"
    "./result_10chains/node309_3_2.txt 87"
    "./result_10chains/node309_4_0.txt 86"
    "./result_10chains/node309_4_2.txt 86"
    "./result_10chains/node309_5_0.txt 85"
    "./result_10chains/node309_5_2.txt 85"
    "./result_10chains/node309_6_0.txt 84"
    "./result_10chains/node309_6_2.txt 84"
    "./result_10chains/node309_7_0.txt 83"
    "./result_10chains/node309_7_2.txt 83"
    "./result_10chains/node309_8_0.txt 82"
    "./result_10chains/node309_8_2.txt 82"
    "./result_10chains/node309_9_0.txt 81"
    "./result_10chains/node309_9_2.txt 81"
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
