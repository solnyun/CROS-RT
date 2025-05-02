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
ros2 run evaluation_3_randomdag uunifast_node -n node470_0_2 -p 71 -st topic470_0_1 -pt None -u 0.02865733477498633 > ./result_10chains/node470_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_1_2 -p 195 -st topic470_1_1 -pt None -u 0.015351902030657893 > ./result_10chains/node470_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_2_2 -p 224 -st topic470_2_1 -pt None -u 0.009656290515488275 > ./result_10chains/node470_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_3_2 -p 254 -st topic470_3_1 -pt None -u 0.020050461725180824 > ./result_10chains/node470_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_4_2 -p 263 -st topic470_4_1 -pt None -u 0.008591158648869363 > ./result_10chains/node470_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_5_2 -p 316 -st topic470_5_1 -pt None -u 0.0017582920952591008 > ./result_10chains/node470_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_6_2 -p 457 -st topic470_6_1 -pt None -u 0.004063999852004813 > ./result_10chains/node470_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_7_2 -p 592 -st topic470_7_1 -pt None -u 0.020188386427750837 > ./result_10chains/node470_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_8_2 -p 741 -st topic470_8_1 -pt None -u 0.003999877458609594 > ./result_10chains/node470_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_9_2 -p 841 -st topic470_9_1 -pt None -u 0.03887827647192582 > ./result_10chains/node470_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_0_0 -p 71 -st none -pt topic470_0_0 -u 0.06648323605881068 > ./result_10chains/node470_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_1_0 -p 195 -st none -pt topic470_1_0 -u 0.0017937343027101815 > ./result_10chains/node470_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_2_0 -p 224 -st none -pt topic470_2_0 -u 0.00019121436425001415 > ./result_10chains/node470_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_3_0 -p 254 -st none -pt topic470_3_0 -u 0.011910556185118992 > ./result_10chains/node470_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_4_0 -p 263 -st none -pt topic470_4_0 -u 0.019363375670668787 > ./result_10chains/node470_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_5_0 -p 316 -st none -pt topic470_5_0 -u 0.010261557774736113 > ./result_10chains/node470_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_6_0 -p 457 -st none -pt topic470_6_0 -u 0.04350993303420855 > ./result_10chains/node470_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_7_0 -p 592 -st none -pt topic470_7_0 -u 0.0003847928691765312 > ./result_10chains/node470_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_8_0 -p 741 -st none -pt topic470_8_0 -u 0.003254550149865712 > ./result_10chains/node470_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_9_0 -p 841 -st none -pt topic470_9_0 -u 0.011946010660687047 > ./result_10chains/node470_9_0.txt &
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
    "./result_10chains/node470_0_0.txt 90"
    "./result_10chains/node470_0_2.txt 90"
    "./result_10chains/node470_1_0.txt 89"
    "./result_10chains/node470_1_2.txt 89"
    "./result_10chains/node470_2_0.txt 88"
    "./result_10chains/node470_2_2.txt 88"
    "./result_10chains/node470_3_0.txt 87"
    "./result_10chains/node470_3_2.txt 87"
    "./result_10chains/node470_4_0.txt 86"
    "./result_10chains/node470_4_2.txt 86"
    "./result_10chains/node470_5_0.txt 85"
    "./result_10chains/node470_5_2.txt 85"
    "./result_10chains/node470_6_0.txt 84"
    "./result_10chains/node470_6_2.txt 84"
    "./result_10chains/node470_7_0.txt 83"
    "./result_10chains/node470_7_2.txt 83"
    "./result_10chains/node470_8_0.txt 82"
    "./result_10chains/node470_8_2.txt 82"
    "./result_10chains/node470_9_0.txt 81"
    "./result_10chains/node470_9_2.txt 81"
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
