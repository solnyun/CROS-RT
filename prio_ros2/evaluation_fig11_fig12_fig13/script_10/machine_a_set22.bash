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
ros2 run evaluation_3_randomdag uunifast_node -n node22_0_2 -p 48 -st topic22_0_1 -pt None -u 0.011291629636887124 > ./result_10chains/node22_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_1_2 -p 155 -st topic22_1_1 -pt None -u 0.03028878620236919 > ./result_10chains/node22_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_2_2 -p 229 -st topic22_2_1 -pt None -u 0.012208759258095336 > ./result_10chains/node22_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_3_2 -p 354 -st topic22_3_1 -pt None -u 0.001080536304220503 > ./result_10chains/node22_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_4_2 -p 403 -st topic22_4_1 -pt None -u 0.014863996290210901 > ./result_10chains/node22_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_5_2 -p 559 -st topic22_5_1 -pt None -u 0.020333312851876117 > ./result_10chains/node22_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_6_2 -p 597 -st topic22_6_1 -pt None -u 0.0242366008829063 > ./result_10chains/node22_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_7_2 -p 606 -st topic22_7_1 -pt None -u 0.042210748054763964 > ./result_10chains/node22_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_8_2 -p 700 -st topic22_8_1 -pt None -u 0.017484820803378417 > ./result_10chains/node22_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_9_2 -p 730 -st topic22_9_1 -pt None -u 0.03523131600250799 > ./result_10chains/node22_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_0_0 -p 48 -st none -pt topic22_0_0 -u 0.015201914337382771 > ./result_10chains/node22_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_1_0 -p 155 -st none -pt topic22_1_0 -u 0.0020332130226631273 > ./result_10chains/node22_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_2_0 -p 229 -st none -pt topic22_2_0 -u 0.005742982766436255 > ./result_10chains/node22_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_3_0 -p 354 -st none -pt topic22_3_0 -u 0.007128325892002962 > ./result_10chains/node22_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_4_0 -p 403 -st none -pt topic22_4_0 -u 0.011226047388435023 > ./result_10chains/node22_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_5_0 -p 559 -st none -pt topic22_5_0 -u 0.014249171071071487 > ./result_10chains/node22_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_6_0 -p 597 -st none -pt topic22_6_0 -u 0.019368072035476025 > ./result_10chains/node22_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_7_0 -p 606 -st none -pt topic22_7_0 -u 0.0071301995508092075 > ./result_10chains/node22_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_8_0 -p 700 -st none -pt topic22_8_0 -u 0.0003752865824480367 > ./result_10chains/node22_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_9_0 -p 730 -st none -pt topic22_9_0 -u 0.008241901855659622 > ./result_10chains/node22_9_0.txt &
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
    "./result_10chains/node22_0_0.txt 90"
    "./result_10chains/node22_0_2.txt 90"
    "./result_10chains/node22_1_0.txt 89"
    "./result_10chains/node22_1_2.txt 89"
    "./result_10chains/node22_2_0.txt 88"
    "./result_10chains/node22_2_2.txt 88"
    "./result_10chains/node22_3_0.txt 87"
    "./result_10chains/node22_3_2.txt 87"
    "./result_10chains/node22_4_0.txt 86"
    "./result_10chains/node22_4_2.txt 86"
    "./result_10chains/node22_5_0.txt 85"
    "./result_10chains/node22_5_2.txt 85"
    "./result_10chains/node22_6_0.txt 84"
    "./result_10chains/node22_6_2.txt 84"
    "./result_10chains/node22_7_0.txt 83"
    "./result_10chains/node22_7_2.txt 83"
    "./result_10chains/node22_8_0.txt 82"
    "./result_10chains/node22_8_2.txt 82"
    "./result_10chains/node22_9_0.txt 81"
    "./result_10chains/node22_9_2.txt 81"
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
