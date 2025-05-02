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
ros2 run evaluation_3_randomdag uunifast_node -n node465_0_2 -p 105 -st topic465_0_1 -pt None -u 0.0024236942111828808 > ./result_10chains/node465_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_1_2 -p 176 -st topic465_1_1 -pt None -u 0.0013234008892337723 > ./result_10chains/node465_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_2_2 -p 187 -st topic465_2_1 -pt None -u 0.009886812129154654 > ./result_10chains/node465_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_3_2 -p 232 -st topic465_3_1 -pt None -u 0.017543809940965382 > ./result_10chains/node465_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_4_2 -p 444 -st topic465_4_1 -pt None -u 0.040088358578737465 > ./result_10chains/node465_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_5_2 -p 532 -st topic465_5_1 -pt None -u 0.02778089228455108 > ./result_10chains/node465_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_6_2 -p 643 -st topic465_6_1 -pt None -u 0.033015425116230235 > ./result_10chains/node465_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_7_2 -p 661 -st topic465_7_1 -pt None -u 0.023596836407775004 > ./result_10chains/node465_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_8_2 -p 925 -st topic465_8_1 -pt None -u 0.004968491741774453 > ./result_10chains/node465_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_9_2 -p 932 -st topic465_9_1 -pt None -u 0.003764512896866441 > ./result_10chains/node465_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_0_0 -p 105 -st none -pt topic465_0_0 -u 0.010760783471459923 > ./result_10chains/node465_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_1_0 -p 176 -st none -pt topic465_1_0 -u 0.005040354283028514 > ./result_10chains/node465_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_2_0 -p 187 -st none -pt topic465_2_0 -u 0.05621738030114254 > ./result_10chains/node465_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_3_0 -p 232 -st none -pt topic465_3_0 -u 0.01342721590954049 > ./result_10chains/node465_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_4_0 -p 444 -st none -pt topic465_4_0 -u 0.011265912167715164 > ./result_10chains/node465_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_5_0 -p 532 -st none -pt topic465_5_0 -u 0.0142313439209035 > ./result_10chains/node465_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_6_0 -p 643 -st none -pt topic465_6_0 -u 0.009652262944697176 > ./result_10chains/node465_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_7_0 -p 661 -st none -pt topic465_7_0 -u 0.0030938897768900686 > ./result_10chains/node465_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_8_0 -p 925 -st none -pt topic465_8_0 -u 0.008912279235717191 > ./result_10chains/node465_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_9_0 -p 932 -st none -pt topic465_9_0 -u 0.009431142000667199 > ./result_10chains/node465_9_0.txt &
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
    "./result_10chains/node465_0_0.txt 90"
    "./result_10chains/node465_0_2.txt 90"
    "./result_10chains/node465_1_0.txt 89"
    "./result_10chains/node465_1_2.txt 89"
    "./result_10chains/node465_2_0.txt 88"
    "./result_10chains/node465_2_2.txt 88"
    "./result_10chains/node465_3_0.txt 87"
    "./result_10chains/node465_3_2.txt 87"
    "./result_10chains/node465_4_0.txt 86"
    "./result_10chains/node465_4_2.txt 86"
    "./result_10chains/node465_5_0.txt 85"
    "./result_10chains/node465_5_2.txt 85"
    "./result_10chains/node465_6_0.txt 84"
    "./result_10chains/node465_6_2.txt 84"
    "./result_10chains/node465_7_0.txt 83"
    "./result_10chains/node465_7_2.txt 83"
    "./result_10chains/node465_8_0.txt 82"
    "./result_10chains/node465_8_2.txt 82"
    "./result_10chains/node465_9_0.txt 81"
    "./result_10chains/node465_9_2.txt 81"
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
