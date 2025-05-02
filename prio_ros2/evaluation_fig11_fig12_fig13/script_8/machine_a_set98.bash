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
ros2 run evaluation_3_randomdag uunifast_node -n node98_0_2 -p 28 -st topic98_0_1 -pt None -u 0.03367628165205466 > ./result_8chains/node98_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_1_2 -p 61 -st topic98_1_1 -pt None -u 0.021411424840303173 > ./result_8chains/node98_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_2_2 -p 137 -st topic98_2_1 -pt None -u 0.004477496652948332 > ./result_8chains/node98_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_3_2 -p 189 -st topic98_3_1 -pt None -u 0.005256509021188627 > ./result_8chains/node98_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_4_2 -p 231 -st topic98_4_1 -pt None -u 0.06508352534052891 > ./result_8chains/node98_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_5_2 -p 462 -st topic98_5_1 -pt None -u 0.03497951761704146 > ./result_8chains/node98_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_6_2 -p 668 -st topic98_6_1 -pt None -u 0.03027048945330134 > ./result_8chains/node98_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_7_2 -p 674 -st topic98_7_1 -pt None -u 0.043008398687536364 > ./result_8chains/node98_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_0_0 -p 28 -st none -pt topic98_0_0 -u 0.03430241393093075 > ./result_8chains/node98_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_1_0 -p 61 -st none -pt topic98_1_0 -u 0.003069749018189072 > ./result_8chains/node98_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_2_0 -p 137 -st none -pt topic98_2_0 -u 0.008452272901121216 > ./result_8chains/node98_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_3_0 -p 189 -st none -pt topic98_3_0 -u 0.007472569363429604 > ./result_8chains/node98_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_4_0 -p 231 -st none -pt topic98_4_0 -u 0.0099111783230455 > ./result_8chains/node98_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_5_0 -p 462 -st none -pt topic98_5_0 -u 0.011774196916156221 > ./result_8chains/node98_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_6_0 -p 668 -st none -pt topic98_6_0 -u 0.010995534741851387 > ./result_8chains/node98_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_7_0 -p 674 -st none -pt topic98_7_0 -u 0.001137686429871547 > ./result_8chains/node98_7_0.txt &
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
    "./result_8chains/node98_0_0.txt 90"
    "./result_8chains/node98_0_2.txt 90"
    "./result_8chains/node98_1_0.txt 89"
    "./result_8chains/node98_1_2.txt 89"
    "./result_8chains/node98_2_0.txt 88"
    "./result_8chains/node98_2_2.txt 88"
    "./result_8chains/node98_3_0.txt 87"
    "./result_8chains/node98_3_2.txt 87"
    "./result_8chains/node98_4_0.txt 86"
    "./result_8chains/node98_4_2.txt 86"
    "./result_8chains/node98_5_0.txt 85"
    "./result_8chains/node98_5_2.txt 85"
    "./result_8chains/node98_6_0.txt 84"
    "./result_8chains/node98_6_2.txt 84"
    "./result_8chains/node98_7_0.txt 83"
    "./result_8chains/node98_7_2.txt 83"
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
