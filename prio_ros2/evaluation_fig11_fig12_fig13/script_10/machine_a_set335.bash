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
ros2 run evaluation_3_randomdag uunifast_node -n node335_0_2 -p 52 -st topic335_0_1 -pt None -u 0.00017932551262878071 > ./result_10chains/node335_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_1_2 -p 123 -st topic335_1_1 -pt None -u 0.0666856673034183 > ./result_10chains/node335_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_2_2 -p 130 -st topic335_2_1 -pt None -u 0.005701717094135694 > ./result_10chains/node335_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_3_2 -p 276 -st topic335_3_1 -pt None -u 0.02369378874176792 > ./result_10chains/node335_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_4_2 -p 287 -st topic335_4_1 -pt None -u 0.0009863602364171276 > ./result_10chains/node335_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_5_2 -p 338 -st topic335_5_1 -pt None -u 0.013557470861860516 > ./result_10chains/node335_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_6_2 -p 385 -st topic335_6_1 -pt None -u 0.015597037672844177 > ./result_10chains/node335_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_7_2 -p 449 -st topic335_7_1 -pt None -u 0.001394050365403271 > ./result_10chains/node335_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_8_2 -p 567 -st topic335_8_1 -pt None -u 0.07692824891494501 > ./result_10chains/node335_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_9_2 -p 805 -st topic335_9_1 -pt None -u 0.0009433250289900738 > ./result_10chains/node335_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_0_0 -p 52 -st none -pt topic335_0_0 -u 0.0034147286876883287 > ./result_10chains/node335_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_1_0 -p 123 -st none -pt topic335_1_0 -u 0.006846136045239426 > ./result_10chains/node335_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_2_0 -p 130 -st none -pt topic335_2_0 -u 0.006711806007807908 > ./result_10chains/node335_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_3_0 -p 276 -st none -pt topic335_3_0 -u 0.0016866398210216293 > ./result_10chains/node335_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_4_0 -p 287 -st none -pt topic335_4_0 -u 0.0021498682111626977 > ./result_10chains/node335_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_5_0 -p 338 -st none -pt topic335_5_0 -u 0.013960929884274997 > ./result_10chains/node335_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_6_0 -p 385 -st none -pt topic335_6_0 -u 0.02358894123523625 > ./result_10chains/node335_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_7_0 -p 449 -st none -pt topic335_7_0 -u 0.007125174591464112 > ./result_10chains/node335_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_8_0 -p 567 -st none -pt topic335_8_0 -u 0.021221169074463225 > ./result_10chains/node335_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_9_0 -p 805 -st none -pt topic335_9_0 -u 0.01058224718582372 > ./result_10chains/node335_9_0.txt &
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
    "./result_10chains/node335_0_0.txt 90"
    "./result_10chains/node335_0_2.txt 90"
    "./result_10chains/node335_1_0.txt 89"
    "./result_10chains/node335_1_2.txt 89"
    "./result_10chains/node335_2_0.txt 88"
    "./result_10chains/node335_2_2.txt 88"
    "./result_10chains/node335_3_0.txt 87"
    "./result_10chains/node335_3_2.txt 87"
    "./result_10chains/node335_4_0.txt 86"
    "./result_10chains/node335_4_2.txt 86"
    "./result_10chains/node335_5_0.txt 85"
    "./result_10chains/node335_5_2.txt 85"
    "./result_10chains/node335_6_0.txt 84"
    "./result_10chains/node335_6_2.txt 84"
    "./result_10chains/node335_7_0.txt 83"
    "./result_10chains/node335_7_2.txt 83"
    "./result_10chains/node335_8_0.txt 82"
    "./result_10chains/node335_8_2.txt 82"
    "./result_10chains/node335_9_0.txt 81"
    "./result_10chains/node335_9_2.txt 81"
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
