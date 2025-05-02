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
ros2 run evaluation_3_randomdag uunifast_node -n node286_0_2 -p 95 -st topic286_0_1 -pt None -u 2.5199003053533175e-05 > ./result_8chains/node286_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_1_2 -p 103 -st topic286_1_1 -pt None -u 0.019659069300144716 > ./result_8chains/node286_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_2_2 -p 358 -st topic286_2_1 -pt None -u 0.014592244745904481 > ./result_8chains/node286_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_3_2 -p 558 -st topic286_3_1 -pt None -u 0.0003377193649822807 > ./result_8chains/node286_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_4_2 -p 649 -st topic286_4_1 -pt None -u 0.022914893929862512 > ./result_8chains/node286_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_5_2 -p 670 -st topic286_5_1 -pt None -u 0.0014243757611063224 > ./result_8chains/node286_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_6_2 -p 794 -st topic286_6_1 -pt None -u 0.015235612697037243 > ./result_8chains/node286_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_7_2 -p 838 -st topic286_7_1 -pt None -u 0.0024000075357272217 > ./result_8chains/node286_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_0_0 -p 95 -st none -pt topic286_0_0 -u 0.0365568985648938 > ./result_8chains/node286_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_1_0 -p 103 -st none -pt topic286_1_0 -u 0.0063103941312064316 > ./result_8chains/node286_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_2_0 -p 358 -st none -pt topic286_2_0 -u 0.0006689530968627677 > ./result_8chains/node286_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_3_0 -p 558 -st none -pt topic286_3_0 -u 0.010118336743847711 > ./result_8chains/node286_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_4_0 -p 649 -st none -pt topic286_4_0 -u 0.0037256059903103544 > ./result_8chains/node286_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_5_0 -p 670 -st none -pt topic286_5_0 -u 0.03564014098369073 > ./result_8chains/node286_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_6_0 -p 794 -st none -pt topic286_6_0 -u 0.052508527323354065 > ./result_8chains/node286_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_7_0 -p 838 -st none -pt topic286_7_0 -u 0.023986341600971392 > ./result_8chains/node286_7_0.txt &
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
    "./result_8chains/node286_0_0.txt 90"
    "./result_8chains/node286_0_2.txt 90"
    "./result_8chains/node286_1_0.txt 89"
    "./result_8chains/node286_1_2.txt 89"
    "./result_8chains/node286_2_0.txt 88"
    "./result_8chains/node286_2_2.txt 88"
    "./result_8chains/node286_3_0.txt 87"
    "./result_8chains/node286_3_2.txt 87"
    "./result_8chains/node286_4_0.txt 86"
    "./result_8chains/node286_4_2.txt 86"
    "./result_8chains/node286_5_0.txt 85"
    "./result_8chains/node286_5_2.txt 85"
    "./result_8chains/node286_6_0.txt 84"
    "./result_8chains/node286_6_2.txt 84"
    "./result_8chains/node286_7_0.txt 83"
    "./result_8chains/node286_7_2.txt 83"
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
