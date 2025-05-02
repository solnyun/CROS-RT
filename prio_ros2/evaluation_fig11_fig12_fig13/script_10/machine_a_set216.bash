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
ros2 run evaluation_3_randomdag uunifast_node -n node216_0_2 -p 38 -st topic216_0_1 -pt None -u 0.019743031195753824 > ./result_10chains/node216_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_1_2 -p 241 -st topic216_1_1 -pt None -u 0.0023334270507417987 > ./result_10chains/node216_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_2_2 -p 264 -st topic216_2_1 -pt None -u 0.002407263883611288 > ./result_10chains/node216_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_3_2 -p 373 -st topic216_3_1 -pt None -u 0.009958677023320817 > ./result_10chains/node216_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_4_2 -p 437 -st topic216_4_1 -pt None -u 0.010558798711898187 > ./result_10chains/node216_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_5_2 -p 472 -st topic216_5_1 -pt None -u 0.011728942645589824 > ./result_10chains/node216_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_6_2 -p 617 -st topic216_6_1 -pt None -u 0.03246399422196444 > ./result_10chains/node216_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_7_2 -p 842 -st topic216_7_1 -pt None -u 0.08099539908641343 > ./result_10chains/node216_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_8_2 -p 929 -st topic216_8_1 -pt None -u 0.021164622053735566 > ./result_10chains/node216_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_9_2 -p 962 -st topic216_9_1 -pt None -u 0.02406029070770659 > ./result_10chains/node216_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_0_0 -p 38 -st none -pt topic216_0_0 -u 0.008304293184444755 > ./result_10chains/node216_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_1_0 -p 241 -st none -pt topic216_1_0 -u 0.0061034777729494505 > ./result_10chains/node216_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_2_0 -p 264 -st none -pt topic216_2_0 -u 0.002797105914286724 > ./result_10chains/node216_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_3_0 -p 373 -st none -pt topic216_3_0 -u 0.001206584044192771 > ./result_10chains/node216_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_4_0 -p 437 -st none -pt topic216_4_0 -u 0.0065700222420918 > ./result_10chains/node216_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_5_0 -p 472 -st none -pt topic216_5_0 -u 0.04031998491336053 > ./result_10chains/node216_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_6_0 -p 617 -st none -pt topic216_6_0 -u 0.011919310124359206 > ./result_10chains/node216_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_7_0 -p 842 -st none -pt topic216_7_0 -u 0.0014464800318645388 > ./result_10chains/node216_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_8_0 -p 929 -st none -pt topic216_8_0 -u 0.03389325192491707 > ./result_10chains/node216_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_9_0 -p 962 -st none -pt topic216_9_0 -u 0.013986454256199626 > ./result_10chains/node216_9_0.txt &
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
    "./result_10chains/node216_0_0.txt 90"
    "./result_10chains/node216_0_2.txt 90"
    "./result_10chains/node216_1_0.txt 89"
    "./result_10chains/node216_1_2.txt 89"
    "./result_10chains/node216_2_0.txt 88"
    "./result_10chains/node216_2_2.txt 88"
    "./result_10chains/node216_3_0.txt 87"
    "./result_10chains/node216_3_2.txt 87"
    "./result_10chains/node216_4_0.txt 86"
    "./result_10chains/node216_4_2.txt 86"
    "./result_10chains/node216_5_0.txt 85"
    "./result_10chains/node216_5_2.txt 85"
    "./result_10chains/node216_6_0.txt 84"
    "./result_10chains/node216_6_2.txt 84"
    "./result_10chains/node216_7_0.txt 83"
    "./result_10chains/node216_7_2.txt 83"
    "./result_10chains/node216_8_0.txt 82"
    "./result_10chains/node216_8_2.txt 82"
    "./result_10chains/node216_9_0.txt 81"
    "./result_10chains/node216_9_2.txt 81"
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
