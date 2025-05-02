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
ros2 run evaluation_3_randomdag uunifast_node -n node135_0_2 -p 45 -st topic135_0_1 -pt None -u 0.009449123341488896 > ./result_10chains/node135_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_1_2 -p 80 -st topic135_1_1 -pt None -u 0.05187121763357361 > ./result_10chains/node135_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_2_2 -p 292 -st topic135_2_1 -pt None -u 0.013901399100155976 > ./result_10chains/node135_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_3_2 -p 344 -st topic135_3_1 -pt None -u 0.003476827351169276 > ./result_10chains/node135_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_4_2 -p 381 -st topic135_4_1 -pt None -u 0.014166599181244965 > ./result_10chains/node135_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_5_2 -p 420 -st topic135_5_1 -pt None -u 0.0026805148655125177 > ./result_10chains/node135_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_6_2 -p 487 -st topic135_6_1 -pt None -u 0.025565706798073393 > ./result_10chains/node135_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_7_2 -p 572 -st topic135_7_1 -pt None -u 0.010311885062140813 > ./result_10chains/node135_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_8_2 -p 895 -st topic135_8_1 -pt None -u 0.005545595609747683 > ./result_10chains/node135_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_9_2 -p 907 -st topic135_9_1 -pt None -u 0.004907791598758746 > ./result_10chains/node135_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_0_0 -p 45 -st none -pt topic135_0_0 -u 0.005047350637028436 > ./result_10chains/node135_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_1_0 -p 80 -st none -pt topic135_1_0 -u 0.0001911361908085163 > ./result_10chains/node135_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_2_0 -p 292 -st none -pt topic135_2_0 -u 0.001258673992980186 > ./result_10chains/node135_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_3_0 -p 344 -st none -pt topic135_3_0 -u 0.009794109405614315 > ./result_10chains/node135_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_4_0 -p 381 -st none -pt topic135_4_0 -u 0.03657312656307132 > ./result_10chains/node135_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_5_0 -p 420 -st none -pt topic135_5_0 -u 0.10626090115209189 > ./result_10chains/node135_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_6_0 -p 487 -st none -pt topic135_6_0 -u 0.013700659753260666 > ./result_10chains/node135_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_7_0 -p 572 -st none -pt topic135_7_0 -u 0.010915037545676895 > ./result_10chains/node135_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_8_0 -p 895 -st none -pt topic135_8_0 -u 0.0028781221425632914 > ./result_10chains/node135_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_9_0 -p 907 -st none -pt topic135_9_0 -u 0.006548498717449273 > ./result_10chains/node135_9_0.txt &
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
    "./result_10chains/node135_0_0.txt 90"
    "./result_10chains/node135_0_2.txt 90"
    "./result_10chains/node135_1_0.txt 89"
    "./result_10chains/node135_1_2.txt 89"
    "./result_10chains/node135_2_0.txt 88"
    "./result_10chains/node135_2_2.txt 88"
    "./result_10chains/node135_3_0.txt 87"
    "./result_10chains/node135_3_2.txt 87"
    "./result_10chains/node135_4_0.txt 86"
    "./result_10chains/node135_4_2.txt 86"
    "./result_10chains/node135_5_0.txt 85"
    "./result_10chains/node135_5_2.txt 85"
    "./result_10chains/node135_6_0.txt 84"
    "./result_10chains/node135_6_2.txt 84"
    "./result_10chains/node135_7_0.txt 83"
    "./result_10chains/node135_7_2.txt 83"
    "./result_10chains/node135_8_0.txt 82"
    "./result_10chains/node135_8_2.txt 82"
    "./result_10chains/node135_9_0.txt 81"
    "./result_10chains/node135_9_2.txt 81"
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
