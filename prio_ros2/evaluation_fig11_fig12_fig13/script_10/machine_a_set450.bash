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
ros2 run evaluation_3_randomdag uunifast_node -n node450_0_2 -p 147 -st topic450_0_1 -pt None -u 0.05043077731067869 > ./result_10chains/node450_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_1_2 -p 221 -st topic450_1_1 -pt None -u 0.040789353304970966 > ./result_10chains/node450_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_2_2 -p 318 -st topic450_2_1 -pt None -u 0.012494114338512496 > ./result_10chains/node450_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_3_2 -p 331 -st topic450_3_1 -pt None -u 0.0038878933159795515 > ./result_10chains/node450_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_4_2 -p 381 -st topic450_4_1 -pt None -u 0.01011660813158477 > ./result_10chains/node450_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_5_2 -p 491 -st topic450_5_1 -pt None -u 0.015130997304215493 > ./result_10chains/node450_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_6_2 -p 522 -st topic450_6_1 -pt None -u 0.030000077658471694 > ./result_10chains/node450_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_7_2 -p 829 -st topic450_7_1 -pt None -u 0.039277570446422036 > ./result_10chains/node450_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_8_2 -p 885 -st topic450_8_1 -pt None -u 0.0071791208443946295 > ./result_10chains/node450_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_9_2 -p 971 -st topic450_9_1 -pt None -u 0.00055809423723401 > ./result_10chains/node450_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_0_0 -p 147 -st none -pt topic450_0_0 -u 0.022621453356947707 > ./result_10chains/node450_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_1_0 -p 221 -st none -pt topic450_1_0 -u 0.00964191958274424 > ./result_10chains/node450_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_2_0 -p 318 -st none -pt topic450_2_0 -u 0.007744257326545878 > ./result_10chains/node450_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_3_0 -p 331 -st none -pt topic450_3_0 -u 0.01700464122991524 > ./result_10chains/node450_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_4_0 -p 381 -st none -pt topic450_4_0 -u 0.011771527201219822 > ./result_10chains/node450_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_5_0 -p 491 -st none -pt topic450_5_0 -u 0.020430441786158327 > ./result_10chains/node450_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_6_0 -p 522 -st none -pt topic450_6_0 -u 0.05429533247562138 > ./result_10chains/node450_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_7_0 -p 829 -st none -pt topic450_7_0 -u 0.022600303440172054 > ./result_10chains/node450_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_8_0 -p 885 -st none -pt topic450_8_0 -u 0.0010399489617139938 > ./result_10chains/node450_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_9_0 -p 971 -st none -pt topic450_9_0 -u 0.0032610767216200783 > ./result_10chains/node450_9_0.txt &
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
    "./result_10chains/node450_0_0.txt 90"
    "./result_10chains/node450_0_2.txt 90"
    "./result_10chains/node450_1_0.txt 89"
    "./result_10chains/node450_1_2.txt 89"
    "./result_10chains/node450_2_0.txt 88"
    "./result_10chains/node450_2_2.txt 88"
    "./result_10chains/node450_3_0.txt 87"
    "./result_10chains/node450_3_2.txt 87"
    "./result_10chains/node450_4_0.txt 86"
    "./result_10chains/node450_4_2.txt 86"
    "./result_10chains/node450_5_0.txt 85"
    "./result_10chains/node450_5_2.txt 85"
    "./result_10chains/node450_6_0.txt 84"
    "./result_10chains/node450_6_2.txt 84"
    "./result_10chains/node450_7_0.txt 83"
    "./result_10chains/node450_7_2.txt 83"
    "./result_10chains/node450_8_0.txt 82"
    "./result_10chains/node450_8_2.txt 82"
    "./result_10chains/node450_9_0.txt 81"
    "./result_10chains/node450_9_2.txt 81"
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
