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
ros2 run evaluation_3_randomdag uunifast_node -n node200_0_2 -p 69 -st topic200_0_1 -pt None -u 0.013854931529178716 > ./result_10chains/node200_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_1_2 -p 74 -st topic200_1_1 -pt None -u 0.006005863106806952 > ./result_10chains/node200_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_2_2 -p 97 -st topic200_2_1 -pt None -u 0.008389322842453084 > ./result_10chains/node200_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_3_2 -p 113 -st topic200_3_1 -pt None -u 0.006019907571355787 > ./result_10chains/node200_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_4_2 -p 386 -st topic200_4_1 -pt None -u 0.03683506030831668 > ./result_10chains/node200_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_5_2 -p 441 -st topic200_5_1 -pt None -u 0.031300276509109104 > ./result_10chains/node200_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_6_2 -p 540 -st topic200_6_1 -pt None -u 0.004369981523515559 > ./result_10chains/node200_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_7_2 -p 553 -st topic200_7_1 -pt None -u 0.07013677772494975 > ./result_10chains/node200_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_8_2 -p 916 -st topic200_8_1 -pt None -u 0.0022096536866170885 > ./result_10chains/node200_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_9_2 -p 974 -st topic200_9_1 -pt None -u 0.0005158679033925298 > ./result_10chains/node200_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_0_0 -p 69 -st none -pt topic200_0_0 -u 0.0037965779555610424 > ./result_10chains/node200_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_1_0 -p 74 -st none -pt topic200_1_0 -u 0.015770875181761124 > ./result_10chains/node200_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_2_0 -p 97 -st none -pt topic200_2_0 -u 0.018320179951550164 > ./result_10chains/node200_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_3_0 -p 113 -st none -pt topic200_3_0 -u 0.0028127672004777393 > ./result_10chains/node200_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_4_0 -p 386 -st none -pt topic200_4_0 -u 0.029070354067051274 > ./result_10chains/node200_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_5_0 -p 441 -st none -pt topic200_5_0 -u 0.009481834447144594 > ./result_10chains/node200_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_6_0 -p 540 -st none -pt topic200_6_0 -u 0.008398809883837927 > ./result_10chains/node200_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_7_0 -p 553 -st none -pt topic200_7_0 -u 0.005939492615761294 > ./result_10chains/node200_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_8_0 -p 916 -st none -pt topic200_8_0 -u 0.02497044147205757 > ./result_10chains/node200_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_9_0 -p 974 -st none -pt topic200_9_0 -u 0.0008833163194375479 > ./result_10chains/node200_9_0.txt &
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
    "./result_10chains/node200_0_0.txt 90"
    "./result_10chains/node200_0_2.txt 90"
    "./result_10chains/node200_1_0.txt 89"
    "./result_10chains/node200_1_2.txt 89"
    "./result_10chains/node200_2_0.txt 88"
    "./result_10chains/node200_2_2.txt 88"
    "./result_10chains/node200_3_0.txt 87"
    "./result_10chains/node200_3_2.txt 87"
    "./result_10chains/node200_4_0.txt 86"
    "./result_10chains/node200_4_2.txt 86"
    "./result_10chains/node200_5_0.txt 85"
    "./result_10chains/node200_5_2.txt 85"
    "./result_10chains/node200_6_0.txt 84"
    "./result_10chains/node200_6_2.txt 84"
    "./result_10chains/node200_7_0.txt 83"
    "./result_10chains/node200_7_2.txt 83"
    "./result_10chains/node200_8_0.txt 82"
    "./result_10chains/node200_8_2.txt 82"
    "./result_10chains/node200_9_0.txt 81"
    "./result_10chains/node200_9_2.txt 81"
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
