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
ros2 run evaluation_3_randomdag uunifast_node -n node42_0_2 -p 19 -st topic42_0_1 -pt None -u 0.057087948131626265 > ./result_10chains/node42_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_1_2 -p 207 -st topic42_1_1 -pt None -u 0.02595454183993745 > ./result_10chains/node42_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_2_2 -p 225 -st topic42_2_1 -pt None -u 0.05268053743433909 > ./result_10chains/node42_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_3_2 -p 231 -st topic42_3_1 -pt None -u 9.383375547705741e-06 > ./result_10chains/node42_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_4_2 -p 284 -st topic42_4_1 -pt None -u 0.0062078129699982 > ./result_10chains/node42_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_5_2 -p 462 -st topic42_5_1 -pt None -u 0.021939900501429327 > ./result_10chains/node42_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_6_2 -p 592 -st topic42_6_1 -pt None -u 0.016702528260210125 > ./result_10chains/node42_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_7_2 -p 864 -st topic42_7_1 -pt None -u 0.0005674869391305987 > ./result_10chains/node42_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_8_2 -p 882 -st topic42_8_1 -pt None -u 0.0075229774334911615 > ./result_10chains/node42_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_9_2 -p 947 -st topic42_9_1 -pt None -u 0.0023963330624200627 > ./result_10chains/node42_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_0_0 -p 19 -st none -pt topic42_0_0 -u 0.01016913004316361 > ./result_10chains/node42_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_1_0 -p 207 -st none -pt topic42_1_0 -u 0.034347703118041695 > ./result_10chains/node42_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_2_0 -p 225 -st none -pt topic42_2_0 -u 0.0007918385254016558 > ./result_10chains/node42_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_3_0 -p 231 -st none -pt topic42_3_0 -u 0.045714185267243246 > ./result_10chains/node42_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_4_0 -p 284 -st none -pt topic42_4_0 -u 0.004542399328570895 > ./result_10chains/node42_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_5_0 -p 462 -st none -pt topic42_5_0 -u 0.005239405777309358 > ./result_10chains/node42_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_6_0 -p 592 -st none -pt topic42_6_0 -u 0.01376325404052478 > ./result_10chains/node42_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_7_0 -p 864 -st none -pt topic42_7_0 -u 0.02339770525479564 > ./result_10chains/node42_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_8_0 -p 882 -st none -pt topic42_8_0 -u 0.008080401497702911 > ./result_10chains/node42_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_9_0 -p 947 -st none -pt topic42_9_0 -u 0.009478212809527278 > ./result_10chains/node42_9_0.txt &
sleep 10
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
    "./result_10chains/node42_0_0.txt 90"
    "./result_10chains/node42_0_2.txt 90"
    "./result_10chains/node42_1_0.txt 89"
    "./result_10chains/node42_1_2.txt 89"
    "./result_10chains/node42_2_0.txt 88"
    "./result_10chains/node42_2_2.txt 88"
    "./result_10chains/node42_3_0.txt 87"
    "./result_10chains/node42_3_2.txt 87"
    "./result_10chains/node42_4_0.txt 86"
    "./result_10chains/node42_4_2.txt 86"
    "./result_10chains/node42_5_0.txt 85"
    "./result_10chains/node42_5_2.txt 85"
    "./result_10chains/node42_6_0.txt 84"
    "./result_10chains/node42_6_2.txt 84"
    "./result_10chains/node42_7_0.txt 83"
    "./result_10chains/node42_7_2.txt 83"
    "./result_10chains/node42_8_0.txt 82"
    "./result_10chains/node42_8_2.txt 82"
    "./result_10chains/node42_9_0.txt 81"
    "./result_10chains/node42_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
