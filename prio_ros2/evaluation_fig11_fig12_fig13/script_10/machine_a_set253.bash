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
ros2 run evaluation_3_randomdag uunifast_node -n node253_0_2 -p 204 -st topic253_0_1 -pt None -u 0.017862256638514817 > ./result_10chains/node253_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_1_2 -p 293 -st topic253_1_1 -pt None -u 0.004039421021554357 > ./result_10chains/node253_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_2_2 -p 451 -st topic253_2_1 -pt None -u 0.03647794973016871 > ./result_10chains/node253_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_3_2 -p 498 -st topic253_3_1 -pt None -u 0.0014743306310626147 > ./result_10chains/node253_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_4_2 -p 517 -st topic253_4_1 -pt None -u 0.01170520061440078 > ./result_10chains/node253_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_5_2 -p 579 -st topic253_5_1 -pt None -u 0.021245848422922015 > ./result_10chains/node253_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_6_2 -p 692 -st topic253_6_1 -pt None -u 0.00024360507253617936 > ./result_10chains/node253_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_7_2 -p 703 -st topic253_7_1 -pt None -u 0.01797406242216787 > ./result_10chains/node253_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_8_2 -p 748 -st topic253_8_1 -pt None -u 0.004037649523152803 > ./result_10chains/node253_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_9_2 -p 962 -st topic253_9_1 -pt None -u 0.022010655718619487 > ./result_10chains/node253_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_0_0 -p 204 -st none -pt topic253_0_0 -u 0.021253210583312643 > ./result_10chains/node253_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_1_0 -p 293 -st none -pt topic253_1_0 -u 0.0006578729897075419 > ./result_10chains/node253_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_2_0 -p 451 -st none -pt topic253_2_0 -u 0.029112718909713398 > ./result_10chains/node253_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_3_0 -p 498 -st none -pt topic253_3_0 -u 0.011356633705041363 > ./result_10chains/node253_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_4_0 -p 517 -st none -pt topic253_4_0 -u 0.0032360776000283087 > ./result_10chains/node253_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_5_0 -p 579 -st none -pt topic253_5_0 -u 0.009844894057928655 > ./result_10chains/node253_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_6_0 -p 692 -st none -pt topic253_6_0 -u 0.00021279008444499703 > ./result_10chains/node253_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_7_0 -p 703 -st none -pt topic253_7_0 -u 0.01507786027691188 > ./result_10chains/node253_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_8_0 -p 748 -st none -pt topic253_8_0 -u 0.012647225976747542 > ./result_10chains/node253_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_9_0 -p 962 -st none -pt topic253_9_0 -u 0.026885065447618303 > ./result_10chains/node253_9_0.txt &
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
    "./result_10chains/node253_0_0.txt 90"
    "./result_10chains/node253_0_2.txt 90"
    "./result_10chains/node253_1_0.txt 89"
    "./result_10chains/node253_1_2.txt 89"
    "./result_10chains/node253_2_0.txt 88"
    "./result_10chains/node253_2_2.txt 88"
    "./result_10chains/node253_3_0.txt 87"
    "./result_10chains/node253_3_2.txt 87"
    "./result_10chains/node253_4_0.txt 86"
    "./result_10chains/node253_4_2.txt 86"
    "./result_10chains/node253_5_0.txt 85"
    "./result_10chains/node253_5_2.txt 85"
    "./result_10chains/node253_6_0.txt 84"
    "./result_10chains/node253_6_2.txt 84"
    "./result_10chains/node253_7_0.txt 83"
    "./result_10chains/node253_7_2.txt 83"
    "./result_10chains/node253_8_0.txt 82"
    "./result_10chains/node253_8_2.txt 82"
    "./result_10chains/node253_9_0.txt 81"
    "./result_10chains/node253_9_2.txt 81"
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
