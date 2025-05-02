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
ros2 run evaluation_3_randomdag uunifast_node -n node244_0_2 -p 22 -st topic244_0_1 -pt None -u 0.01136015161234033 > ./result_10chains/node244_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_1_2 -p 59 -st topic244_1_1 -pt None -u 0.005913111767603507 > ./result_10chains/node244_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_2_2 -p 538 -st topic244_2_1 -pt None -u 0.03512825488893345 > ./result_10chains/node244_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_3_2 -p 589 -st topic244_3_1 -pt None -u 0.03590173046207462 > ./result_10chains/node244_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_4_2 -p 599 -st topic244_4_1 -pt None -u 0.0042866750341935544 > ./result_10chains/node244_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_5_2 -p 631 -st topic244_5_1 -pt None -u 0.0027816738479363445 > ./result_10chains/node244_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_6_2 -p 650 -st topic244_6_1 -pt None -u 0.0014287082879565483 > ./result_10chains/node244_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_7_2 -p 830 -st topic244_7_1 -pt None -u 0.00321549110153882 > ./result_10chains/node244_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_8_2 -p 841 -st topic244_8_1 -pt None -u 0.0075656861725205485 > ./result_10chains/node244_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_9_2 -p 871 -st topic244_9_1 -pt None -u 0.01307178950767921 > ./result_10chains/node244_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_0_0 -p 22 -st none -pt topic244_0_0 -u 0.01668480220625934 > ./result_10chains/node244_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_1_0 -p 59 -st none -pt topic244_1_0 -u 0.004902106654027905 > ./result_10chains/node244_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_2_0 -p 538 -st none -pt topic244_2_0 -u 0.021559707993814126 > ./result_10chains/node244_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_3_0 -p 589 -st none -pt topic244_3_0 -u 0.0006888673580291993 > ./result_10chains/node244_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_4_0 -p 599 -st none -pt topic244_4_0 -u 0.012197797487848494 > ./result_10chains/node244_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_5_0 -p 631 -st none -pt topic244_5_0 -u 0.026357356644709895 > ./result_10chains/node244_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_6_0 -p 650 -st none -pt topic244_6_0 -u 0.01546887847197756 > ./result_10chains/node244_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_7_0 -p 830 -st none -pt topic244_7_0 -u 0.014967163843174008 > ./result_10chains/node244_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_8_0 -p 841 -st none -pt topic244_8_0 -u 0.031998729405137066 > ./result_10chains/node244_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_9_0 -p 871 -st none -pt topic244_9_0 -u 0.007063971233001121 > ./result_10chains/node244_9_0.txt &
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
    "./result_10chains/node244_0_0.txt 90"
    "./result_10chains/node244_0_2.txt 90"
    "./result_10chains/node244_1_0.txt 89"
    "./result_10chains/node244_1_2.txt 89"
    "./result_10chains/node244_2_0.txt 88"
    "./result_10chains/node244_2_2.txt 88"
    "./result_10chains/node244_3_0.txt 87"
    "./result_10chains/node244_3_2.txt 87"
    "./result_10chains/node244_4_0.txt 86"
    "./result_10chains/node244_4_2.txt 86"
    "./result_10chains/node244_5_0.txt 85"
    "./result_10chains/node244_5_2.txt 85"
    "./result_10chains/node244_6_0.txt 84"
    "./result_10chains/node244_6_2.txt 84"
    "./result_10chains/node244_7_0.txt 83"
    "./result_10chains/node244_7_2.txt 83"
    "./result_10chains/node244_8_0.txt 82"
    "./result_10chains/node244_8_2.txt 82"
    "./result_10chains/node244_9_0.txt 81"
    "./result_10chains/node244_9_2.txt 81"
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
