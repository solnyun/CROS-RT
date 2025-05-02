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
ros2 run evaluation_3_randomdag uunifast_node -n node438_0_2 -p 269 -st topic438_0_1 -pt None -u 0.017943641097631358 > ./result_8chains/node438_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_1_2 -p 289 -st topic438_1_1 -pt None -u 0.032844972503825065 > ./result_8chains/node438_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_2_2 -p 290 -st topic438_2_1 -pt None -u 0.0027909626866092774 > ./result_8chains/node438_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_3_2 -p 388 -st topic438_3_1 -pt None -u 0.029786725013697973 > ./result_8chains/node438_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_4_2 -p 438 -st topic438_4_1 -pt None -u 0.02461464690095677 > ./result_8chains/node438_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_5_2 -p 508 -st topic438_5_1 -pt None -u 0.030203785415297474 > ./result_8chains/node438_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_6_2 -p 664 -st topic438_6_1 -pt None -u 0.01672166427812217 > ./result_8chains/node438_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_7_2 -p 689 -st topic438_7_1 -pt None -u 0.034644247677569316 > ./result_8chains/node438_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_0_0 -p 269 -st none -pt topic438_0_0 -u 0.01374291483637291 > ./result_8chains/node438_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_1_0 -p 289 -st none -pt topic438_1_0 -u 0.010807193810640547 > ./result_8chains/node438_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_2_0 -p 290 -st none -pt topic438_2_0 -u 0.010951400064383832 > ./result_8chains/node438_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_3_0 -p 388 -st none -pt topic438_3_0 -u 0.01876230795364403 > ./result_8chains/node438_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_4_0 -p 438 -st none -pt topic438_4_0 -u 0.003320331742438426 > ./result_8chains/node438_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_5_0 -p 508 -st none -pt topic438_5_0 -u 0.007111757169650124 > ./result_8chains/node438_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_6_0 -p 664 -st none -pt topic438_6_0 -u 0.0024862158792352124 > ./result_8chains/node438_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_7_0 -p 689 -st none -pt topic438_7_0 -u 0.007704262290423175 > ./result_8chains/node438_7_0.txt &
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
    "./result_8chains/node438_0_0.txt 90"
    "./result_8chains/node438_0_2.txt 90"
    "./result_8chains/node438_1_0.txt 89"
    "./result_8chains/node438_1_2.txt 89"
    "./result_8chains/node438_2_0.txt 88"
    "./result_8chains/node438_2_2.txt 88"
    "./result_8chains/node438_3_0.txt 87"
    "./result_8chains/node438_3_2.txt 87"
    "./result_8chains/node438_4_0.txt 86"
    "./result_8chains/node438_4_2.txt 86"
    "./result_8chains/node438_5_0.txt 85"
    "./result_8chains/node438_5_2.txt 85"
    "./result_8chains/node438_6_0.txt 84"
    "./result_8chains/node438_6_2.txt 84"
    "./result_8chains/node438_7_0.txt 83"
    "./result_8chains/node438_7_2.txt 83"
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
