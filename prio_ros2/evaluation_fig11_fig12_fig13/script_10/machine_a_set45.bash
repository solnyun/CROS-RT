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
ros2 run evaluation_3_randomdag uunifast_node -n node45_0_2 -p 27 -st topic45_0_1 -pt None -u 0.019579328439692845 > ./result_10chains/node45_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_1_2 -p 114 -st topic45_1_1 -pt None -u 0.007408331308749072 > ./result_10chains/node45_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_2_2 -p 153 -st topic45_2_1 -pt None -u 0.03164436042114016 > ./result_10chains/node45_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_3_2 -p 306 -st topic45_3_1 -pt None -u 0.009495141496742965 > ./result_10chains/node45_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_4_2 -p 357 -st topic45_4_1 -pt None -u 0.0045230391065696485 > ./result_10chains/node45_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_5_2 -p 366 -st topic45_5_1 -pt None -u 0.11411380550974634 > ./result_10chains/node45_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_6_2 -p 421 -st topic45_6_1 -pt None -u 0.00421930982366181 > ./result_10chains/node45_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_7_2 -p 804 -st topic45_7_1 -pt None -u 0.018231347753238633 > ./result_10chains/node45_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_8_2 -p 941 -st topic45_8_1 -pt None -u 0.006232203914837375 > ./result_10chains/node45_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_9_2 -p 949 -st topic45_9_1 -pt None -u 0.006378918859781292 > ./result_10chains/node45_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_0_0 -p 27 -st none -pt topic45_0_0 -u 0.0030301430372537963 > ./result_10chains/node45_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_1_0 -p 114 -st none -pt topic45_1_0 -u 0.008923821455636305 > ./result_10chains/node45_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_2_0 -p 153 -st none -pt topic45_2_0 -u 0.029818421943025697 > ./result_10chains/node45_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_3_0 -p 306 -st none -pt topic45_3_0 -u 0.0037818428581305463 > ./result_10chains/node45_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_4_0 -p 357 -st none -pt topic45_4_0 -u 0.0014057257641222898 > ./result_10chains/node45_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_5_0 -p 366 -st none -pt topic45_5_0 -u 0.010158246399003368 > ./result_10chains/node45_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_6_0 -p 421 -st none -pt topic45_6_0 -u 0.025961354198953707 > ./result_10chains/node45_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_7_0 -p 804 -st none -pt topic45_7_0 -u 0.005215680941499601 > ./result_10chains/node45_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_8_0 -p 941 -st none -pt topic45_8_0 -u 0.010752724481653812 > ./result_10chains/node45_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_9_0 -p 949 -st none -pt topic45_9_0 -u 0.0032521506987037135 > ./result_10chains/node45_9_0.txt &
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
    "./result_10chains/node45_0_0.txt 90"
    "./result_10chains/node45_0_2.txt 90"
    "./result_10chains/node45_1_0.txt 89"
    "./result_10chains/node45_1_2.txt 89"
    "./result_10chains/node45_2_0.txt 88"
    "./result_10chains/node45_2_2.txt 88"
    "./result_10chains/node45_3_0.txt 87"
    "./result_10chains/node45_3_2.txt 87"
    "./result_10chains/node45_4_0.txt 86"
    "./result_10chains/node45_4_2.txt 86"
    "./result_10chains/node45_5_0.txt 85"
    "./result_10chains/node45_5_2.txt 85"
    "./result_10chains/node45_6_0.txt 84"
    "./result_10chains/node45_6_2.txt 84"
    "./result_10chains/node45_7_0.txt 83"
    "./result_10chains/node45_7_2.txt 83"
    "./result_10chains/node45_8_0.txt 82"
    "./result_10chains/node45_8_2.txt 82"
    "./result_10chains/node45_9_0.txt 81"
    "./result_10chains/node45_9_2.txt 81"
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
