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
ros2 run evaluation_3_randomdag uunifast_node -n node449_0_2 -p 121 -st topic449_0_1 -pt None -u 0.0024038136418286227 > ./result_10chains/node449_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_1_2 -p 158 -st topic449_1_1 -pt None -u 0.0014486667037836853 > ./result_10chains/node449_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_2_2 -p 214 -st topic449_2_1 -pt None -u 0.010652180901730757 > ./result_10chains/node449_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_3_2 -p 258 -st topic449_3_1 -pt None -u 0.015892683693077114 > ./result_10chains/node449_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_4_2 -p 533 -st topic449_4_1 -pt None -u 0.006847770530838765 > ./result_10chains/node449_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_5_2 -p 554 -st topic449_5_1 -pt None -u 0.014852728057912018 > ./result_10chains/node449_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_6_2 -p 750 -st topic449_6_1 -pt None -u 0.008602546225324637 > ./result_10chains/node449_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_7_2 -p 782 -st topic449_7_1 -pt None -u 0.06422296108595844 > ./result_10chains/node449_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_8_2 -p 815 -st topic449_8_1 -pt None -u 0.006778695317818592 > ./result_10chains/node449_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_9_2 -p 838 -st topic449_9_1 -pt None -u 0.018161965378025332 > ./result_10chains/node449_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_0_0 -p 121 -st none -pt topic449_0_0 -u 0.06324638231949709 > ./result_10chains/node449_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_1_0 -p 158 -st none -pt topic449_1_0 -u 0.004798192302693349 > ./result_10chains/node449_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_2_0 -p 214 -st none -pt topic449_2_0 -u 0.005792886244573525 > ./result_10chains/node449_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_3_0 -p 258 -st none -pt topic449_3_0 -u 0.04560662310012298 > ./result_10chains/node449_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_4_0 -p 533 -st none -pt topic449_4_0 -u 0.04487465918173511 > ./result_10chains/node449_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_5_0 -p 554 -st none -pt topic449_5_0 -u 0.0018313214865094685 > ./result_10chains/node449_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_6_0 -p 750 -st none -pt topic449_6_0 -u 0.010051949942304267 > ./result_10chains/node449_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_7_0 -p 782 -st none -pt topic449_7_0 -u 0.022334587770838743 > ./result_10chains/node449_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_8_0 -p 815 -st none -pt topic449_8_0 -u 0.0015993767107724127 > ./result_10chains/node449_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_9_0 -p 838 -st none -pt topic449_9_0 -u 0.037271941948084114 > ./result_10chains/node449_9_0.txt &
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
    "./result_10chains/node449_0_0.txt 90"
    "./result_10chains/node449_0_2.txt 90"
    "./result_10chains/node449_1_0.txt 89"
    "./result_10chains/node449_1_2.txt 89"
    "./result_10chains/node449_2_0.txt 88"
    "./result_10chains/node449_2_2.txt 88"
    "./result_10chains/node449_3_0.txt 87"
    "./result_10chains/node449_3_2.txt 87"
    "./result_10chains/node449_4_0.txt 86"
    "./result_10chains/node449_4_2.txt 86"
    "./result_10chains/node449_5_0.txt 85"
    "./result_10chains/node449_5_2.txt 85"
    "./result_10chains/node449_6_0.txt 84"
    "./result_10chains/node449_6_2.txt 84"
    "./result_10chains/node449_7_0.txt 83"
    "./result_10chains/node449_7_2.txt 83"
    "./result_10chains/node449_8_0.txt 82"
    "./result_10chains/node449_8_2.txt 82"
    "./result_10chains/node449_9_0.txt 81"
    "./result_10chains/node449_9_2.txt 81"
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
