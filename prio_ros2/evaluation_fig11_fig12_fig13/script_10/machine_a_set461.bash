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
ros2 run evaluation_3_randomdag uunifast_node -n node461_0_2 -p 168 -st topic461_0_1 -pt None -u 0.012100135708867477 > ./result_10chains/node461_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_1_2 -p 345 -st topic461_1_1 -pt None -u 0.015421291650982827 > ./result_10chains/node461_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_2_2 -p 483 -st topic461_2_1 -pt None -u 0.01973493808882737 > ./result_10chains/node461_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_3_2 -p 509 -st topic461_3_1 -pt None -u 0.043529940911745446 > ./result_10chains/node461_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_4_2 -p 833 -st topic461_4_1 -pt None -u 0.029355459960907437 > ./result_10chains/node461_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_5_2 -p 847 -st topic461_5_1 -pt None -u 0.015650737684080818 > ./result_10chains/node461_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_6_2 -p 895 -st topic461_6_1 -pt None -u 0.019595417714184202 > ./result_10chains/node461_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_7_2 -p 899 -st topic461_7_1 -pt None -u 0.0018519417450678088 > ./result_10chains/node461_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_8_2 -p 961 -st topic461_8_1 -pt None -u 0.011772046794131734 > ./result_10chains/node461_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_9_2 -p 973 -st topic461_9_1 -pt None -u 0.027530344659393188 > ./result_10chains/node461_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_0_0 -p 168 -st none -pt topic461_0_0 -u 0.0019698801715995473 > ./result_10chains/node461_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_1_0 -p 345 -st none -pt topic461_1_0 -u 0.02388857011738882 > ./result_10chains/node461_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_2_0 -p 483 -st none -pt topic461_2_0 -u 0.026741614363678445 > ./result_10chains/node461_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_3_0 -p 509 -st none -pt topic461_3_0 -u 0.02029039007091543 > ./result_10chains/node461_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_4_0 -p 833 -st none -pt topic461_4_0 -u 0.0101671452877245 > ./result_10chains/node461_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_5_0 -p 847 -st none -pt topic461_5_0 -u 0.03695493057939919 > ./result_10chains/node461_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_6_0 -p 895 -st none -pt topic461_6_0 -u 0.0018330454225525539 > ./result_10chains/node461_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_7_0 -p 899 -st none -pt topic461_7_0 -u 0.020906107339656033 > ./result_10chains/node461_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_8_0 -p 961 -st none -pt topic461_8_0 -u 0.007066991540220363 > ./result_10chains/node461_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_9_0 -p 973 -st none -pt topic461_9_0 -u 0.0058981788098243955 > ./result_10chains/node461_9_0.txt &
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
    "./result_10chains/node461_0_0.txt 90"
    "./result_10chains/node461_0_2.txt 90"
    "./result_10chains/node461_1_0.txt 89"
    "./result_10chains/node461_1_2.txt 89"
    "./result_10chains/node461_2_0.txt 88"
    "./result_10chains/node461_2_2.txt 88"
    "./result_10chains/node461_3_0.txt 87"
    "./result_10chains/node461_3_2.txt 87"
    "./result_10chains/node461_4_0.txt 86"
    "./result_10chains/node461_4_2.txt 86"
    "./result_10chains/node461_5_0.txt 85"
    "./result_10chains/node461_5_2.txt 85"
    "./result_10chains/node461_6_0.txt 84"
    "./result_10chains/node461_6_2.txt 84"
    "./result_10chains/node461_7_0.txt 83"
    "./result_10chains/node461_7_2.txt 83"
    "./result_10chains/node461_8_0.txt 82"
    "./result_10chains/node461_8_2.txt 82"
    "./result_10chains/node461_9_0.txt 81"
    "./result_10chains/node461_9_2.txt 81"
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
