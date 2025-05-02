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
ros2 run evaluation_3_randomdag uunifast_node -n node345_0_2 -p 70 -st topic345_0_1 -pt None -u 0.0011383955603594398 > ./result_10chains/node345_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_1_2 -p 440 -st topic345_1_1 -pt None -u 0.01775183859752144 > ./result_10chains/node345_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_2_2 -p 447 -st topic345_2_1 -pt None -u 0.001800802884544206 > ./result_10chains/node345_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_3_2 -p 583 -st topic345_3_1 -pt None -u 0.00036302645037422643 > ./result_10chains/node345_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_4_2 -p 621 -st topic345_4_1 -pt None -u 0.017920379041708845 > ./result_10chains/node345_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_5_2 -p 694 -st topic345_5_1 -pt None -u 0.04467479607260197 > ./result_10chains/node345_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_6_2 -p 783 -st topic345_6_1 -pt None -u 0.008026167079804664 > ./result_10chains/node345_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_7_2 -p 814 -st topic345_7_1 -pt None -u 0.015641093357068286 > ./result_10chains/node345_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_8_2 -p 844 -st topic345_8_1 -pt None -u 0.026632049329005814 > ./result_10chains/node345_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_9_2 -p 890 -st topic345_9_1 -pt None -u 0.013064651859680101 > ./result_10chains/node345_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_0_0 -p 70 -st none -pt topic345_0_0 -u 0.008269808620271768 > ./result_10chains/node345_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_1_0 -p 440 -st none -pt topic345_1_0 -u 0.027334431930705783 > ./result_10chains/node345_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_2_0 -p 447 -st none -pt topic345_2_0 -u 0.021135723527813788 > ./result_10chains/node345_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_3_0 -p 583 -st none -pt topic345_3_0 -u 0.01928492360407541 > ./result_10chains/node345_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_4_0 -p 621 -st none -pt topic345_4_0 -u 0.012403893963407353 > ./result_10chains/node345_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_5_0 -p 694 -st none -pt topic345_5_0 -u 0.003196156200463096 > ./result_10chains/node345_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_6_0 -p 783 -st none -pt topic345_6_0 -u 0.03304985992923984 > ./result_10chains/node345_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_7_0 -p 814 -st none -pt topic345_7_0 -u 0.023509831055893743 > ./result_10chains/node345_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_8_0 -p 844 -st none -pt topic345_8_0 -u 0.030527596809514418 > ./result_10chains/node345_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_9_0 -p 890 -st none -pt topic345_9_0 -u 0.043702047269930606 > ./result_10chains/node345_9_0.txt &
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
    "./result_10chains/node345_0_0.txt 90"
    "./result_10chains/node345_0_2.txt 90"
    "./result_10chains/node345_1_0.txt 89"
    "./result_10chains/node345_1_2.txt 89"
    "./result_10chains/node345_2_0.txt 88"
    "./result_10chains/node345_2_2.txt 88"
    "./result_10chains/node345_3_0.txt 87"
    "./result_10chains/node345_3_2.txt 87"
    "./result_10chains/node345_4_0.txt 86"
    "./result_10chains/node345_4_2.txt 86"
    "./result_10chains/node345_5_0.txt 85"
    "./result_10chains/node345_5_2.txt 85"
    "./result_10chains/node345_6_0.txt 84"
    "./result_10chains/node345_6_2.txt 84"
    "./result_10chains/node345_7_0.txt 83"
    "./result_10chains/node345_7_2.txt 83"
    "./result_10chains/node345_8_0.txt 82"
    "./result_10chains/node345_8_2.txt 82"
    "./result_10chains/node345_9_0.txt 81"
    "./result_10chains/node345_9_2.txt 81"
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
