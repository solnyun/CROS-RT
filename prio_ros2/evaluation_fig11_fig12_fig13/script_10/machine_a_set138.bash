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
ros2 run evaluation_3_randomdag uunifast_node -n node138_0_2 -p 36 -st topic138_0_1 -pt None -u 0.019188198038531556 > ./result_10chains/node138_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_1_2 -p 224 -st topic138_1_1 -pt None -u 0.008706836986012711 > ./result_10chains/node138_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_2_2 -p 253 -st topic138_2_1 -pt None -u 0.031629015561460805 > ./result_10chains/node138_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_3_2 -p 367 -st topic138_3_1 -pt None -u 0.019384574108817276 > ./result_10chains/node138_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_4_2 -p 562 -st topic138_4_1 -pt None -u 0.00295174174037538 > ./result_10chains/node138_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_5_2 -p 739 -st topic138_5_1 -pt None -u 0.0025166499602017056 > ./result_10chains/node138_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_6_2 -p 794 -st topic138_6_1 -pt None -u 0.01261576731521416 > ./result_10chains/node138_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_7_2 -p 885 -st topic138_7_1 -pt None -u 0.059901236345063835 > ./result_10chains/node138_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_8_2 -p 938 -st topic138_8_1 -pt None -u 0.013109592931047825 > ./result_10chains/node138_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_9_2 -p 974 -st topic138_9_1 -pt None -u 0.03478099161601313 > ./result_10chains/node138_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_0_0 -p 36 -st none -pt topic138_0_0 -u 0.02366450810755799 > ./result_10chains/node138_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_1_0 -p 224 -st none -pt topic138_1_0 -u 0.002725120753432786 > ./result_10chains/node138_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_2_0 -p 253 -st none -pt topic138_2_0 -u 0.017006559650072306 > ./result_10chains/node138_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_3_0 -p 367 -st none -pt topic138_3_0 -u 0.004078168960352624 > ./result_10chains/node138_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_4_0 -p 562 -st none -pt topic138_4_0 -u 1.2292230128718717e-05 > ./result_10chains/node138_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_5_0 -p 739 -st none -pt topic138_5_0 -u 0.0002746243859608477 > ./result_10chains/node138_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_6_0 -p 794 -st none -pt topic138_6_0 -u 0.0038925784666465346 > ./result_10chains/node138_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_7_0 -p 885 -st none -pt topic138_7_0 -u 0.000977124813343444 > ./result_10chains/node138_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node138_8_0 -p 938 -st none -pt topic138_8_0 -u 0.0022544423933911067 > ./result_10chains/node138_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node138_9_0 -p 974 -st none -pt topic138_9_0 -u 0.015064437213575782 > ./result_10chains/node138_9_0.txt &
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
    "./result_10chains/node138_0_0.txt 90"
    "./result_10chains/node138_0_2.txt 90"
    "./result_10chains/node138_1_0.txt 89"
    "./result_10chains/node138_1_2.txt 89"
    "./result_10chains/node138_2_0.txt 88"
    "./result_10chains/node138_2_2.txt 88"
    "./result_10chains/node138_3_0.txt 87"
    "./result_10chains/node138_3_2.txt 87"
    "./result_10chains/node138_4_0.txt 86"
    "./result_10chains/node138_4_2.txt 86"
    "./result_10chains/node138_5_0.txt 85"
    "./result_10chains/node138_5_2.txt 85"
    "./result_10chains/node138_6_0.txt 84"
    "./result_10chains/node138_6_2.txt 84"
    "./result_10chains/node138_7_0.txt 83"
    "./result_10chains/node138_7_2.txt 83"
    "./result_10chains/node138_8_0.txt 82"
    "./result_10chains/node138_8_2.txt 82"
    "./result_10chains/node138_9_0.txt 81"
    "./result_10chains/node138_9_2.txt 81"
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
