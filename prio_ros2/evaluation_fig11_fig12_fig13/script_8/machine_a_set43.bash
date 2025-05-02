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
ros2 run evaluation_3_randomdag uunifast_node -n node43_0_2 -p 82 -st topic43_0_1 -pt None -u 0.07061711939631476 > ./result_8chains/node43_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_1_2 -p 119 -st topic43_1_1 -pt None -u 0.027875093893870384 > ./result_8chains/node43_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_2_2 -p 164 -st topic43_2_1 -pt None -u 0.025398942052750118 > ./result_8chains/node43_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_3_2 -p 247 -st topic43_3_1 -pt None -u 0.005858565783249253 > ./result_8chains/node43_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_4_2 -p 270 -st topic43_4_1 -pt None -u 0.024685163907661095 > ./result_8chains/node43_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_5_2 -p 529 -st topic43_5_1 -pt None -u 0.003981306746990501 > ./result_8chains/node43_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_6_2 -p 852 -st topic43_6_1 -pt None -u 0.009205969113294327 > ./result_8chains/node43_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_7_2 -p 917 -st topic43_7_1 -pt None -u 0.0013728118564811157 > ./result_8chains/node43_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_0_0 -p 82 -st none -pt topic43_0_0 -u 0.013281199167522406 > ./result_8chains/node43_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_1_0 -p 119 -st none -pt topic43_1_0 -u 0.02079486751194981 > ./result_8chains/node43_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_2_0 -p 164 -st none -pt topic43_2_0 -u 0.007180537137372656 > ./result_8chains/node43_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_3_0 -p 247 -st none -pt topic43_3_0 -u 0.028932932758343244 > ./result_8chains/node43_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_4_0 -p 270 -st none -pt topic43_4_0 -u 0.02076664059172359 > ./result_8chains/node43_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_5_0 -p 529 -st none -pt topic43_5_0 -u 0.044491715560578626 > ./result_8chains/node43_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_6_0 -p 852 -st none -pt topic43_6_0 -u 0.00016055198869005527 > ./result_8chains/node43_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_7_0 -p 917 -st none -pt topic43_7_0 -u 0.020221682952907976 > ./result_8chains/node43_7_0.txt &
sleep 10
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
    "./result_8chains/node43_0_0.txt 90"
    "./result_8chains/node43_0_2.txt 90"
    "./result_8chains/node43_1_0.txt 89"
    "./result_8chains/node43_1_2.txt 89"
    "./result_8chains/node43_2_0.txt 88"
    "./result_8chains/node43_2_2.txt 88"
    "./result_8chains/node43_3_0.txt 87"
    "./result_8chains/node43_3_2.txt 87"
    "./result_8chains/node43_4_0.txt 86"
    "./result_8chains/node43_4_2.txt 86"
    "./result_8chains/node43_5_0.txt 85"
    "./result_8chains/node43_5_2.txt 85"
    "./result_8chains/node43_6_0.txt 84"
    "./result_8chains/node43_6_2.txt 84"
    "./result_8chains/node43_7_0.txt 83"
    "./result_8chains/node43_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
