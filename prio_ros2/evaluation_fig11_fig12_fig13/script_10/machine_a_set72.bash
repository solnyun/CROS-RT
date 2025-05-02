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
ros2 run evaluation_3_randomdag uunifast_node -n node72_0_2 -p 17 -st topic72_0_1 -pt None -u 0.00015362844148886223 > ./result_10chains/node72_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_1_2 -p 150 -st topic72_1_1 -pt None -u 0.01151398019875377 > ./result_10chains/node72_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_2_2 -p 294 -st topic72_2_1 -pt None -u 0.005597196864010057 > ./result_10chains/node72_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_3_2 -p 333 -st topic72_3_1 -pt None -u 0.04076228065073617 > ./result_10chains/node72_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_4_2 -p 383 -st topic72_4_1 -pt None -u 0.0152511188989429 > ./result_10chains/node72_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_5_2 -p 499 -st topic72_5_1 -pt None -u 0.0005369775560078449 > ./result_10chains/node72_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_6_2 -p 526 -st topic72_6_1 -pt None -u 0.019275214228143794 > ./result_10chains/node72_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_7_2 -p 669 -st topic72_7_1 -pt None -u 0.042798761002523125 > ./result_10chains/node72_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_8_2 -p 845 -st topic72_8_1 -pt None -u 0.019722411270548024 > ./result_10chains/node72_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_9_2 -p 911 -st topic72_9_1 -pt None -u 0.010408449283882883 > ./result_10chains/node72_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_0_0 -p 17 -st none -pt topic72_0_0 -u 0.012964582779296185 > ./result_10chains/node72_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_1_0 -p 150 -st none -pt topic72_1_0 -u 0.030481131057879307 > ./result_10chains/node72_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_2_0 -p 294 -st none -pt topic72_2_0 -u 0.055401733492324357 > ./result_10chains/node72_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_3_0 -p 333 -st none -pt topic72_3_0 -u 0.013667932189203646 > ./result_10chains/node72_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_4_0 -p 383 -st none -pt topic72_4_0 -u 0.012204341218186254 > ./result_10chains/node72_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_5_0 -p 499 -st none -pt topic72_5_0 -u 0.0012398312696615676 > ./result_10chains/node72_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_6_0 -p 526 -st none -pt topic72_6_0 -u 0.04495129070194134 > ./result_10chains/node72_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_7_0 -p 669 -st none -pt topic72_7_0 -u 0.004146136751005891 > ./result_10chains/node72_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_8_0 -p 845 -st none -pt topic72_8_0 -u 0.007733211346593119 > ./result_10chains/node72_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_9_0 -p 911 -st none -pt topic72_9_0 -u 0.022454800171053845 > ./result_10chains/node72_9_0.txt &
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
    "./result_10chains/node72_0_0.txt 90"
    "./result_10chains/node72_0_2.txt 90"
    "./result_10chains/node72_1_0.txt 89"
    "./result_10chains/node72_1_2.txt 89"
    "./result_10chains/node72_2_0.txt 88"
    "./result_10chains/node72_2_2.txt 88"
    "./result_10chains/node72_3_0.txt 87"
    "./result_10chains/node72_3_2.txt 87"
    "./result_10chains/node72_4_0.txt 86"
    "./result_10chains/node72_4_2.txt 86"
    "./result_10chains/node72_5_0.txt 85"
    "./result_10chains/node72_5_2.txt 85"
    "./result_10chains/node72_6_0.txt 84"
    "./result_10chains/node72_6_2.txt 84"
    "./result_10chains/node72_7_0.txt 83"
    "./result_10chains/node72_7_2.txt 83"
    "./result_10chains/node72_8_0.txt 82"
    "./result_10chains/node72_8_2.txt 82"
    "./result_10chains/node72_9_0.txt 81"
    "./result_10chains/node72_9_2.txt 81"
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
