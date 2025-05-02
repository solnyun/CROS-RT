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
ros2 run evaluation_3_randomdag uunifast_node -n node90_0_2 -p 25 -st topic90_0_1 -pt None -u 0.00045069865204633297 > ./result_10chains/node90_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_1_2 -p 49 -st topic90_1_1 -pt None -u 0.03031071221344317 > ./result_10chains/node90_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_2_2 -p 65 -st topic90_2_1 -pt None -u 0.0055404131175395 > ./result_10chains/node90_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_3_2 -p 245 -st topic90_3_1 -pt None -u 0.0005465671698145491 > ./result_10chains/node90_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_4_2 -p 272 -st topic90_4_1 -pt None -u 0.035873010010318174 > ./result_10chains/node90_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_5_2 -p 612 -st topic90_5_1 -pt None -u 0.008381284210408124 > ./result_10chains/node90_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_6_2 -p 665 -st topic90_6_1 -pt None -u 0.01720370729405915 > ./result_10chains/node90_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_7_2 -p 767 -st topic90_7_1 -pt None -u 0.05499506985904598 > ./result_10chains/node90_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_8_2 -p 821 -st topic90_8_1 -pt None -u 0.007197134615760034 > ./result_10chains/node90_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_9_2 -p 941 -st topic90_9_1 -pt None -u 0.011591540793985259 > ./result_10chains/node90_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_0_0 -p 25 -st none -pt topic90_0_0 -u 0.007129758501580097 > ./result_10chains/node90_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_1_0 -p 49 -st none -pt topic90_1_0 -u 0.002068855757245025 > ./result_10chains/node90_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_2_0 -p 65 -st none -pt topic90_2_0 -u 0.0034296289340656205 > ./result_10chains/node90_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_3_0 -p 245 -st none -pt topic90_3_0 -u 0.00576084324888676 > ./result_10chains/node90_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_4_0 -p 272 -st none -pt topic90_4_0 -u 0.04343601035007166 > ./result_10chains/node90_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_5_0 -p 612 -st none -pt topic90_5_0 -u 0.013688380522681898 > ./result_10chains/node90_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_6_0 -p 665 -st none -pt topic90_6_0 -u 0.024353052160412947 > ./result_10chains/node90_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_7_0 -p 767 -st none -pt topic90_7_0 -u 0.013611309350268802 > ./result_10chains/node90_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_8_0 -p 821 -st none -pt topic90_8_0 -u 0.017909961946472888 > ./result_10chains/node90_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_9_0 -p 941 -st none -pt topic90_9_0 -u 0.023521202832063753 > ./result_10chains/node90_9_0.txt &
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
    "./result_10chains/node90_0_0.txt 90"
    "./result_10chains/node90_0_2.txt 90"
    "./result_10chains/node90_1_0.txt 89"
    "./result_10chains/node90_1_2.txt 89"
    "./result_10chains/node90_2_0.txt 88"
    "./result_10chains/node90_2_2.txt 88"
    "./result_10chains/node90_3_0.txt 87"
    "./result_10chains/node90_3_2.txt 87"
    "./result_10chains/node90_4_0.txt 86"
    "./result_10chains/node90_4_2.txt 86"
    "./result_10chains/node90_5_0.txt 85"
    "./result_10chains/node90_5_2.txt 85"
    "./result_10chains/node90_6_0.txt 84"
    "./result_10chains/node90_6_2.txt 84"
    "./result_10chains/node90_7_0.txt 83"
    "./result_10chains/node90_7_2.txt 83"
    "./result_10chains/node90_8_0.txt 82"
    "./result_10chains/node90_8_2.txt 82"
    "./result_10chains/node90_9_0.txt 81"
    "./result_10chains/node90_9_2.txt 81"
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
