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
ros2 run evaluation_3_randomdag uunifast_node -n node351_0_2 -p 87 -st topic351_0_1 -pt None -u 0.0348152083085424 > ./result_10chains/node351_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_1_2 -p 117 -st topic351_1_1 -pt None -u 0.0002169189207398281 > ./result_10chains/node351_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_2_2 -p 166 -st topic351_2_1 -pt None -u 0.0011445188259202044 > ./result_10chains/node351_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_3_2 -p 212 -st topic351_3_1 -pt None -u 0.017681286388632755 > ./result_10chains/node351_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_4_2 -p 271 -st topic351_4_1 -pt None -u 0.015849236914052822 > ./result_10chains/node351_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_5_2 -p 405 -st topic351_5_1 -pt None -u 0.005951439583756574 > ./result_10chains/node351_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_6_2 -p 431 -st topic351_6_1 -pt None -u 0.03676409518081576 > ./result_10chains/node351_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_7_2 -p 826 -st topic351_7_1 -pt None -u 0.004671713168367399 > ./result_10chains/node351_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_8_2 -p 911 -st topic351_8_1 -pt None -u 0.00044103723346745026 > ./result_10chains/node351_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_9_2 -p 975 -st topic351_9_1 -pt None -u 0.000602092046276705 > ./result_10chains/node351_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_0_0 -p 87 -st none -pt topic351_0_0 -u 0.030350258662357132 > ./result_10chains/node351_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_1_0 -p 117 -st none -pt topic351_1_0 -u 0.014414400360696356 > ./result_10chains/node351_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_2_0 -p 166 -st none -pt topic351_2_0 -u 0.012272746871443918 > ./result_10chains/node351_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_3_0 -p 212 -st none -pt topic351_3_0 -u 0.04543086968376964 > ./result_10chains/node351_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_4_0 -p 271 -st none -pt topic351_4_0 -u 0.009364090817643778 > ./result_10chains/node351_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_5_0 -p 405 -st none -pt topic351_5_0 -u 0.05632016892754202 > ./result_10chains/node351_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_6_0 -p 431 -st none -pt topic351_6_0 -u 0.011847908671672597 > ./result_10chains/node351_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_7_0 -p 826 -st none -pt topic351_7_0 -u 0.048688163572902746 > ./result_10chains/node351_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_8_0 -p 911 -st none -pt topic351_8_0 -u 0.001114571535966391 > ./result_10chains/node351_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_9_0 -p 975 -st none -pt topic351_9_0 -u 0.0030253448027821586 > ./result_10chains/node351_9_0.txt &
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
    "./result_10chains/node351_0_0.txt 90"
    "./result_10chains/node351_0_2.txt 90"
    "./result_10chains/node351_1_0.txt 89"
    "./result_10chains/node351_1_2.txt 89"
    "./result_10chains/node351_2_0.txt 88"
    "./result_10chains/node351_2_2.txt 88"
    "./result_10chains/node351_3_0.txt 87"
    "./result_10chains/node351_3_2.txt 87"
    "./result_10chains/node351_4_0.txt 86"
    "./result_10chains/node351_4_2.txt 86"
    "./result_10chains/node351_5_0.txt 85"
    "./result_10chains/node351_5_2.txt 85"
    "./result_10chains/node351_6_0.txt 84"
    "./result_10chains/node351_6_2.txt 84"
    "./result_10chains/node351_7_0.txt 83"
    "./result_10chains/node351_7_2.txt 83"
    "./result_10chains/node351_8_0.txt 82"
    "./result_10chains/node351_8_2.txt 82"
    "./result_10chains/node351_9_0.txt 81"
    "./result_10chains/node351_9_2.txt 81"
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
