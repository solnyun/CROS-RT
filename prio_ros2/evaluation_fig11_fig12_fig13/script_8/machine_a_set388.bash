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
ros2 run evaluation_3_randomdag uunifast_node -n node388_0_2 -p 128 -st topic388_0_1 -pt None -u 0.016103063493360437 > ./result_8chains/node388_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_1_2 -p 216 -st topic388_1_1 -pt None -u 0.03648125587098339 > ./result_8chains/node388_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_2_2 -p 277 -st topic388_2_1 -pt None -u 0.006881567157412949 > ./result_8chains/node388_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_3_2 -p 377 -st topic388_3_1 -pt None -u 0.02571511606130894 > ./result_8chains/node388_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_4_2 -p 421 -st topic388_4_1 -pt None -u 0.02504743508828311 > ./result_8chains/node388_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_5_2 -p 559 -st topic388_5_1 -pt None -u 0.011961175086084255 > ./result_8chains/node388_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_6_2 -p 573 -st topic388_6_1 -pt None -u 0.012359951298153704 > ./result_8chains/node388_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_7_2 -p 899 -st topic388_7_1 -pt None -u 0.013774846888909408 > ./result_8chains/node388_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_0_0 -p 128 -st none -pt topic388_0_0 -u 0.01592210768104957 > ./result_8chains/node388_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_1_0 -p 216 -st none -pt topic388_1_0 -u 0.03102185317349576 > ./result_8chains/node388_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_2_0 -p 277 -st none -pt topic388_2_0 -u 0.047060745425697936 > ./result_8chains/node388_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_3_0 -p 377 -st none -pt topic388_3_0 -u 0.06158890563154665 > ./result_8chains/node388_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_4_0 -p 421 -st none -pt topic388_4_0 -u 0.001338283227998921 > ./result_8chains/node388_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_5_0 -p 559 -st none -pt topic388_5_0 -u 0.009000683241241564 > ./result_8chains/node388_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_6_0 -p 573 -st none -pt topic388_6_0 -u 0.04842926723370689 > ./result_8chains/node388_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_7_0 -p 899 -st none -pt topic388_7_0 -u 0.010690724515251167 > ./result_8chains/node388_7_0.txt &
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
    "./result_8chains/node388_0_0.txt 90"
    "./result_8chains/node388_0_2.txt 90"
    "./result_8chains/node388_1_0.txt 89"
    "./result_8chains/node388_1_2.txt 89"
    "./result_8chains/node388_2_0.txt 88"
    "./result_8chains/node388_2_2.txt 88"
    "./result_8chains/node388_3_0.txt 87"
    "./result_8chains/node388_3_2.txt 87"
    "./result_8chains/node388_4_0.txt 86"
    "./result_8chains/node388_4_2.txt 86"
    "./result_8chains/node388_5_0.txt 85"
    "./result_8chains/node388_5_2.txt 85"
    "./result_8chains/node388_6_0.txt 84"
    "./result_8chains/node388_6_2.txt 84"
    "./result_8chains/node388_7_0.txt 83"
    "./result_8chains/node388_7_2.txt 83"
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
