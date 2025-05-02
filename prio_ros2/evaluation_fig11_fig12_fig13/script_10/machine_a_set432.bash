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
ros2 run evaluation_3_randomdag uunifast_node -n node432_0_2 -p 24 -st topic432_0_1 -pt None -u 0.04031250657378255 > ./result_10chains/node432_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_1_2 -p 116 -st topic432_1_1 -pt None -u 0.00886935751692669 > ./result_10chains/node432_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_2_2 -p 154 -st topic432_2_1 -pt None -u 0.00504362055976193 > ./result_10chains/node432_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_3_2 -p 477 -st topic432_3_1 -pt None -u 0.0025543268336187253 > ./result_10chains/node432_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_4_2 -p 493 -st topic432_4_1 -pt None -u 0.032614138324254804 > ./result_10chains/node432_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_5_2 -p 502 -st topic432_5_1 -pt None -u 0.016349054057081064 > ./result_10chains/node432_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_6_2 -p 604 -st topic432_6_1 -pt None -u 0.011303361745280821 > ./result_10chains/node432_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_7_2 -p 731 -st topic432_7_1 -pt None -u 0.03632739291039012 > ./result_10chains/node432_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_8_2 -p 880 -st topic432_8_1 -pt None -u 0.0017072436781731745 > ./result_10chains/node432_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_9_2 -p 999 -st topic432_9_1 -pt None -u 0.009282741052478621 > ./result_10chains/node432_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_0_0 -p 24 -st none -pt topic432_0_0 -u 0.0026145666104689935 > ./result_10chains/node432_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_1_0 -p 116 -st none -pt topic432_1_0 -u 0.007927893391162621 > ./result_10chains/node432_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_2_0 -p 154 -st none -pt topic432_2_0 -u 0.005077610300854352 > ./result_10chains/node432_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_3_0 -p 477 -st none -pt topic432_3_0 -u 0.05400448979148781 > ./result_10chains/node432_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_4_0 -p 493 -st none -pt topic432_4_0 -u 0.008193488810014471 > ./result_10chains/node432_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_5_0 -p 502 -st none -pt topic432_5_0 -u 0.008148481185050849 > ./result_10chains/node432_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_6_0 -p 604 -st none -pt topic432_6_0 -u 0.016686718696523217 > ./result_10chains/node432_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_7_0 -p 731 -st none -pt topic432_7_0 -u 0.050663340409751456 > ./result_10chains/node432_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_8_0 -p 880 -st none -pt topic432_8_0 -u 0.015493236971374877 > ./result_10chains/node432_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_9_0 -p 999 -st none -pt topic432_9_0 -u 0.013637934872399112 > ./result_10chains/node432_9_0.txt &
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
    "./result_10chains/node432_0_0.txt 90"
    "./result_10chains/node432_0_2.txt 90"
    "./result_10chains/node432_1_0.txt 89"
    "./result_10chains/node432_1_2.txt 89"
    "./result_10chains/node432_2_0.txt 88"
    "./result_10chains/node432_2_2.txt 88"
    "./result_10chains/node432_3_0.txt 87"
    "./result_10chains/node432_3_2.txt 87"
    "./result_10chains/node432_4_0.txt 86"
    "./result_10chains/node432_4_2.txt 86"
    "./result_10chains/node432_5_0.txt 85"
    "./result_10chains/node432_5_2.txt 85"
    "./result_10chains/node432_6_0.txt 84"
    "./result_10chains/node432_6_2.txt 84"
    "./result_10chains/node432_7_0.txt 83"
    "./result_10chains/node432_7_2.txt 83"
    "./result_10chains/node432_8_0.txt 82"
    "./result_10chains/node432_8_2.txt 82"
    "./result_10chains/node432_9_0.txt 81"
    "./result_10chains/node432_9_2.txt 81"
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
