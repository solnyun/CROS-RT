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
ros2 run evaluation_3_randomdag uunifast_node -n node118_0_2 -p 84 -st topic118_0_1 -pt None -u 0.0019154323694792752 > ./result_10chains/node118_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_1_2 -p 151 -st topic118_1_1 -pt None -u 0.0039482157275256835 > ./result_10chains/node118_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_2_2 -p 156 -st topic118_2_1 -pt None -u 0.023911890979334383 > ./result_10chains/node118_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_3_2 -p 318 -st topic118_3_1 -pt None -u 0.013213068100476177 > ./result_10chains/node118_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_4_2 -p 410 -st topic118_4_1 -pt None -u 0.013992765279756514 > ./result_10chains/node118_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_5_2 -p 677 -st topic118_5_1 -pt None -u 0.016664077160201685 > ./result_10chains/node118_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_6_2 -p 723 -st topic118_6_1 -pt None -u 0.027447792880308713 > ./result_10chains/node118_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_7_2 -p 769 -st topic118_7_1 -pt None -u 0.0067193238187114035 > ./result_10chains/node118_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_8_2 -p 883 -st topic118_8_1 -pt None -u 0.07198840997313745 > ./result_10chains/node118_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_9_2 -p 985 -st topic118_9_1 -pt None -u 0.010412532739993539 > ./result_10chains/node118_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_0_0 -p 84 -st none -pt topic118_0_0 -u 0.006035315507867511 > ./result_10chains/node118_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_1_0 -p 151 -st none -pt topic118_1_0 -u 0.03406480012985108 > ./result_10chains/node118_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_2_0 -p 156 -st none -pt topic118_2_0 -u 0.00012814512224895713 > ./result_10chains/node118_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_3_0 -p 318 -st none -pt topic118_3_0 -u 0.024289332541919673 > ./result_10chains/node118_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_4_0 -p 410 -st none -pt topic118_4_0 -u 0.004229990411423801 > ./result_10chains/node118_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_5_0 -p 677 -st none -pt topic118_5_0 -u 0.036819553123433546 > ./result_10chains/node118_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_6_0 -p 723 -st none -pt topic118_6_0 -u 0.00245510015365058 > ./result_10chains/node118_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_7_0 -p 769 -st none -pt topic118_7_0 -u 0.01773138578329317 > ./result_10chains/node118_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_8_0 -p 883 -st none -pt topic118_8_0 -u 0.015381418608955214 > ./result_10chains/node118_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_9_0 -p 985 -st none -pt topic118_9_0 -u 0.0018599120407120986 > ./result_10chains/node118_9_0.txt &
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
    "./result_10chains/node118_0_0.txt 90"
    "./result_10chains/node118_0_2.txt 90"
    "./result_10chains/node118_1_0.txt 89"
    "./result_10chains/node118_1_2.txt 89"
    "./result_10chains/node118_2_0.txt 88"
    "./result_10chains/node118_2_2.txt 88"
    "./result_10chains/node118_3_0.txt 87"
    "./result_10chains/node118_3_2.txt 87"
    "./result_10chains/node118_4_0.txt 86"
    "./result_10chains/node118_4_2.txt 86"
    "./result_10chains/node118_5_0.txt 85"
    "./result_10chains/node118_5_2.txt 85"
    "./result_10chains/node118_6_0.txt 84"
    "./result_10chains/node118_6_2.txt 84"
    "./result_10chains/node118_7_0.txt 83"
    "./result_10chains/node118_7_2.txt 83"
    "./result_10chains/node118_8_0.txt 82"
    "./result_10chains/node118_8_2.txt 82"
    "./result_10chains/node118_9_0.txt 81"
    "./result_10chains/node118_9_2.txt 81"
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
