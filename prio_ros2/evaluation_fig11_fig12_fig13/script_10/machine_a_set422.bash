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
ros2 run evaluation_3_randomdag uunifast_node -n node422_0_2 -p 121 -st topic422_0_1 -pt None -u 0.016842438053370656 > ./result_10chains/node422_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_1_2 -p 128 -st topic422_1_1 -pt None -u 0.027975409512200067 > ./result_10chains/node422_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_2_2 -p 208 -st topic422_2_1 -pt None -u 0.0014365631421660585 > ./result_10chains/node422_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_3_2 -p 287 -st topic422_3_1 -pt None -u 0.0029419528595849287 > ./result_10chains/node422_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_4_2 -p 351 -st topic422_4_1 -pt None -u 0.0005412939844038345 > ./result_10chains/node422_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_5_2 -p 481 -st topic422_5_1 -pt None -u 0.10731511017203235 > ./result_10chains/node422_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_6_2 -p 571 -st topic422_6_1 -pt None -u 0.017974020082188888 > ./result_10chains/node422_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_7_2 -p 574 -st topic422_7_1 -pt None -u 0.0002065980897988512 > ./result_10chains/node422_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_8_2 -p 580 -st topic422_8_1 -pt None -u 0.001762964118110201 > ./result_10chains/node422_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_9_2 -p 998 -st topic422_9_1 -pt None -u 0.03546660933732479 > ./result_10chains/node422_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_0_0 -p 121 -st none -pt topic422_0_0 -u 0.015073844465162356 > ./result_10chains/node422_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_1_0 -p 128 -st none -pt topic422_1_0 -u 0.008791364209386532 > ./result_10chains/node422_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_2_0 -p 208 -st none -pt topic422_2_0 -u 0.0018041826794940596 > ./result_10chains/node422_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_3_0 -p 287 -st none -pt topic422_3_0 -u 0.03206494436203716 > ./result_10chains/node422_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_4_0 -p 351 -st none -pt topic422_4_0 -u 0.04792192888411534 > ./result_10chains/node422_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_5_0 -p 481 -st none -pt topic422_5_0 -u 0.0028175113314642952 > ./result_10chains/node422_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_6_0 -p 571 -st none -pt topic422_6_0 -u 0.0027526291003336645 > ./result_10chains/node422_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_7_0 -p 574 -st none -pt topic422_7_0 -u 0.016298207669517326 > ./result_10chains/node422_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_8_0 -p 580 -st none -pt topic422_8_0 -u 0.0015727946600349804 > ./result_10chains/node422_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_9_0 -p 998 -st none -pt topic422_9_0 -u 0.003197579703190609 > ./result_10chains/node422_9_0.txt &
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
    "./result_10chains/node422_0_0.txt 90"
    "./result_10chains/node422_0_2.txt 90"
    "./result_10chains/node422_1_0.txt 89"
    "./result_10chains/node422_1_2.txt 89"
    "./result_10chains/node422_2_0.txt 88"
    "./result_10chains/node422_2_2.txt 88"
    "./result_10chains/node422_3_0.txt 87"
    "./result_10chains/node422_3_2.txt 87"
    "./result_10chains/node422_4_0.txt 86"
    "./result_10chains/node422_4_2.txt 86"
    "./result_10chains/node422_5_0.txt 85"
    "./result_10chains/node422_5_2.txt 85"
    "./result_10chains/node422_6_0.txt 84"
    "./result_10chains/node422_6_2.txt 84"
    "./result_10chains/node422_7_0.txt 83"
    "./result_10chains/node422_7_2.txt 83"
    "./result_10chains/node422_8_0.txt 82"
    "./result_10chains/node422_8_2.txt 82"
    "./result_10chains/node422_9_0.txt 81"
    "./result_10chains/node422_9_2.txt 81"
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
