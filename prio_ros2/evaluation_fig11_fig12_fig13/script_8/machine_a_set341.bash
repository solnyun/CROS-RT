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
ros2 run evaluation_3_randomdag uunifast_node -n node341_0_2 -p 123 -st topic341_0_1 -pt None -u 0.008995967080350553 > ./result_8chains/node341_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_1_2 -p 206 -st topic341_1_1 -pt None -u 0.03237074795799427 > ./result_8chains/node341_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_2_2 -p 212 -st topic341_2_1 -pt None -u 0.04358207806768072 > ./result_8chains/node341_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_3_2 -p 408 -st topic341_3_1 -pt None -u 0.032347615341410535 > ./result_8chains/node341_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_4_2 -p 411 -st topic341_4_1 -pt None -u 0.022437835053487426 > ./result_8chains/node341_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_5_2 -p 636 -st topic341_5_1 -pt None -u 0.008439994077150348 > ./result_8chains/node341_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_6_2 -p 670 -st topic341_6_1 -pt None -u 0.004782721246004942 > ./result_8chains/node341_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_7_2 -p 926 -st topic341_7_1 -pt None -u 0.06303523693192824 > ./result_8chains/node341_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_0_0 -p 123 -st none -pt topic341_0_0 -u 0.008484966048535048 > ./result_8chains/node341_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_1_0 -p 206 -st none -pt topic341_1_0 -u 0.06877282605472246 > ./result_8chains/node341_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_2_0 -p 212 -st none -pt topic341_2_0 -u 0.04764685922365414 > ./result_8chains/node341_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_3_0 -p 408 -st none -pt topic341_3_0 -u 0.011826455919686008 > ./result_8chains/node341_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_4_0 -p 411 -st none -pt topic341_4_0 -u 0.0099427857257402 > ./result_8chains/node341_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_5_0 -p 636 -st none -pt topic341_5_0 -u 0.007401663474232711 > ./result_8chains/node341_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_6_0 -p 670 -st none -pt topic341_6_0 -u 0.03747627284785364 > ./result_8chains/node341_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_7_0 -p 926 -st none -pt topic341_7_0 -u 0.0009964266716327302 > ./result_8chains/node341_7_0.txt &
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
    "./result_8chains/node341_0_0.txt 90"
    "./result_8chains/node341_0_2.txt 90"
    "./result_8chains/node341_1_0.txt 89"
    "./result_8chains/node341_1_2.txt 89"
    "./result_8chains/node341_2_0.txt 88"
    "./result_8chains/node341_2_2.txt 88"
    "./result_8chains/node341_3_0.txt 87"
    "./result_8chains/node341_3_2.txt 87"
    "./result_8chains/node341_4_0.txt 86"
    "./result_8chains/node341_4_2.txt 86"
    "./result_8chains/node341_5_0.txt 85"
    "./result_8chains/node341_5_2.txt 85"
    "./result_8chains/node341_6_0.txt 84"
    "./result_8chains/node341_6_2.txt 84"
    "./result_8chains/node341_7_0.txt 83"
    "./result_8chains/node341_7_2.txt 83"
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
