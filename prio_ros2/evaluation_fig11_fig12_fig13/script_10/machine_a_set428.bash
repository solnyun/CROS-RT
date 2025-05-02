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
ros2 run evaluation_3_randomdag uunifast_node -n node428_0_2 -p 26 -st topic428_0_1 -pt None -u 0.04095099179647149 > ./result_10chains/node428_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_1_2 -p 56 -st topic428_1_1 -pt None -u 0.03158197740104546 > ./result_10chains/node428_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_2_2 -p 248 -st topic428_2_1 -pt None -u 0.003185218328935202 > ./result_10chains/node428_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_3_2 -p 272 -st topic428_3_1 -pt None -u 0.009318247852359296 > ./result_10chains/node428_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_4_2 -p 344 -st topic428_4_1 -pt None -u 0.006078256219388012 > ./result_10chains/node428_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_5_2 -p 733 -st topic428_5_1 -pt None -u 0.012443404761085464 > ./result_10chains/node428_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_6_2 -p 776 -st topic428_6_1 -pt None -u 0.0020284717501428406 > ./result_10chains/node428_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_7_2 -p 808 -st topic428_7_1 -pt None -u 0.0698514087551948 > ./result_10chains/node428_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_8_2 -p 837 -st topic428_8_1 -pt None -u 0.015584207536971317 > ./result_10chains/node428_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_9_2 -p 876 -st topic428_9_1 -pt None -u 0.016861262241344467 > ./result_10chains/node428_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_0_0 -p 26 -st none -pt topic428_0_0 -u 0.002891023617157429 > ./result_10chains/node428_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_1_0 -p 56 -st none -pt topic428_1_0 -u 0.011738015057577544 > ./result_10chains/node428_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_2_0 -p 248 -st none -pt topic428_2_0 -u 0.04215559121187984 > ./result_10chains/node428_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_3_0 -p 272 -st none -pt topic428_3_0 -u 0.0019741716649976926 > ./result_10chains/node428_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_4_0 -p 344 -st none -pt topic428_4_0 -u 0.0070886846253523095 > ./result_10chains/node428_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_5_0 -p 733 -st none -pt topic428_5_0 -u 0.009872997712552928 > ./result_10chains/node428_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_6_0 -p 776 -st none -pt topic428_6_0 -u 0.019917165722056818 > ./result_10chains/node428_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_7_0 -p 808 -st none -pt topic428_7_0 -u 0.03221908411431501 > ./result_10chains/node428_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_8_0 -p 837 -st none -pt topic428_8_0 -u 0.004055276278311669 > ./result_10chains/node428_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_9_0 -p 876 -st none -pt topic428_9_0 -u 0.012570374581108483 > ./result_10chains/node428_9_0.txt &
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
    "./result_10chains/node428_0_0.txt 90"
    "./result_10chains/node428_0_2.txt 90"
    "./result_10chains/node428_1_0.txt 89"
    "./result_10chains/node428_1_2.txt 89"
    "./result_10chains/node428_2_0.txt 88"
    "./result_10chains/node428_2_2.txt 88"
    "./result_10chains/node428_3_0.txt 87"
    "./result_10chains/node428_3_2.txt 87"
    "./result_10chains/node428_4_0.txt 86"
    "./result_10chains/node428_4_2.txt 86"
    "./result_10chains/node428_5_0.txt 85"
    "./result_10chains/node428_5_2.txt 85"
    "./result_10chains/node428_6_0.txt 84"
    "./result_10chains/node428_6_2.txt 84"
    "./result_10chains/node428_7_0.txt 83"
    "./result_10chains/node428_7_2.txt 83"
    "./result_10chains/node428_8_0.txt 82"
    "./result_10chains/node428_8_2.txt 82"
    "./result_10chains/node428_9_0.txt 81"
    "./result_10chains/node428_9_2.txt 81"
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
