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
ros2 run evaluation_3_randomdag uunifast_node -n node237_0_2 -p 142 -st topic237_0_1 -pt None -u 0.009053113002090385 > ./result_8chains/node237_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_1_2 -p 280 -st topic237_1_1 -pt None -u 0.05047750414688662 > ./result_8chains/node237_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_2_2 -p 477 -st topic237_2_1 -pt None -u 5.607857476730427e-05 > ./result_8chains/node237_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_3_2 -p 642 -st topic237_3_1 -pt None -u 0.010234748971156726 > ./result_8chains/node237_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_4_2 -p 678 -st topic237_4_1 -pt None -u 0.0011520377256285796 > ./result_8chains/node237_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_5_2 -p 707 -st topic237_5_1 -pt None -u 0.0022136750928687388 > ./result_8chains/node237_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_6_2 -p 869 -st topic237_6_1 -pt None -u 0.004169201123485233 > ./result_8chains/node237_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_7_2 -p 910 -st topic237_7_1 -pt None -u 0.0033830652717031337 > ./result_8chains/node237_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_0_0 -p 142 -st none -pt topic237_0_0 -u 0.00810607685064052 > ./result_8chains/node237_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_1_0 -p 280 -st none -pt topic237_1_0 -u 0.01152171591678497 > ./result_8chains/node237_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_2_0 -p 477 -st none -pt topic237_2_0 -u 0.03529548200067795 > ./result_8chains/node237_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_3_0 -p 642 -st none -pt topic237_3_0 -u 0.033659894754826836 > ./result_8chains/node237_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_4_0 -p 678 -st none -pt topic237_4_0 -u 0.05506532912456308 > ./result_8chains/node237_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_5_0 -p 707 -st none -pt topic237_5_0 -u 0.07349027986196628 > ./result_8chains/node237_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_6_0 -p 869 -st none -pt topic237_6_0 -u 0.00893710820091742 > ./result_8chains/node237_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_7_0 -p 910 -st none -pt topic237_7_0 -u 0.030643756174165926 > ./result_8chains/node237_7_0.txt &
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
    "./result_8chains/node237_0_0.txt 90"
    "./result_8chains/node237_0_2.txt 90"
    "./result_8chains/node237_1_0.txt 89"
    "./result_8chains/node237_1_2.txt 89"
    "./result_8chains/node237_2_0.txt 88"
    "./result_8chains/node237_2_2.txt 88"
    "./result_8chains/node237_3_0.txt 87"
    "./result_8chains/node237_3_2.txt 87"
    "./result_8chains/node237_4_0.txt 86"
    "./result_8chains/node237_4_2.txt 86"
    "./result_8chains/node237_5_0.txt 85"
    "./result_8chains/node237_5_2.txt 85"
    "./result_8chains/node237_6_0.txt 84"
    "./result_8chains/node237_6_2.txt 84"
    "./result_8chains/node237_7_0.txt 83"
    "./result_8chains/node237_7_2.txt 83"
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
