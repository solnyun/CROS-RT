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
ros2 run evaluation_3_randomdag uunifast_node -n node240_0_2 -p 57 -st topic240_0_1 -pt None -u 0.00669202676663444 > ./result_10chains/node240_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_1_2 -p 254 -st topic240_1_1 -pt None -u 0.018664956932681775 > ./result_10chains/node240_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_2_2 -p 290 -st topic240_2_1 -pt None -u 0.0040415652167896665 > ./result_10chains/node240_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_3_2 -p 324 -st topic240_3_1 -pt None -u 0.012640781964309511 > ./result_10chains/node240_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_4_2 -p 364 -st topic240_4_1 -pt None -u 0.009424428192786716 > ./result_10chains/node240_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_5_2 -p 530 -st topic240_5_1 -pt None -u 0.016412233229910422 > ./result_10chains/node240_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_6_2 -p 551 -st topic240_6_1 -pt None -u 0.002000599277064863 > ./result_10chains/node240_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_7_2 -p 701 -st topic240_7_1 -pt None -u 0.033739869816947404 > ./result_10chains/node240_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_8_2 -p 702 -st topic240_8_1 -pt None -u 0.021750777168397697 > ./result_10chains/node240_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_9_2 -p 731 -st topic240_9_1 -pt None -u 0.027376511798205955 > ./result_10chains/node240_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_0_0 -p 57 -st none -pt topic240_0_0 -u 0.018195809030367383 > ./result_10chains/node240_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_1_0 -p 254 -st none -pt topic240_1_0 -u 0.03754867684066382 > ./result_10chains/node240_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_2_0 -p 290 -st none -pt topic240_2_0 -u 0.0031313987633782014 > ./result_10chains/node240_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_3_0 -p 324 -st none -pt topic240_3_0 -u 0.0015360711050929066 > ./result_10chains/node240_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_4_0 -p 364 -st none -pt topic240_4_0 -u 0.05116241800638116 > ./result_10chains/node240_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_5_0 -p 530 -st none -pt topic240_5_0 -u 0.020881293427175818 > ./result_10chains/node240_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_6_0 -p 551 -st none -pt topic240_6_0 -u 0.006314460459756088 > ./result_10chains/node240_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_7_0 -p 701 -st none -pt topic240_7_0 -u 0.008517259698312463 > ./result_10chains/node240_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_8_0 -p 702 -st none -pt topic240_8_0 -u 0.010258637016324304 > ./result_10chains/node240_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_9_0 -p 731 -st none -pt topic240_9_0 -u 0.020783784327523792 > ./result_10chains/node240_9_0.txt &
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
    "./result_10chains/node240_0_0.txt 90"
    "./result_10chains/node240_0_2.txt 90"
    "./result_10chains/node240_1_0.txt 89"
    "./result_10chains/node240_1_2.txt 89"
    "./result_10chains/node240_2_0.txt 88"
    "./result_10chains/node240_2_2.txt 88"
    "./result_10chains/node240_3_0.txt 87"
    "./result_10chains/node240_3_2.txt 87"
    "./result_10chains/node240_4_0.txt 86"
    "./result_10chains/node240_4_2.txt 86"
    "./result_10chains/node240_5_0.txt 85"
    "./result_10chains/node240_5_2.txt 85"
    "./result_10chains/node240_6_0.txt 84"
    "./result_10chains/node240_6_2.txt 84"
    "./result_10chains/node240_7_0.txt 83"
    "./result_10chains/node240_7_2.txt 83"
    "./result_10chains/node240_8_0.txt 82"
    "./result_10chains/node240_8_2.txt 82"
    "./result_10chains/node240_9_0.txt 81"
    "./result_10chains/node240_9_2.txt 81"
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
