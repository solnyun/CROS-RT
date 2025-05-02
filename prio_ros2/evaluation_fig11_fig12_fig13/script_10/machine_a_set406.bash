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
ros2 run evaluation_3_randomdag uunifast_node -n node406_0_2 -p 49 -st topic406_0_1 -pt None -u 0.004192128804347717 > ./result_10chains/node406_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_1_2 -p 51 -st topic406_1_1 -pt None -u 0.007733773146042344 > ./result_10chains/node406_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_2_2 -p 74 -st topic406_2_1 -pt None -u 0.004988088775069677 > ./result_10chains/node406_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_3_2 -p 96 -st topic406_3_1 -pt None -u 0.006425685492962907 > ./result_10chains/node406_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_4_2 -p 299 -st topic406_4_1 -pt None -u 0.02640519718438389 > ./result_10chains/node406_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_5_2 -p 513 -st topic406_5_1 -pt None -u 0.011189605705587857 > ./result_10chains/node406_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_6_2 -p 514 -st topic406_6_1 -pt None -u 0.017173723346419506 > ./result_10chains/node406_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_7_2 -p 614 -st topic406_7_1 -pt None -u 0.0015749636560671298 > ./result_10chains/node406_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_8_2 -p 657 -st topic406_8_1 -pt None -u 0.013746157613199361 > ./result_10chains/node406_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_9_2 -p 703 -st topic406_9_1 -pt None -u 0.007145278042178356 > ./result_10chains/node406_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_0_0 -p 49 -st none -pt topic406_0_0 -u 0.04795488605977388 > ./result_10chains/node406_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_1_0 -p 51 -st none -pt topic406_1_0 -u 0.002946867226132577 > ./result_10chains/node406_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_2_0 -p 74 -st none -pt topic406_2_0 -u 0.02050911875629824 > ./result_10chains/node406_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_3_0 -p 96 -st none -pt topic406_3_0 -u 0.015855701437504255 > ./result_10chains/node406_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_4_0 -p 299 -st none -pt topic406_4_0 -u 0.0015203184295219385 > ./result_10chains/node406_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_5_0 -p 513 -st none -pt topic406_5_0 -u 0.0073033634942003545 > ./result_10chains/node406_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_6_0 -p 514 -st none -pt topic406_6_0 -u 0.07082448511669118 > ./result_10chains/node406_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_7_0 -p 614 -st none -pt topic406_7_0 -u 0.0036305477694762722 > ./result_10chains/node406_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_8_0 -p 657 -st none -pt topic406_8_0 -u 0.007626781250568496 > ./result_10chains/node406_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_9_0 -p 703 -st none -pt topic406_9_0 -u 0.04306634665294385 > ./result_10chains/node406_9_0.txt &
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
    "./result_10chains/node406_0_0.txt 90"
    "./result_10chains/node406_0_2.txt 90"
    "./result_10chains/node406_1_0.txt 89"
    "./result_10chains/node406_1_2.txt 89"
    "./result_10chains/node406_2_0.txt 88"
    "./result_10chains/node406_2_2.txt 88"
    "./result_10chains/node406_3_0.txt 87"
    "./result_10chains/node406_3_2.txt 87"
    "./result_10chains/node406_4_0.txt 86"
    "./result_10chains/node406_4_2.txt 86"
    "./result_10chains/node406_5_0.txt 85"
    "./result_10chains/node406_5_2.txt 85"
    "./result_10chains/node406_6_0.txt 84"
    "./result_10chains/node406_6_2.txt 84"
    "./result_10chains/node406_7_0.txt 83"
    "./result_10chains/node406_7_2.txt 83"
    "./result_10chains/node406_8_0.txt 82"
    "./result_10chains/node406_8_2.txt 82"
    "./result_10chains/node406_9_0.txt 81"
    "./result_10chains/node406_9_2.txt 81"
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
