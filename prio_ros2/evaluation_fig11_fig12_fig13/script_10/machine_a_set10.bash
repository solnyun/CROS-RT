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
ros2 run evaluation_3_randomdag uunifast_node -n node10_0_2 -p 10 -st topic10_0_1 -pt None -u 0.002177871438020118 > ./result_10chains/node10_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_1_2 -p 73 -st topic10_1_1 -pt None -u 0.009147453842116182 > ./result_10chains/node10_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_2_2 -p 255 -st topic10_2_1 -pt None -u 0.004400483711293091 > ./result_10chains/node10_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_3_2 -p 292 -st topic10_3_1 -pt None -u 0.09083972368053889 > ./result_10chains/node10_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_4_2 -p 506 -st topic10_4_1 -pt None -u 0.001065588116151095 > ./result_10chains/node10_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_5_2 -p 510 -st topic10_5_1 -pt None -u 0.011540328457253168 > ./result_10chains/node10_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_6_2 -p 550 -st topic10_6_1 -pt None -u 0.014722286178380728 > ./result_10chains/node10_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_7_2 -p 595 -st topic10_7_1 -pt None -u 0.01611355980351778 > ./result_10chains/node10_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_8_2 -p 610 -st topic10_8_1 -pt None -u 0.009366784977452268 > ./result_10chains/node10_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_9_2 -p 749 -st topic10_9_1 -pt None -u 0.006219342926060559 > ./result_10chains/node10_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_0_0 -p 10 -st none -pt topic10_0_0 -u 0.01469044581409279 > ./result_10chains/node10_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_1_0 -p 73 -st none -pt topic10_1_0 -u 0.006957563875209072 > ./result_10chains/node10_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_2_0 -p 255 -st none -pt topic10_2_0 -u 0.049348827783389004 > ./result_10chains/node10_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_3_0 -p 292 -st none -pt topic10_3_0 -u 0.014961751904533527 > ./result_10chains/node10_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_4_0 -p 506 -st none -pt topic10_4_0 -u 0.009678237589039212 > ./result_10chains/node10_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_5_0 -p 510 -st none -pt topic10_5_0 -u 0.01066803614519407 > ./result_10chains/node10_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_6_0 -p 550 -st none -pt topic10_6_0 -u 0.011967288565527673 > ./result_10chains/node10_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_7_0 -p 595 -st none -pt topic10_7_0 -u 0.02581486706129793 > ./result_10chains/node10_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_8_0 -p 610 -st none -pt topic10_8_0 -u 0.00745475016079028 > ./result_10chains/node10_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_9_0 -p 749 -st none -pt topic10_9_0 -u 0.0056866639177987795 > ./result_10chains/node10_9_0.txt &
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
    "./result_10chains/node10_0_0.txt 90"
    "./result_10chains/node10_0_2.txt 90"
    "./result_10chains/node10_1_0.txt 89"
    "./result_10chains/node10_1_2.txt 89"
    "./result_10chains/node10_2_0.txt 88"
    "./result_10chains/node10_2_2.txt 88"
    "./result_10chains/node10_3_0.txt 87"
    "./result_10chains/node10_3_2.txt 87"
    "./result_10chains/node10_4_0.txt 86"
    "./result_10chains/node10_4_2.txt 86"
    "./result_10chains/node10_5_0.txt 85"
    "./result_10chains/node10_5_2.txt 85"
    "./result_10chains/node10_6_0.txt 84"
    "./result_10chains/node10_6_2.txt 84"
    "./result_10chains/node10_7_0.txt 83"
    "./result_10chains/node10_7_2.txt 83"
    "./result_10chains/node10_8_0.txt 82"
    "./result_10chains/node10_8_2.txt 82"
    "./result_10chains/node10_9_0.txt 81"
    "./result_10chains/node10_9_2.txt 81"
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
