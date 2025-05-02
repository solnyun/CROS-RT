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
ros2 run evaluation_3_randomdag uunifast_node -n node88_0_2 -p 153 -st topic88_0_1 -pt None -u 0.03925619950337089 > ./result_10chains/node88_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_1_2 -p 156 -st topic88_1_1 -pt None -u 0.013468840256884718 > ./result_10chains/node88_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_2_2 -p 192 -st topic88_2_1 -pt None -u 0.009267881178102733 > ./result_10chains/node88_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_3_2 -p 322 -st topic88_3_1 -pt None -u 0.023465493194343046 > ./result_10chains/node88_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_4_2 -p 580 -st topic88_4_1 -pt None -u 0.01320204609941153 > ./result_10chains/node88_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_5_2 -p 593 -st topic88_5_1 -pt None -u 0.021894298030546572 > ./result_10chains/node88_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_6_2 -p 632 -st topic88_6_1 -pt None -u 0.0037515191170315876 > ./result_10chains/node88_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_7_2 -p 860 -st topic88_7_1 -pt None -u 0.00991644199653148 > ./result_10chains/node88_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_8_2 -p 889 -st topic88_8_1 -pt None -u 0.016241114958162203 > ./result_10chains/node88_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_9_2 -p 969 -st topic88_9_1 -pt None -u 0.009926875109350105 > ./result_10chains/node88_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_0_0 -p 153 -st none -pt topic88_0_0 -u 0.024618483280796355 > ./result_10chains/node88_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_1_0 -p 156 -st none -pt topic88_1_0 -u 0.0015845758473876925 > ./result_10chains/node88_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_2_0 -p 192 -st none -pt topic88_2_0 -u 0.00026087904032745524 > ./result_10chains/node88_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_3_0 -p 322 -st none -pt topic88_3_0 -u 0.004493801600250147 > ./result_10chains/node88_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_4_0 -p 580 -st none -pt topic88_4_0 -u 0.0007059814419925203 > ./result_10chains/node88_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_5_0 -p 593 -st none -pt topic88_5_0 -u 0.016191704226718645 > ./result_10chains/node88_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_6_0 -p 632 -st none -pt topic88_6_0 -u 0.007989341411952428 > ./result_10chains/node88_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_7_0 -p 860 -st none -pt topic88_7_0 -u 0.0026577052807993384 > ./result_10chains/node88_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_8_0 -p 889 -st none -pt topic88_8_0 -u 0.008299685732298112 > ./result_10chains/node88_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_9_0 -p 969 -st none -pt topic88_9_0 -u 0.05634325980138092 > ./result_10chains/node88_9_0.txt &
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
    "./result_10chains/node88_0_0.txt 90"
    "./result_10chains/node88_0_2.txt 90"
    "./result_10chains/node88_1_0.txt 89"
    "./result_10chains/node88_1_2.txt 89"
    "./result_10chains/node88_2_0.txt 88"
    "./result_10chains/node88_2_2.txt 88"
    "./result_10chains/node88_3_0.txt 87"
    "./result_10chains/node88_3_2.txt 87"
    "./result_10chains/node88_4_0.txt 86"
    "./result_10chains/node88_4_2.txt 86"
    "./result_10chains/node88_5_0.txt 85"
    "./result_10chains/node88_5_2.txt 85"
    "./result_10chains/node88_6_0.txt 84"
    "./result_10chains/node88_6_2.txt 84"
    "./result_10chains/node88_7_0.txt 83"
    "./result_10chains/node88_7_2.txt 83"
    "./result_10chains/node88_8_0.txt 82"
    "./result_10chains/node88_8_2.txt 82"
    "./result_10chains/node88_9_0.txt 81"
    "./result_10chains/node88_9_2.txt 81"
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
