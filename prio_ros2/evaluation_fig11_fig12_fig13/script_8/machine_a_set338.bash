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
ros2 run evaluation_3_randomdag uunifast_node -n node338_0_2 -p 99 -st topic338_0_1 -pt None -u 0.006586278703357373 > ./result_8chains/node338_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_1_2 -p 438 -st topic338_1_1 -pt None -u 0.02463892648292254 > ./result_8chains/node338_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_2_2 -p 442 -st topic338_2_1 -pt None -u 0.04391375705763556 > ./result_8chains/node338_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_3_2 -p 562 -st topic338_3_1 -pt None -u 0.05981499710623803 > ./result_8chains/node338_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_4_2 -p 570 -st topic338_4_1 -pt None -u 0.03215204282010871 > ./result_8chains/node338_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_5_2 -p 616 -st topic338_5_1 -pt None -u 0.0039010847512678665 > ./result_8chains/node338_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_6_2 -p 959 -st topic338_6_1 -pt None -u 0.03263034270543968 > ./result_8chains/node338_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_7_2 -p 975 -st topic338_7_1 -pt None -u 0.025450110090832943 > ./result_8chains/node338_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_0_0 -p 99 -st none -pt topic338_0_0 -u 0.012629645121509214 > ./result_8chains/node338_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_1_0 -p 438 -st none -pt topic338_1_0 -u 0.02037261883237723 > ./result_8chains/node338_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_2_0 -p 442 -st none -pt topic338_2_0 -u 0.004406880234009869 > ./result_8chains/node338_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_3_0 -p 562 -st none -pt topic338_3_0 -u 0.023845159970749763 > ./result_8chains/node338_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_4_0 -p 570 -st none -pt topic338_4_0 -u 0.07452352475484542 > ./result_8chains/node338_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_5_0 -p 616 -st none -pt topic338_5_0 -u 0.018404414818343803 > ./result_8chains/node338_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_6_0 -p 959 -st none -pt topic338_6_0 -u 0.02186749107515487 > ./result_8chains/node338_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_7_0 -p 975 -st none -pt topic338_7_0 -u 0.0020383875536709277 > ./result_8chains/node338_7_0.txt &
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
    "./result_8chains/node338_0_0.txt 90"
    "./result_8chains/node338_0_2.txt 90"
    "./result_8chains/node338_1_0.txt 89"
    "./result_8chains/node338_1_2.txt 89"
    "./result_8chains/node338_2_0.txt 88"
    "./result_8chains/node338_2_2.txt 88"
    "./result_8chains/node338_3_0.txt 87"
    "./result_8chains/node338_3_2.txt 87"
    "./result_8chains/node338_4_0.txt 86"
    "./result_8chains/node338_4_2.txt 86"
    "./result_8chains/node338_5_0.txt 85"
    "./result_8chains/node338_5_2.txt 85"
    "./result_8chains/node338_6_0.txt 84"
    "./result_8chains/node338_6_2.txt 84"
    "./result_8chains/node338_7_0.txt 83"
    "./result_8chains/node338_7_2.txt 83"
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
