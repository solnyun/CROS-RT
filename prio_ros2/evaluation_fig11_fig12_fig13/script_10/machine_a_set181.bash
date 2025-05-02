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
ros2 run evaluation_3_randomdag uunifast_node -n node181_0_2 -p 26 -st topic181_0_1 -pt None -u 0.006130820378344892 > ./result_10chains/node181_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node181_1_2 -p 226 -st topic181_1_1 -pt None -u 0.008225035040716977 > ./result_10chains/node181_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_2_2 -p 280 -st topic181_2_1 -pt None -u 0.013047200536507597 > ./result_10chains/node181_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node181_3_2 -p 393 -st topic181_3_1 -pt None -u 0.009314134897694282 > ./result_10chains/node181_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_4_2 -p 436 -st topic181_4_1 -pt None -u 0.0020468901436743736 > ./result_10chains/node181_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node181_5_2 -p 704 -st topic181_5_1 -pt None -u 0.029167011442150503 > ./result_10chains/node181_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_6_2 -p 733 -st topic181_6_1 -pt None -u 0.015050115465956443 > ./result_10chains/node181_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node181_7_2 -p 861 -st topic181_7_1 -pt None -u 0.02692486371296314 > ./result_10chains/node181_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_8_2 -p 871 -st topic181_8_1 -pt None -u 0.0010089620595532534 > ./result_10chains/node181_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node181_9_2 -p 998 -st topic181_9_1 -pt None -u 0.04186627063358026 > ./result_10chains/node181_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_0_0 -p 26 -st none -pt topic181_0_0 -u 0.0005628094168214637 > ./result_10chains/node181_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node181_1_0 -p 226 -st none -pt topic181_1_0 -u 0.007938655781849824 > ./result_10chains/node181_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_2_0 -p 280 -st none -pt topic181_2_0 -u 0.03413726392909372 > ./result_10chains/node181_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node181_3_0 -p 393 -st none -pt topic181_3_0 -u 0.0037021283436264874 > ./result_10chains/node181_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_4_0 -p 436 -st none -pt topic181_4_0 -u 0.003656534530117217 > ./result_10chains/node181_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node181_5_0 -p 704 -st none -pt topic181_5_0 -u 0.04698908918793748 > ./result_10chains/node181_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_6_0 -p 733 -st none -pt topic181_6_0 -u 0.009328105340608267 > ./result_10chains/node181_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node181_7_0 -p 861 -st none -pt topic181_7_0 -u 0.043341731297641156 > ./result_10chains/node181_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_8_0 -p 871 -st none -pt topic181_8_0 -u 0.008611258832562946 > ./result_10chains/node181_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node181_9_0 -p 998 -st none -pt topic181_9_0 -u 0.055475270076885075 > ./result_10chains/node181_9_0.txt &
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
    "./result_10chains/node181_0_0.txt 90"
    "./result_10chains/node181_0_2.txt 90"
    "./result_10chains/node181_1_0.txt 89"
    "./result_10chains/node181_1_2.txt 89"
    "./result_10chains/node181_2_0.txt 88"
    "./result_10chains/node181_2_2.txt 88"
    "./result_10chains/node181_3_0.txt 87"
    "./result_10chains/node181_3_2.txt 87"
    "./result_10chains/node181_4_0.txt 86"
    "./result_10chains/node181_4_2.txt 86"
    "./result_10chains/node181_5_0.txt 85"
    "./result_10chains/node181_5_2.txt 85"
    "./result_10chains/node181_6_0.txt 84"
    "./result_10chains/node181_6_2.txt 84"
    "./result_10chains/node181_7_0.txt 83"
    "./result_10chains/node181_7_2.txt 83"
    "./result_10chains/node181_8_0.txt 82"
    "./result_10chains/node181_8_2.txt 82"
    "./result_10chains/node181_9_0.txt 81"
    "./result_10chains/node181_9_2.txt 81"
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
