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
ros2 run evaluation_3_randomdag uunifast_node -n node174_0_2 -p 32 -st topic174_0_1 -pt None -u 0.013031625308064565 > ./result_8chains/node174_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node174_1_2 -p 197 -st topic174_1_1 -pt None -u 0.0015145915829632428 > ./result_8chains/node174_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_2_2 -p 312 -st topic174_2_1 -pt None -u 0.040694008175731405 > ./result_8chains/node174_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node174_3_2 -p 368 -st topic174_3_1 -pt None -u 0.0067572959592747395 > ./result_8chains/node174_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_4_2 -p 381 -st topic174_4_1 -pt None -u 0.002082553500776879 > ./result_8chains/node174_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node174_5_2 -p 429 -st topic174_5_1 -pt None -u 0.03360209685467441 > ./result_8chains/node174_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_6_2 -p 680 -st topic174_6_1 -pt None -u 0.006053921574052046 > ./result_8chains/node174_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node174_7_2 -p 994 -st topic174_7_1 -pt None -u 0.014110551219403375 > ./result_8chains/node174_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_0_0 -p 32 -st none -pt topic174_0_0 -u 0.014415681574902417 > ./result_8chains/node174_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node174_1_0 -p 197 -st none -pt topic174_1_0 -u 0.04457508974792279 > ./result_8chains/node174_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_2_0 -p 312 -st none -pt topic174_2_0 -u 0.03426408616582033 > ./result_8chains/node174_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node174_3_0 -p 368 -st none -pt topic174_3_0 -u 0.002365474489936431 > ./result_8chains/node174_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_4_0 -p 381 -st none -pt topic174_4_0 -u 0.06564973784376596 > ./result_8chains/node174_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node174_5_0 -p 429 -st none -pt topic174_5_0 -u 0.005317549631189397 > ./result_8chains/node174_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_6_0 -p 680 -st none -pt topic174_6_0 -u 0.020976309139641026 > ./result_8chains/node174_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node174_7_0 -p 994 -st none -pt topic174_7_0 -u 0.007487474496630189 > ./result_8chains/node174_7_0.txt &
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
    "./result_8chains/node174_0_0.txt 90"
    "./result_8chains/node174_0_2.txt 90"
    "./result_8chains/node174_1_0.txt 89"
    "./result_8chains/node174_1_2.txt 89"
    "./result_8chains/node174_2_0.txt 88"
    "./result_8chains/node174_2_2.txt 88"
    "./result_8chains/node174_3_0.txt 87"
    "./result_8chains/node174_3_2.txt 87"
    "./result_8chains/node174_4_0.txt 86"
    "./result_8chains/node174_4_2.txt 86"
    "./result_8chains/node174_5_0.txt 85"
    "./result_8chains/node174_5_2.txt 85"
    "./result_8chains/node174_6_0.txt 84"
    "./result_8chains/node174_6_2.txt 84"
    "./result_8chains/node174_7_0.txt 83"
    "./result_8chains/node174_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
