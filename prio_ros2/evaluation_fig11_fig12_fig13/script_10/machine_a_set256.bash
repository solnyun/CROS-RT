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
ros2 run evaluation_3_randomdag uunifast_node -n node256_0_2 -p 49 -st topic256_0_1 -pt None -u 0.022758448968224043 > ./result_10chains/node256_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node256_1_2 -p 262 -st topic256_1_1 -pt None -u 0.009030596135510938 > ./result_10chains/node256_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_2_2 -p 263 -st topic256_2_1 -pt None -u 0.014319037050074479 > ./result_10chains/node256_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node256_3_2 -p 297 -st topic256_3_1 -pt None -u 0.03336132288538135 > ./result_10chains/node256_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_4_2 -p 348 -st topic256_4_1 -pt None -u 0.01647451570283953 > ./result_10chains/node256_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node256_5_2 -p 570 -st topic256_5_1 -pt None -u 0.021740375817328295 > ./result_10chains/node256_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_6_2 -p 773 -st topic256_6_1 -pt None -u 0.004870555613564892 > ./result_10chains/node256_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node256_7_2 -p 849 -st topic256_7_1 -pt None -u 0.017025177262074906 > ./result_10chains/node256_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_8_2 -p 873 -st topic256_8_1 -pt None -u 0.013159258684888642 > ./result_10chains/node256_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node256_9_2 -p 972 -st topic256_9_1 -pt None -u 0.016668342995126952 > ./result_10chains/node256_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_0_0 -p 49 -st none -pt topic256_0_0 -u 0.007863565613866641 > ./result_10chains/node256_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node256_1_0 -p 262 -st none -pt topic256_1_0 -u 0.0011985648241489288 > ./result_10chains/node256_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_2_0 -p 263 -st none -pt topic256_2_0 -u 0.014651808484163642 > ./result_10chains/node256_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node256_3_0 -p 297 -st none -pt topic256_3_0 -u 0.002624650240002635 > ./result_10chains/node256_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_4_0 -p 348 -st none -pt topic256_4_0 -u 0.02669713969904991 > ./result_10chains/node256_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node256_5_0 -p 570 -st none -pt topic256_5_0 -u 0.024773266822980783 > ./result_10chains/node256_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_6_0 -p 773 -st none -pt topic256_6_0 -u 0.0028131977501216765 > ./result_10chains/node256_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node256_7_0 -p 849 -st none -pt topic256_7_0 -u 0.004469907545515753 > ./result_10chains/node256_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_8_0 -p 873 -st none -pt topic256_8_0 -u 0.017492234357224495 > ./result_10chains/node256_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node256_9_0 -p 972 -st none -pt topic256_9_0 -u 0.0059438348647017775 > ./result_10chains/node256_9_0.txt &
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
    "./result_10chains/node256_0_0.txt 90"
    "./result_10chains/node256_0_2.txt 90"
    "./result_10chains/node256_1_0.txt 89"
    "./result_10chains/node256_1_2.txt 89"
    "./result_10chains/node256_2_0.txt 88"
    "./result_10chains/node256_2_2.txt 88"
    "./result_10chains/node256_3_0.txt 87"
    "./result_10chains/node256_3_2.txt 87"
    "./result_10chains/node256_4_0.txt 86"
    "./result_10chains/node256_4_2.txt 86"
    "./result_10chains/node256_5_0.txt 85"
    "./result_10chains/node256_5_2.txt 85"
    "./result_10chains/node256_6_0.txt 84"
    "./result_10chains/node256_6_2.txt 84"
    "./result_10chains/node256_7_0.txt 83"
    "./result_10chains/node256_7_2.txt 83"
    "./result_10chains/node256_8_0.txt 82"
    "./result_10chains/node256_8_2.txt 82"
    "./result_10chains/node256_9_0.txt 81"
    "./result_10chains/node256_9_2.txt 81"
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
