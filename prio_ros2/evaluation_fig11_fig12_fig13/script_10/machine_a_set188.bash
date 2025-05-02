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
ros2 run evaluation_3_randomdag uunifast_node -n node188_0_2 -p 37 -st topic188_0_1 -pt None -u 0.003522534910731845 > ./result_10chains/node188_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_1_2 -p 74 -st topic188_1_1 -pt None -u 1.815937262694689e-05 > ./result_10chains/node188_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_2_2 -p 114 -st topic188_2_1 -pt None -u 0.028145357679834837 > ./result_10chains/node188_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_3_2 -p 134 -st topic188_3_1 -pt None -u 0.023310669520901273 > ./result_10chains/node188_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_4_2 -p 380 -st topic188_4_1 -pt None -u 0.0013380776148250728 > ./result_10chains/node188_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_5_2 -p 667 -st topic188_5_1 -pt None -u 0.0062111679485784554 > ./result_10chains/node188_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_6_2 -p 701 -st topic188_6_1 -pt None -u 0.0053632721315532705 > ./result_10chains/node188_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_7_2 -p 712 -st topic188_7_1 -pt None -u 0.05728831474479034 > ./result_10chains/node188_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_8_2 -p 746 -st topic188_8_1 -pt None -u 0.007277690304936028 > ./result_10chains/node188_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_9_2 -p 835 -st topic188_9_1 -pt None -u 0.007065143598891986 > ./result_10chains/node188_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_0_0 -p 37 -st none -pt topic188_0_0 -u 0.014100985804235133 > ./result_10chains/node188_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_1_0 -p 74 -st none -pt topic188_1_0 -u 0.007985826747642921 > ./result_10chains/node188_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_2_0 -p 114 -st none -pt topic188_2_0 -u 0.0020645238413344313 > ./result_10chains/node188_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_3_0 -p 134 -st none -pt topic188_3_0 -u 0.002603934415069009 > ./result_10chains/node188_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_4_0 -p 380 -st none -pt topic188_4_0 -u 0.0025941632953506155 > ./result_10chains/node188_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_5_0 -p 667 -st none -pt topic188_5_0 -u 0.02835603638350681 > ./result_10chains/node188_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_6_0 -p 701 -st none -pt topic188_6_0 -u 0.015655631113794394 > ./result_10chains/node188_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_7_0 -p 712 -st none -pt topic188_7_0 -u 0.003910888707436472 > ./result_10chains/node188_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_8_0 -p 746 -st none -pt topic188_8_0 -u 0.010867473163410274 > ./result_10chains/node188_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_9_0 -p 835 -st none -pt topic188_9_0 -u 0.0010680501484505549 > ./result_10chains/node188_9_0.txt &
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
    "./result_10chains/node188_0_0.txt 90"
    "./result_10chains/node188_0_2.txt 90"
    "./result_10chains/node188_1_0.txt 89"
    "./result_10chains/node188_1_2.txt 89"
    "./result_10chains/node188_2_0.txt 88"
    "./result_10chains/node188_2_2.txt 88"
    "./result_10chains/node188_3_0.txt 87"
    "./result_10chains/node188_3_2.txt 87"
    "./result_10chains/node188_4_0.txt 86"
    "./result_10chains/node188_4_2.txt 86"
    "./result_10chains/node188_5_0.txt 85"
    "./result_10chains/node188_5_2.txt 85"
    "./result_10chains/node188_6_0.txt 84"
    "./result_10chains/node188_6_2.txt 84"
    "./result_10chains/node188_7_0.txt 83"
    "./result_10chains/node188_7_2.txt 83"
    "./result_10chains/node188_8_0.txt 82"
    "./result_10chains/node188_8_2.txt 82"
    "./result_10chains/node188_9_0.txt 81"
    "./result_10chains/node188_9_2.txt 81"
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
