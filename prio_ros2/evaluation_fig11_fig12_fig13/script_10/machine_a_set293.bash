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
ros2 run evaluation_3_randomdag uunifast_node -n node293_0_2 -p 147 -st topic293_0_1 -pt None -u 0.0010417051817291911 > ./result_10chains/node293_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_1_2 -p 235 -st topic293_1_1 -pt None -u 0.00442252663108994 > ./result_10chains/node293_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_2_2 -p 296 -st topic293_2_1 -pt None -u 0.030737756603232802 > ./result_10chains/node293_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_3_2 -p 395 -st topic293_3_1 -pt None -u 0.011663137116613875 > ./result_10chains/node293_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_4_2 -p 413 -st topic293_4_1 -pt None -u 0.0922073032690075 > ./result_10chains/node293_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_5_2 -p 499 -st topic293_5_1 -pt None -u 0.012507548134480906 > ./result_10chains/node293_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_6_2 -p 539 -st topic293_6_1 -pt None -u 0.0006460623027703949 > ./result_10chains/node293_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_7_2 -p 580 -st topic293_7_1 -pt None -u 0.035033593241084085 > ./result_10chains/node293_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_8_2 -p 687 -st topic293_8_1 -pt None -u 0.015199303428431864 > ./result_10chains/node293_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_9_2 -p 847 -st topic293_9_1 -pt None -u 0.015799967941394454 > ./result_10chains/node293_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_0_0 -p 147 -st none -pt topic293_0_0 -u 0.009311815449614569 > ./result_10chains/node293_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_1_0 -p 235 -st none -pt topic293_1_0 -u 0.013707233812510378 > ./result_10chains/node293_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_2_0 -p 296 -st none -pt topic293_2_0 -u 0.017912014713287128 > ./result_10chains/node293_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_3_0 -p 395 -st none -pt topic293_3_0 -u 0.02333718650858546 > ./result_10chains/node293_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_4_0 -p 413 -st none -pt topic293_4_0 -u 0.004665353672881234 > ./result_10chains/node293_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_5_0 -p 499 -st none -pt topic293_5_0 -u 0.022383256672348723 > ./result_10chains/node293_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_6_0 -p 539 -st none -pt topic293_6_0 -u 0.007047791498599298 > ./result_10chains/node293_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_7_0 -p 580 -st none -pt topic293_7_0 -u 0.003936268118165276 > ./result_10chains/node293_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_8_0 -p 687 -st none -pt topic293_8_0 -u 0.034963863935882536 > ./result_10chains/node293_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_9_0 -p 847 -st none -pt topic293_9_0 -u 0.028538521336728725 > ./result_10chains/node293_9_0.txt &
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
    "./result_10chains/node293_0_0.txt 90"
    "./result_10chains/node293_0_2.txt 90"
    "./result_10chains/node293_1_0.txt 89"
    "./result_10chains/node293_1_2.txt 89"
    "./result_10chains/node293_2_0.txt 88"
    "./result_10chains/node293_2_2.txt 88"
    "./result_10chains/node293_3_0.txt 87"
    "./result_10chains/node293_3_2.txt 87"
    "./result_10chains/node293_4_0.txt 86"
    "./result_10chains/node293_4_2.txt 86"
    "./result_10chains/node293_5_0.txt 85"
    "./result_10chains/node293_5_2.txt 85"
    "./result_10chains/node293_6_0.txt 84"
    "./result_10chains/node293_6_2.txt 84"
    "./result_10chains/node293_7_0.txt 83"
    "./result_10chains/node293_7_2.txt 83"
    "./result_10chains/node293_8_0.txt 82"
    "./result_10chains/node293_8_2.txt 82"
    "./result_10chains/node293_9_0.txt 81"
    "./result_10chains/node293_9_2.txt 81"
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
