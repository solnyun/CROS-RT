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
ros2 run evaluation_3_randomdag uunifast_node -n node199_0_2 -p 58 -st topic199_0_1 -pt None -u 0.008281432327785887 > ./result_8chains/node199_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_1_2 -p 128 -st topic199_1_1 -pt None -u 0.10646021072286893 > ./result_8chains/node199_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_2_2 -p 251 -st topic199_2_1 -pt None -u 0.019334414339610084 > ./result_8chains/node199_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_3_2 -p 478 -st topic199_3_1 -pt None -u 0.0066540631860994015 > ./result_8chains/node199_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_4_2 -p 772 -st topic199_4_1 -pt None -u 0.014277945354312954 > ./result_8chains/node199_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_5_2 -p 853 -st topic199_5_1 -pt None -u 0.0013239230443342354 > ./result_8chains/node199_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_6_2 -p 919 -st topic199_6_1 -pt None -u 0.01123891404695987 > ./result_8chains/node199_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_7_2 -p 967 -st topic199_7_1 -pt None -u 0.0032356104129066024 > ./result_8chains/node199_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_0_0 -p 58 -st none -pt topic199_0_0 -u 0.00016587186495897743 > ./result_8chains/node199_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_1_0 -p 128 -st none -pt topic199_1_0 -u 0.05200955012918146 > ./result_8chains/node199_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_2_0 -p 251 -st none -pt topic199_2_0 -u 0.010113507883823591 > ./result_8chains/node199_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_3_0 -p 478 -st none -pt topic199_3_0 -u 0.010069810134305301 > ./result_8chains/node199_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_4_0 -p 772 -st none -pt topic199_4_0 -u 0.0164169951727276 > ./result_8chains/node199_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_5_0 -p 853 -st none -pt topic199_5_0 -u 0.023065200548507497 > ./result_8chains/node199_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_6_0 -p 919 -st none -pt topic199_6_0 -u 0.01470448031780805 > ./result_8chains/node199_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_7_0 -p 967 -st none -pt topic199_7_0 -u 0.013493873386305352 > ./result_8chains/node199_7_0.txt &
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
    "./result_8chains/node199_0_0.txt 90"
    "./result_8chains/node199_0_2.txt 90"
    "./result_8chains/node199_1_0.txt 89"
    "./result_8chains/node199_1_2.txt 89"
    "./result_8chains/node199_2_0.txt 88"
    "./result_8chains/node199_2_2.txt 88"
    "./result_8chains/node199_3_0.txt 87"
    "./result_8chains/node199_3_2.txt 87"
    "./result_8chains/node199_4_0.txt 86"
    "./result_8chains/node199_4_2.txt 86"
    "./result_8chains/node199_5_0.txt 85"
    "./result_8chains/node199_5_2.txt 85"
    "./result_8chains/node199_6_0.txt 84"
    "./result_8chains/node199_6_2.txt 84"
    "./result_8chains/node199_7_0.txt 83"
    "./result_8chains/node199_7_2.txt 83"
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
