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
ros2 run evaluation_3_randomdag uunifast_node -n node21_0_2 -p 327 -st topic21_0_1 -pt None -u 0.012702172514412469 > ./result_8chains/node21_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_1_2 -p 375 -st topic21_1_1 -pt None -u 0.038418929967636795 > ./result_8chains/node21_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_2_2 -p 402 -st topic21_2_1 -pt None -u 0.005064162770141323 > ./result_8chains/node21_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_3_2 -p 827 -st topic21_3_1 -pt None -u 0.011613646732219929 > ./result_8chains/node21_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_4_2 -p 844 -st topic21_4_1 -pt None -u 0.01934909497236481 > ./result_8chains/node21_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_5_2 -p 868 -st topic21_5_1 -pt None -u 0.04825162995484861 > ./result_8chains/node21_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_6_2 -p 872 -st topic21_6_1 -pt None -u 0.04944110724189635 > ./result_8chains/node21_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_7_2 -p 898 -st topic21_7_1 -pt None -u 0.04098662079617036 > ./result_8chains/node21_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_0_0 -p 327 -st none -pt topic21_0_0 -u 0.00259352900990667 > ./result_8chains/node21_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_1_0 -p 375 -st none -pt topic21_1_0 -u 0.002468694607150046 > ./result_8chains/node21_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_2_0 -p 402 -st none -pt topic21_2_0 -u 0.007271965117144008 > ./result_8chains/node21_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_3_0 -p 827 -st none -pt topic21_3_0 -u 0.011511946091256609 > ./result_8chains/node21_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_4_0 -p 844 -st none -pt topic21_4_0 -u 0.029713752471994925 > ./result_8chains/node21_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_5_0 -p 868 -st none -pt topic21_5_0 -u 0.00638712451376694 > ./result_8chains/node21_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node21_6_0 -p 872 -st none -pt topic21_6_0 -u 0.002452238963684461 > ./result_8chains/node21_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node21_7_0 -p 898 -st none -pt topic21_7_0 -u 0.07046276503201031 > ./result_8chains/node21_7_0.txt &
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
    "./result_8chains/node21_0_0.txt 90"
    "./result_8chains/node21_0_2.txt 90"
    "./result_8chains/node21_1_0.txt 89"
    "./result_8chains/node21_1_2.txt 89"
    "./result_8chains/node21_2_0.txt 88"
    "./result_8chains/node21_2_2.txt 88"
    "./result_8chains/node21_3_0.txt 87"
    "./result_8chains/node21_3_2.txt 87"
    "./result_8chains/node21_4_0.txt 86"
    "./result_8chains/node21_4_2.txt 86"
    "./result_8chains/node21_5_0.txt 85"
    "./result_8chains/node21_5_2.txt 85"
    "./result_8chains/node21_6_0.txt 84"
    "./result_8chains/node21_6_2.txt 84"
    "./result_8chains/node21_7_0.txt 83"
    "./result_8chains/node21_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
