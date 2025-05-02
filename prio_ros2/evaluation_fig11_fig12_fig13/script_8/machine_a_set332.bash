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
ros2 run evaluation_3_randomdag uunifast_node -n node332_0_2 -p 98 -st topic332_0_1 -pt None -u 0.016746853797596217 > ./result_8chains/node332_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node332_1_2 -p 133 -st topic332_1_1 -pt None -u 0.0008760279191079023 > ./result_8chains/node332_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_2_2 -p 244 -st topic332_2_1 -pt None -u 0.01212068535479055 > ./result_8chains/node332_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node332_3_2 -p 305 -st topic332_3_1 -pt None -u 0.026340322782658465 > ./result_8chains/node332_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_4_2 -p 412 -st topic332_4_1 -pt None -u 0.0139652636651324 > ./result_8chains/node332_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node332_5_2 -p 416 -st topic332_5_1 -pt None -u 0.02408393050150351 > ./result_8chains/node332_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_6_2 -p 692 -st topic332_6_1 -pt None -u 0.039985153611797795 > ./result_8chains/node332_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node332_7_2 -p 719 -st topic332_7_1 -pt None -u 0.009236351414758658 > ./result_8chains/node332_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_0_0 -p 98 -st none -pt topic332_0_0 -u 0.015528354231763852 > ./result_8chains/node332_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node332_1_0 -p 133 -st none -pt topic332_1_0 -u 0.004794888212681814 > ./result_8chains/node332_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_2_0 -p 244 -st none -pt topic332_2_0 -u 0.037130970650201434 > ./result_8chains/node332_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node332_3_0 -p 305 -st none -pt topic332_3_0 -u 0.01351855739711938 > ./result_8chains/node332_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_4_0 -p 412 -st none -pt topic332_4_0 -u 0.013347797677908668 > ./result_8chains/node332_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node332_5_0 -p 416 -st none -pt topic332_5_0 -u 0.024550522055006296 > ./result_8chains/node332_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_6_0 -p 692 -st none -pt topic332_6_0 -u 0.013359311371722277 > ./result_8chains/node332_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node332_7_0 -p 719 -st none -pt topic332_7_0 -u 0.01610020329144857 > ./result_8chains/node332_7_0.txt &
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
    "./result_8chains/node332_0_0.txt 90"
    "./result_8chains/node332_0_2.txt 90"
    "./result_8chains/node332_1_0.txt 89"
    "./result_8chains/node332_1_2.txt 89"
    "./result_8chains/node332_2_0.txt 88"
    "./result_8chains/node332_2_2.txt 88"
    "./result_8chains/node332_3_0.txt 87"
    "./result_8chains/node332_3_2.txt 87"
    "./result_8chains/node332_4_0.txt 86"
    "./result_8chains/node332_4_2.txt 86"
    "./result_8chains/node332_5_0.txt 85"
    "./result_8chains/node332_5_2.txt 85"
    "./result_8chains/node332_6_0.txt 84"
    "./result_8chains/node332_6_2.txt 84"
    "./result_8chains/node332_7_0.txt 83"
    "./result_8chains/node332_7_2.txt 83"
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
