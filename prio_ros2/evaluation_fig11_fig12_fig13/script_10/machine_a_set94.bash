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
ros2 run evaluation_3_randomdag uunifast_node -n node94_0_2 -p 519 -st topic94_0_1 -pt None -u 0.0013144308399025695 > ./result_10chains/node94_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_1_2 -p 579 -st topic94_1_1 -pt None -u 0.08520123601718049 > ./result_10chains/node94_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_2_2 -p 582 -st topic94_2_1 -pt None -u 0.0042005529601235325 > ./result_10chains/node94_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_3_2 -p 643 -st topic94_3_1 -pt None -u 0.008225334554452568 > ./result_10chains/node94_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_4_2 -p 684 -st topic94_4_1 -pt None -u 0.0017232458687212737 > ./result_10chains/node94_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_5_2 -p 734 -st topic94_5_1 -pt None -u 0.028788060110989666 > ./result_10chains/node94_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_6_2 -p 767 -st topic94_6_1 -pt None -u 0.015354268853378886 > ./result_10chains/node94_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_7_2 -p 791 -st topic94_7_1 -pt None -u 0.03013853016365986 > ./result_10chains/node94_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_8_2 -p 822 -st topic94_8_1 -pt None -u 0.012886488510304203 > ./result_10chains/node94_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_9_2 -p 948 -st topic94_9_1 -pt None -u 0.0022494357035522366 > ./result_10chains/node94_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_0_0 -p 519 -st none -pt topic94_0_0 -u 0.021323157339946386 > ./result_10chains/node94_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_1_0 -p 579 -st none -pt topic94_1_0 -u 0.003533969678547133 > ./result_10chains/node94_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_2_0 -p 582 -st none -pt topic94_2_0 -u 0.01167863237550043 > ./result_10chains/node94_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_3_0 -p 643 -st none -pt topic94_3_0 -u 0.002506690767066805 > ./result_10chains/node94_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_4_0 -p 684 -st none -pt topic94_4_0 -u 0.009168059337910955 > ./result_10chains/node94_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_5_0 -p 734 -st none -pt topic94_5_0 -u 0.011823770884097501 > ./result_10chains/node94_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_6_0 -p 767 -st none -pt topic94_6_0 -u 0.017311042954378797 > ./result_10chains/node94_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_7_0 -p 791 -st none -pt topic94_7_0 -u 0.0037497125127063657 > ./result_10chains/node94_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_8_0 -p 822 -st none -pt topic94_8_0 -u 0.014966012304627366 > ./result_10chains/node94_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_9_0 -p 948 -st none -pt topic94_9_0 -u 0.0026351668582273897 > ./result_10chains/node94_9_0.txt &
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
    "./result_10chains/node94_0_0.txt 90"
    "./result_10chains/node94_0_2.txt 90"
    "./result_10chains/node94_1_0.txt 89"
    "./result_10chains/node94_1_2.txt 89"
    "./result_10chains/node94_2_0.txt 88"
    "./result_10chains/node94_2_2.txt 88"
    "./result_10chains/node94_3_0.txt 87"
    "./result_10chains/node94_3_2.txt 87"
    "./result_10chains/node94_4_0.txt 86"
    "./result_10chains/node94_4_2.txt 86"
    "./result_10chains/node94_5_0.txt 85"
    "./result_10chains/node94_5_2.txt 85"
    "./result_10chains/node94_6_0.txt 84"
    "./result_10chains/node94_6_2.txt 84"
    "./result_10chains/node94_7_0.txt 83"
    "./result_10chains/node94_7_2.txt 83"
    "./result_10chains/node94_8_0.txt 82"
    "./result_10chains/node94_8_2.txt 82"
    "./result_10chains/node94_9_0.txt 81"
    "./result_10chains/node94_9_2.txt 81"
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
