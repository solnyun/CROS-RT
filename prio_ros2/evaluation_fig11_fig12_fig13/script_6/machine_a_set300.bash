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
ros2 run evaluation_3_randomdag uunifast_node -n node300_0_2 -p 17 -st topic300_0_1 -pt None -u 0.011336373007474199 > ./result_6chains/node300_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_1_2 -p 383 -st topic300_1_1 -pt None -u 0.01790542620119273 > ./result_6chains/node300_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_2_2 -p 452 -st topic300_2_1 -pt None -u 0.02654903794010033 > ./result_6chains/node300_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_3_2 -p 462 -st topic300_3_1 -pt None -u 0.02165756590880158 > ./result_6chains/node300_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_4_2 -p 505 -st topic300_4_1 -pt None -u 0.005437583892145076 > ./result_6chains/node300_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_5_2 -p 570 -st topic300_5_1 -pt None -u 0.052055288347258984 > ./result_6chains/node300_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_0_0 -p 17 -st none -pt topic300_0_0 -u 0.0365477782874723 > ./result_6chains/node300_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_1_0 -p 383 -st none -pt topic300_1_0 -u 0.008220953288908261 > ./result_6chains/node300_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_2_0 -p 452 -st none -pt topic300_2_0 -u 0.02651951970473121 > ./result_6chains/node300_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_3_0 -p 462 -st none -pt topic300_3_0 -u 0.032090794790955 > ./result_6chains/node300_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_4_0 -p 505 -st none -pt topic300_4_0 -u 0.05788687044235902 > ./result_6chains/node300_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_5_0 -p 570 -st none -pt topic300_5_0 -u 0.03927532037074183 > ./result_6chains/node300_5_0.txt &
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
    "./result_6chains/node300_0_0.txt 90"
    "./result_6chains/node300_0_2.txt 90"
    "./result_6chains/node300_1_0.txt 89"
    "./result_6chains/node300_1_2.txt 89"
    "./result_6chains/node300_2_0.txt 88"
    "./result_6chains/node300_2_2.txt 88"
    "./result_6chains/node300_3_0.txt 87"
    "./result_6chains/node300_3_2.txt 87"
    "./result_6chains/node300_4_0.txt 86"
    "./result_6chains/node300_4_2.txt 86"
    "./result_6chains/node300_5_0.txt 85"
    "./result_6chains/node300_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
