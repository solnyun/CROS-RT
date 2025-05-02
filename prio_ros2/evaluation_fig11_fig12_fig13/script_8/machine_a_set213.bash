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
ros2 run evaluation_3_randomdag uunifast_node -n node213_0_2 -p 49 -st topic213_0_1 -pt None -u 0.061317451313438354 > ./result_8chains/node213_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_1_2 -p 311 -st topic213_1_1 -pt None -u 0.039744653205883496 > ./result_8chains/node213_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_2_2 -p 426 -st topic213_2_1 -pt None -u 0.006910563972959055 > ./result_8chains/node213_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_3_2 -p 508 -st topic213_3_1 -pt None -u 0.0035660251297565115 > ./result_8chains/node213_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_4_2 -p 570 -st topic213_4_1 -pt None -u 0.00976228368034368 > ./result_8chains/node213_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_5_2 -p 740 -st topic213_5_1 -pt None -u 0.0058196125530403375 > ./result_8chains/node213_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_6_2 -p 755 -st topic213_6_1 -pt None -u 0.007157017107259973 > ./result_8chains/node213_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_7_2 -p 844 -st topic213_7_1 -pt None -u 0.006348401191287051 > ./result_8chains/node213_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_0_0 -p 49 -st none -pt topic213_0_0 -u 0.0005700895290179919 > ./result_8chains/node213_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_1_0 -p 311 -st none -pt topic213_1_0 -u 0.11121232659485086 > ./result_8chains/node213_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_2_0 -p 426 -st none -pt topic213_2_0 -u 0.011546512062573344 > ./result_8chains/node213_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_3_0 -p 508 -st none -pt topic213_3_0 -u 0.003806778392408755 > ./result_8chains/node213_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_4_0 -p 570 -st none -pt topic213_4_0 -u 0.039509005387099894 > ./result_8chains/node213_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_5_0 -p 740 -st none -pt topic213_5_0 -u 0.0354147929087814 > ./result_8chains/node213_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_6_0 -p 755 -st none -pt topic213_6_0 -u 0.028848104250103965 > ./result_8chains/node213_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_7_0 -p 844 -st none -pt topic213_7_0 -u 0.004005351260105823 > ./result_8chains/node213_7_0.txt &
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
    "./result_8chains/node213_0_0.txt 90"
    "./result_8chains/node213_0_2.txt 90"
    "./result_8chains/node213_1_0.txt 89"
    "./result_8chains/node213_1_2.txt 89"
    "./result_8chains/node213_2_0.txt 88"
    "./result_8chains/node213_2_2.txt 88"
    "./result_8chains/node213_3_0.txt 87"
    "./result_8chains/node213_3_2.txt 87"
    "./result_8chains/node213_4_0.txt 86"
    "./result_8chains/node213_4_2.txt 86"
    "./result_8chains/node213_5_0.txt 85"
    "./result_8chains/node213_5_2.txt 85"
    "./result_8chains/node213_6_0.txt 84"
    "./result_8chains/node213_6_2.txt 84"
    "./result_8chains/node213_7_0.txt 83"
    "./result_8chains/node213_7_2.txt 83"
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
