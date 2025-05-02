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
ros2 run evaluation_3_randomdag uunifast_node -n node137_0_2 -p 261 -st topic137_0_1 -pt None -u 0.0214252033527092 > ./result_10chains/node137_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_1_2 -p 267 -st topic137_1_1 -pt None -u 0.023144037115991445 > ./result_10chains/node137_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_2_2 -p 404 -st topic137_2_1 -pt None -u 0.029234933333796842 > ./result_10chains/node137_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_3_2 -p 414 -st topic137_3_1 -pt None -u 0.026007687400537882 > ./result_10chains/node137_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_4_2 -p 518 -st topic137_4_1 -pt None -u 0.010120662095894295 > ./result_10chains/node137_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_5_2 -p 656 -st topic137_5_1 -pt None -u 0.0016452388609892177 > ./result_10chains/node137_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_6_2 -p 693 -st topic137_6_1 -pt None -u 0.011736944780170594 > ./result_10chains/node137_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_7_2 -p 735 -st topic137_7_1 -pt None -u 0.02130360233590675 > ./result_10chains/node137_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_8_2 -p 784 -st topic137_8_1 -pt None -u 0.00684733381938072 > ./result_10chains/node137_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_9_2 -p 870 -st topic137_9_1 -pt None -u 0.003837970852214407 > ./result_10chains/node137_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_0_0 -p 261 -st none -pt topic137_0_0 -u 0.006087839897794545 > ./result_10chains/node137_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_1_0 -p 267 -st none -pt topic137_1_0 -u 0.0019121670945628222 > ./result_10chains/node137_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_2_0 -p 404 -st none -pt topic137_2_0 -u 0.00876047796161522 > ./result_10chains/node137_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_3_0 -p 414 -st none -pt topic137_3_0 -u 0.006567183322627734 > ./result_10chains/node137_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_4_0 -p 518 -st none -pt topic137_4_0 -u 0.00752780854090801 > ./result_10chains/node137_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_5_0 -p 656 -st none -pt topic137_5_0 -u 0.0014286703412673685 > ./result_10chains/node137_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_6_0 -p 693 -st none -pt topic137_6_0 -u 0.01650921847483744 > ./result_10chains/node137_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_7_0 -p 735 -st none -pt topic137_7_0 -u 0.05311831441314681 > ./result_10chains/node137_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_8_0 -p 784 -st none -pt topic137_8_0 -u 0.03898118969367391 > ./result_10chains/node137_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_9_0 -p 870 -st none -pt topic137_9_0 -u 0.0024373203333914323 > ./result_10chains/node137_9_0.txt &
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
    "./result_10chains/node137_0_0.txt 90"
    "./result_10chains/node137_0_2.txt 90"
    "./result_10chains/node137_1_0.txt 89"
    "./result_10chains/node137_1_2.txt 89"
    "./result_10chains/node137_2_0.txt 88"
    "./result_10chains/node137_2_2.txt 88"
    "./result_10chains/node137_3_0.txt 87"
    "./result_10chains/node137_3_2.txt 87"
    "./result_10chains/node137_4_0.txt 86"
    "./result_10chains/node137_4_2.txt 86"
    "./result_10chains/node137_5_0.txt 85"
    "./result_10chains/node137_5_2.txt 85"
    "./result_10chains/node137_6_0.txt 84"
    "./result_10chains/node137_6_2.txt 84"
    "./result_10chains/node137_7_0.txt 83"
    "./result_10chains/node137_7_2.txt 83"
    "./result_10chains/node137_8_0.txt 82"
    "./result_10chains/node137_8_2.txt 82"
    "./result_10chains/node137_9_0.txt 81"
    "./result_10chains/node137_9_2.txt 81"
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
