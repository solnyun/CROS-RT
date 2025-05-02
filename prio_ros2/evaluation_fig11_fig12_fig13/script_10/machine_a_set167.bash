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
ros2 run evaluation_3_randomdag uunifast_node -n node167_0_2 -p 15 -st topic167_0_1 -pt None -u 0.024880357916445883 > ./result_10chains/node167_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_1_2 -p 76 -st topic167_1_1 -pt None -u 0.015338507706375182 > ./result_10chains/node167_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_2_2 -p 303 -st topic167_2_1 -pt None -u 0.022890904868731132 > ./result_10chains/node167_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_3_2 -p 355 -st topic167_3_1 -pt None -u 0.020180648380915656 > ./result_10chains/node167_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_4_2 -p 379 -st topic167_4_1 -pt None -u 0.010882950035561695 > ./result_10chains/node167_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_5_2 -p 619 -st topic167_5_1 -pt None -u 0.04530252980958313 > ./result_10chains/node167_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_6_2 -p 624 -st topic167_6_1 -pt None -u 0.00508578533572529 > ./result_10chains/node167_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_7_2 -p 662 -st topic167_7_1 -pt None -u 0.0017157767236339327 > ./result_10chains/node167_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_8_2 -p 718 -st topic167_8_1 -pt None -u 0.0007339410076824537 > ./result_10chains/node167_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_9_2 -p 810 -st topic167_9_1 -pt None -u 0.017468111097779394 > ./result_10chains/node167_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_0_0 -p 15 -st none -pt topic167_0_0 -u 0.0343466012544279 > ./result_10chains/node167_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_1_0 -p 76 -st none -pt topic167_1_0 -u 0.0023563412470407052 > ./result_10chains/node167_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_2_0 -p 303 -st none -pt topic167_2_0 -u 0.0011796544703985279 > ./result_10chains/node167_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_3_0 -p 355 -st none -pt topic167_3_0 -u 0.08187277384158326 > ./result_10chains/node167_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_4_0 -p 379 -st none -pt topic167_4_0 -u 0.0045771029783937545 > ./result_10chains/node167_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_5_0 -p 619 -st none -pt topic167_5_0 -u 0.0042764696435237115 > ./result_10chains/node167_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_6_0 -p 624 -st none -pt topic167_6_0 -u 0.010732269971938851 > ./result_10chains/node167_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_7_0 -p 662 -st none -pt topic167_7_0 -u 0.00010586283230794302 > ./result_10chains/node167_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_8_0 -p 718 -st none -pt topic167_8_0 -u 0.013122454459254987 > ./result_10chains/node167_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_9_0 -p 810 -st none -pt topic167_9_0 -u 0.0007094923282369367 > ./result_10chains/node167_9_0.txt &
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
    "./result_10chains/node167_0_0.txt 90"
    "./result_10chains/node167_0_2.txt 90"
    "./result_10chains/node167_1_0.txt 89"
    "./result_10chains/node167_1_2.txt 89"
    "./result_10chains/node167_2_0.txt 88"
    "./result_10chains/node167_2_2.txt 88"
    "./result_10chains/node167_3_0.txt 87"
    "./result_10chains/node167_3_2.txt 87"
    "./result_10chains/node167_4_0.txt 86"
    "./result_10chains/node167_4_2.txt 86"
    "./result_10chains/node167_5_0.txt 85"
    "./result_10chains/node167_5_2.txt 85"
    "./result_10chains/node167_6_0.txt 84"
    "./result_10chains/node167_6_2.txt 84"
    "./result_10chains/node167_7_0.txt 83"
    "./result_10chains/node167_7_2.txt 83"
    "./result_10chains/node167_8_0.txt 82"
    "./result_10chains/node167_8_2.txt 82"
    "./result_10chains/node167_9_0.txt 81"
    "./result_10chains/node167_9_2.txt 81"
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
