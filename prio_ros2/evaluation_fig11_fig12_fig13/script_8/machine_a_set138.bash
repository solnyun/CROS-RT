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
ros2 run evaluation_3_randomdag uunifast_node -n node138_0_2 -p 110 -st topic138_0_1 -pt None -u 0.03135429444239535 > ./result_8chains/node138_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_1_2 -p 113 -st topic138_1_1 -pt None -u 0.014867168904942607 > ./result_8chains/node138_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_2_2 -p 427 -st topic138_2_1 -pt None -u 0.03487534266123776 > ./result_8chains/node138_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_3_2 -p 533 -st topic138_3_1 -pt None -u 0.025634370953926178 > ./result_8chains/node138_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_4_2 -p 581 -st topic138_4_1 -pt None -u 0.027457517184130226 > ./result_8chains/node138_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_5_2 -p 596 -st topic138_5_1 -pt None -u 0.0008835232216455324 > ./result_8chains/node138_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_6_2 -p 606 -st topic138_6_1 -pt None -u 0.09380936205591739 > ./result_8chains/node138_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_7_2 -p 907 -st topic138_7_1 -pt None -u 0.03317519319904066 > ./result_8chains/node138_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_0_0 -p 110 -st none -pt topic138_0_0 -u 0.009595733994106292 > ./result_8chains/node138_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_1_0 -p 113 -st none -pt topic138_1_0 -u 0.008543252664300727 > ./result_8chains/node138_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_2_0 -p 427 -st none -pt topic138_2_0 -u 0.02021742618652589 > ./result_8chains/node138_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_3_0 -p 533 -st none -pt topic138_3_0 -u 0.023465864140870984 > ./result_8chains/node138_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_4_0 -p 581 -st none -pt topic138_4_0 -u 0.00045894855188130523 > ./result_8chains/node138_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_5_0 -p 596 -st none -pt topic138_5_0 -u 0.03676074849690639 > ./result_8chains/node138_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_6_0 -p 606 -st none -pt topic138_6_0 -u 0.0047128648791346095 > ./result_8chains/node138_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_7_0 -p 907 -st none -pt topic138_7_0 -u 0.017468506646120298 > ./result_8chains/node138_7_0.txt &
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
    "./result_8chains/node138_0_0.txt 90"
    "./result_8chains/node138_0_2.txt 90"
    "./result_8chains/node138_1_0.txt 89"
    "./result_8chains/node138_1_2.txt 89"
    "./result_8chains/node138_2_0.txt 88"
    "./result_8chains/node138_2_2.txt 88"
    "./result_8chains/node138_3_0.txt 87"
    "./result_8chains/node138_3_2.txt 87"
    "./result_8chains/node138_4_0.txt 86"
    "./result_8chains/node138_4_2.txt 86"
    "./result_8chains/node138_5_0.txt 85"
    "./result_8chains/node138_5_2.txt 85"
    "./result_8chains/node138_6_0.txt 84"
    "./result_8chains/node138_6_2.txt 84"
    "./result_8chains/node138_7_0.txt 83"
    "./result_8chains/node138_7_2.txt 83"
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
