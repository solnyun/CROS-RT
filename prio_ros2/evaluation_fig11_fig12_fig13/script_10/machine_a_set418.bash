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
ros2 run evaluation_3_randomdag uunifast_node -n node418_0_2 -p 53 -st topic418_0_1 -pt None -u 0.014820082927478606 > ./result_10chains/node418_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_1_2 -p 126 -st topic418_1_1 -pt None -u 0.03284626709887184 > ./result_10chains/node418_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_2_2 -p 151 -st topic418_2_1 -pt None -u 0.0034792068789217256 > ./result_10chains/node418_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_3_2 -p 217 -st topic418_3_1 -pt None -u 0.0032755655494005054 > ./result_10chains/node418_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_4_2 -p 419 -st topic418_4_1 -pt None -u 0.08003484499947819 > ./result_10chains/node418_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_5_2 -p 444 -st topic418_5_1 -pt None -u 0.01242722934948079 > ./result_10chains/node418_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_6_2 -p 579 -st topic418_6_1 -pt None -u 0.06668833551017689 > ./result_10chains/node418_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_7_2 -p 588 -st topic418_7_1 -pt None -u 0.03060766201118527 > ./result_10chains/node418_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_8_2 -p 794 -st topic418_8_1 -pt None -u 0.003870958559742224 > ./result_10chains/node418_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_9_2 -p 986 -st topic418_9_1 -pt None -u 0.0030537284953861986 > ./result_10chains/node418_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_0_0 -p 53 -st none -pt topic418_0_0 -u 0.015202495514125614 > ./result_10chains/node418_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_1_0 -p 126 -st none -pt topic418_1_0 -u 0.03813243718718723 > ./result_10chains/node418_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_2_0 -p 151 -st none -pt topic418_2_0 -u 0.016025179924121113 > ./result_10chains/node418_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_3_0 -p 217 -st none -pt topic418_3_0 -u 0.03899145447679814 > ./result_10chains/node418_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_4_0 -p 419 -st none -pt topic418_4_0 -u 0.0009118565252696498 > ./result_10chains/node418_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_5_0 -p 444 -st none -pt topic418_5_0 -u 0.003195659586794769 > ./result_10chains/node418_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_6_0 -p 579 -st none -pt topic418_6_0 -u 0.02053287239183918 > ./result_10chains/node418_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_7_0 -p 588 -st none -pt topic418_7_0 -u 0.006710980136017716 > ./result_10chains/node418_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_8_0 -p 794 -st none -pt topic418_8_0 -u 0.0003719669940744838 > ./result_10chains/node418_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_9_0 -p 986 -st none -pt topic418_9_0 -u 0.009900803029103818 > ./result_10chains/node418_9_0.txt &
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
    "./result_10chains/node418_0_0.txt 90"
    "./result_10chains/node418_0_2.txt 90"
    "./result_10chains/node418_1_0.txt 89"
    "./result_10chains/node418_1_2.txt 89"
    "./result_10chains/node418_2_0.txt 88"
    "./result_10chains/node418_2_2.txt 88"
    "./result_10chains/node418_3_0.txt 87"
    "./result_10chains/node418_3_2.txt 87"
    "./result_10chains/node418_4_0.txt 86"
    "./result_10chains/node418_4_2.txt 86"
    "./result_10chains/node418_5_0.txt 85"
    "./result_10chains/node418_5_2.txt 85"
    "./result_10chains/node418_6_0.txt 84"
    "./result_10chains/node418_6_2.txt 84"
    "./result_10chains/node418_7_0.txt 83"
    "./result_10chains/node418_7_2.txt 83"
    "./result_10chains/node418_8_0.txt 82"
    "./result_10chains/node418_8_2.txt 82"
    "./result_10chains/node418_9_0.txt 81"
    "./result_10chains/node418_9_2.txt 81"
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
