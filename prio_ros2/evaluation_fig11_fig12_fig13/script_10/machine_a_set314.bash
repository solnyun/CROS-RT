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
ros2 run evaluation_3_randomdag uunifast_node -n node314_0_2 -p 115 -st topic314_0_1 -pt None -u 0.006690588555972488 > ./result_10chains/node314_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_1_2 -p 234 -st topic314_1_1 -pt None -u 0.013464524479249007 > ./result_10chains/node314_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_2_2 -p 242 -st topic314_2_1 -pt None -u 0.0034458150772540552 > ./result_10chains/node314_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_3_2 -p 244 -st topic314_3_1 -pt None -u 0.006595428785683755 > ./result_10chains/node314_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_4_2 -p 336 -st topic314_4_1 -pt None -u 0.0012582345231572645 > ./result_10chains/node314_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_5_2 -p 490 -st topic314_5_1 -pt None -u 0.05280871336081025 > ./result_10chains/node314_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_6_2 -p 549 -st topic314_6_1 -pt None -u 0.014340696809926834 > ./result_10chains/node314_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_7_2 -p 661 -st topic314_7_1 -pt None -u 0.01029308551819566 > ./result_10chains/node314_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_8_2 -p 819 -st topic314_8_1 -pt None -u 0.030190498797155997 > ./result_10chains/node314_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_9_2 -p 933 -st topic314_9_1 -pt None -u 0.009943380934248134 > ./result_10chains/node314_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_0_0 -p 115 -st none -pt topic314_0_0 -u 0.022212518023719707 > ./result_10chains/node314_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_1_0 -p 234 -st none -pt topic314_1_0 -u 0.0003629961405277049 > ./result_10chains/node314_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_2_0 -p 242 -st none -pt topic314_2_0 -u 0.00375583544474839 > ./result_10chains/node314_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_3_0 -p 244 -st none -pt topic314_3_0 -u 0.007414246448164352 > ./result_10chains/node314_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_4_0 -p 336 -st none -pt topic314_4_0 -u 0.013801268613544526 > ./result_10chains/node314_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_5_0 -p 490 -st none -pt topic314_5_0 -u 0.05052758741523122 > ./result_10chains/node314_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_6_0 -p 549 -st none -pt topic314_6_0 -u 0.013843846922897696 > ./result_10chains/node314_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_7_0 -p 661 -st none -pt topic314_7_0 -u 0.015424293661789767 > ./result_10chains/node314_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_8_0 -p 819 -st none -pt topic314_8_0 -u 0.02247534554891195 > ./result_10chains/node314_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_9_0 -p 933 -st none -pt topic314_9_0 -u 0.004893392311749591 > ./result_10chains/node314_9_0.txt &
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
    "./result_10chains/node314_0_0.txt 90"
    "./result_10chains/node314_0_2.txt 90"
    "./result_10chains/node314_1_0.txt 89"
    "./result_10chains/node314_1_2.txt 89"
    "./result_10chains/node314_2_0.txt 88"
    "./result_10chains/node314_2_2.txt 88"
    "./result_10chains/node314_3_0.txt 87"
    "./result_10chains/node314_3_2.txt 87"
    "./result_10chains/node314_4_0.txt 86"
    "./result_10chains/node314_4_2.txt 86"
    "./result_10chains/node314_5_0.txt 85"
    "./result_10chains/node314_5_2.txt 85"
    "./result_10chains/node314_6_0.txt 84"
    "./result_10chains/node314_6_2.txt 84"
    "./result_10chains/node314_7_0.txt 83"
    "./result_10chains/node314_7_2.txt 83"
    "./result_10chains/node314_8_0.txt 82"
    "./result_10chains/node314_8_2.txt 82"
    "./result_10chains/node314_9_0.txt 81"
    "./result_10chains/node314_9_2.txt 81"
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
