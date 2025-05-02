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
ros2 run evaluation_3_randomdag uunifast_node -n node291_0_2 -p 80 -st topic291_0_1 -pt None -u 0.03293649983373759 > ./result_10chains/node291_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_1_2 -p 314 -st topic291_1_1 -pt None -u 0.0019896632886056698 > ./result_10chains/node291_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_2_2 -p 377 -st topic291_2_1 -pt None -u 0.01202538781975443 > ./result_10chains/node291_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_3_2 -p 511 -st topic291_3_1 -pt None -u 0.005238248396070899 > ./result_10chains/node291_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_4_2 -p 520 -st topic291_4_1 -pt None -u 0.016015970500865506 > ./result_10chains/node291_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_5_2 -p 616 -st topic291_5_1 -pt None -u 0.037294434058969816 > ./result_10chains/node291_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_6_2 -p 726 -st topic291_6_1 -pt None -u 0.030931308474219238 > ./result_10chains/node291_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_7_2 -p 810 -st topic291_7_1 -pt None -u 0.0015563898526913533 > ./result_10chains/node291_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_8_2 -p 816 -st topic291_8_1 -pt None -u 0.033687285457560515 > ./result_10chains/node291_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_9_2 -p 982 -st topic291_9_1 -pt None -u 0.06457063180383608 > ./result_10chains/node291_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_0_0 -p 80 -st none -pt topic291_0_0 -u 0.0004575657280270762 > ./result_10chains/node291_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_1_0 -p 314 -st none -pt topic291_1_0 -u 0.007842291041424476 > ./result_10chains/node291_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_2_0 -p 377 -st none -pt topic291_2_0 -u 0.02663087441423978 > ./result_10chains/node291_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_3_0 -p 511 -st none -pt topic291_3_0 -u 0.010111442909152724 > ./result_10chains/node291_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_4_0 -p 520 -st none -pt topic291_4_0 -u 0.009214225297532297 > ./result_10chains/node291_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_5_0 -p 616 -st none -pt topic291_5_0 -u 0.012501563437917446 > ./result_10chains/node291_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_6_0 -p 726 -st none -pt topic291_6_0 -u 0.020302602118980523 > ./result_10chains/node291_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_7_0 -p 810 -st none -pt topic291_7_0 -u 0.010154024888593988 > ./result_10chains/node291_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_8_0 -p 816 -st none -pt topic291_8_0 -u 0.011696252791900133 > ./result_10chains/node291_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_9_0 -p 982 -st none -pt topic291_9_0 -u 0.006382157099937516 > ./result_10chains/node291_9_0.txt &
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
    "./result_10chains/node291_0_0.txt 90"
    "./result_10chains/node291_0_2.txt 90"
    "./result_10chains/node291_1_0.txt 89"
    "./result_10chains/node291_1_2.txt 89"
    "./result_10chains/node291_2_0.txt 88"
    "./result_10chains/node291_2_2.txt 88"
    "./result_10chains/node291_3_0.txt 87"
    "./result_10chains/node291_3_2.txt 87"
    "./result_10chains/node291_4_0.txt 86"
    "./result_10chains/node291_4_2.txt 86"
    "./result_10chains/node291_5_0.txt 85"
    "./result_10chains/node291_5_2.txt 85"
    "./result_10chains/node291_6_0.txt 84"
    "./result_10chains/node291_6_2.txt 84"
    "./result_10chains/node291_7_0.txt 83"
    "./result_10chains/node291_7_2.txt 83"
    "./result_10chains/node291_8_0.txt 82"
    "./result_10chains/node291_8_2.txt 82"
    "./result_10chains/node291_9_0.txt 81"
    "./result_10chains/node291_9_2.txt 81"
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
