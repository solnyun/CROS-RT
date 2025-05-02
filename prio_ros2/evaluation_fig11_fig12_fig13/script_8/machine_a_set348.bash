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
ros2 run evaluation_3_randomdag uunifast_node -n node348_0_2 -p 48 -st topic348_0_1 -pt None -u 0.005874666007743001 > ./result_8chains/node348_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_1_2 -p 172 -st topic348_1_1 -pt None -u 0.014752472832928354 > ./result_8chains/node348_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_2_2 -p 201 -st topic348_2_1 -pt None -u 0.004575316597019818 > ./result_8chains/node348_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_3_2 -p 302 -st topic348_3_1 -pt None -u 0.005649327717659192 > ./result_8chains/node348_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_4_2 -p 318 -st topic348_4_1 -pt None -u 0.027606719622985276 > ./result_8chains/node348_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_5_2 -p 330 -st topic348_5_1 -pt None -u 0.0044870004621978266 > ./result_8chains/node348_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_6_2 -p 593 -st topic348_6_1 -pt None -u 0.09844293360573518 > ./result_8chains/node348_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_7_2 -p 813 -st topic348_7_1 -pt None -u 0.005794666320770357 > ./result_8chains/node348_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_0_0 -p 48 -st none -pt topic348_0_0 -u 0.0034980048613591497 > ./result_8chains/node348_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_1_0 -p 172 -st none -pt topic348_1_0 -u 0.029889021998048715 > ./result_8chains/node348_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_2_0 -p 201 -st none -pt topic348_2_0 -u 0.005120704173670998 > ./result_8chains/node348_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_3_0 -p 302 -st none -pt topic348_3_0 -u 0.014375184632940186 > ./result_8chains/node348_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_4_0 -p 318 -st none -pt topic348_4_0 -u 0.008795187950493777 > ./result_8chains/node348_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_5_0 -p 330 -st none -pt topic348_5_0 -u 0.017492496675315772 > ./result_8chains/node348_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_6_0 -p 593 -st none -pt topic348_6_0 -u 0.01771569037659207 > ./result_8chains/node348_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_7_0 -p 813 -st none -pt topic348_7_0 -u 0.00010442044424045435 > ./result_8chains/node348_7_0.txt &
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
    "./result_8chains/node348_0_0.txt 90"
    "./result_8chains/node348_0_2.txt 90"
    "./result_8chains/node348_1_0.txt 89"
    "./result_8chains/node348_1_2.txt 89"
    "./result_8chains/node348_2_0.txt 88"
    "./result_8chains/node348_2_2.txt 88"
    "./result_8chains/node348_3_0.txt 87"
    "./result_8chains/node348_3_2.txt 87"
    "./result_8chains/node348_4_0.txt 86"
    "./result_8chains/node348_4_2.txt 86"
    "./result_8chains/node348_5_0.txt 85"
    "./result_8chains/node348_5_2.txt 85"
    "./result_8chains/node348_6_0.txt 84"
    "./result_8chains/node348_6_2.txt 84"
    "./result_8chains/node348_7_0.txt 83"
    "./result_8chains/node348_7_2.txt 83"
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
