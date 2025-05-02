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
ros2 run evaluation_3_randomdag uunifast_node -n node107_0_1 -p 39 -st topic107_0_0 -pt topic107_0_1 -u 0.002891876359058243 > ./result_10chains/node107_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_1_1 -p 215 -st topic107_1_0 -pt topic107_1_1 -u 0.015063444818996186 > ./result_10chains/node107_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_2_1 -p 270 -st topic107_2_0 -pt topic107_2_1 -u 0.05664087922830968 > ./result_10chains/node107_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_3_1 -p 330 -st topic107_3_0 -pt topic107_3_1 -u 0.011007084458392657 > ./result_10chains/node107_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_4_1 -p 369 -st topic107_4_0 -pt topic107_4_1 -u 0.006773643780981442 > ./result_10chains/node107_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_5_1 -p 391 -st topic107_5_0 -pt topic107_5_1 -u 0.030675123166780505 > ./result_10chains/node107_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_6_1 -p 527 -st topic107_6_0 -pt topic107_6_1 -u 0.022494233876716507 > ./result_10chains/node107_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_7_1 -p 720 -st topic107_7_0 -pt topic107_7_1 -u 0.01147516013036784 > ./result_10chains/node107_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_8_1 -p 834 -st topic107_8_0 -pt topic107_8_1 -u 0.0068050736798893965 > ./result_10chains/node107_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_9_1 -p 880 -st topic107_9_0 -pt topic107_9_1 -u 0.0027845669755584626 > ./result_10chains/node107_9_1.txt &
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
    "./result_10chains/node107_0_1.txt 90"
    "./result_10chains/node107_1_1.txt 89"
    "./result_10chains/node107_2_1.txt 88"
    "./result_10chains/node107_3_1.txt 87"
    "./result_10chains/node107_4_1.txt 86"
    "./result_10chains/node107_5_1.txt 85"
    "./result_10chains/node107_6_1.txt 84"
    "./result_10chains/node107_7_1.txt 83"
    "./result_10chains/node107_8_1.txt 82"
    "./result_10chains/node107_9_1.txt 81"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
