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
ros2 run evaluation_3_randomdag uunifast_node -n node107_0_2 -p 39 -st topic107_0_1 -pt None -u 0.03821635584808153 > ./result_10chains/node107_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_1_2 -p 215 -st topic107_1_1 -pt None -u 0.0062982914351570884 > ./result_10chains/node107_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_2_2 -p 270 -st topic107_2_1 -pt None -u 0.0050793698145110144 > ./result_10chains/node107_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_3_2 -p 330 -st topic107_3_1 -pt None -u 0.001414233670418319 > ./result_10chains/node107_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_4_2 -p 369 -st topic107_4_1 -pt None -u 0.026782957306370314 > ./result_10chains/node107_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_5_2 -p 391 -st topic107_5_1 -pt None -u 0.03420305022412595 > ./result_10chains/node107_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_6_2 -p 527 -st topic107_6_1 -pt None -u 0.017111598515645948 > ./result_10chains/node107_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_7_2 -p 720 -st topic107_7_1 -pt None -u 0.04297037916603989 > ./result_10chains/node107_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_8_2 -p 834 -st topic107_8_1 -pt None -u 0.022063826984466732 > ./result_10chains/node107_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_9_2 -p 880 -st topic107_9_1 -pt None -u 0.019091685426627494 > ./result_10chains/node107_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_0_0 -p 39 -st none -pt topic107_0_0 -u 0.0028386379859385857 > ./result_10chains/node107_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_1_0 -p 215 -st none -pt topic107_1_0 -u 0.00012164095865635494 > ./result_10chains/node107_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_2_0 -p 270 -st none -pt topic107_2_0 -u 0.012198462051016101 > ./result_10chains/node107_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_3_0 -p 330 -st none -pt topic107_3_0 -u 0.05130213436909675 > ./result_10chains/node107_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_4_0 -p 369 -st none -pt topic107_4_0 -u 0.003387565528036207 > ./result_10chains/node107_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_5_0 -p 391 -st none -pt topic107_5_0 -u 0.026995836665206135 > ./result_10chains/node107_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_6_0 -p 527 -st none -pt topic107_6_0 -u 0.0016154163162052926 > ./result_10chains/node107_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_7_0 -p 720 -st none -pt topic107_7_0 -u 0.007849130522706305 > ./result_10chains/node107_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_8_0 -p 834 -st none -pt topic107_8_0 -u 0.013183475507418142 > ./result_10chains/node107_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_9_0 -p 880 -st none -pt topic107_9_0 -u 0.0006648652292249174 > ./result_10chains/node107_9_0.txt &
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
    "./result_10chains/node107_0_0.txt 90"
    "./result_10chains/node107_0_2.txt 90"
    "./result_10chains/node107_1_0.txt 89"
    "./result_10chains/node107_1_2.txt 89"
    "./result_10chains/node107_2_0.txt 88"
    "./result_10chains/node107_2_2.txt 88"
    "./result_10chains/node107_3_0.txt 87"
    "./result_10chains/node107_3_2.txt 87"
    "./result_10chains/node107_4_0.txt 86"
    "./result_10chains/node107_4_2.txt 86"
    "./result_10chains/node107_5_0.txt 85"
    "./result_10chains/node107_5_2.txt 85"
    "./result_10chains/node107_6_0.txt 84"
    "./result_10chains/node107_6_2.txt 84"
    "./result_10chains/node107_7_0.txt 83"
    "./result_10chains/node107_7_2.txt 83"
    "./result_10chains/node107_8_0.txt 82"
    "./result_10chains/node107_8_2.txt 82"
    "./result_10chains/node107_9_0.txt 81"
    "./result_10chains/node107_9_2.txt 81"
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
