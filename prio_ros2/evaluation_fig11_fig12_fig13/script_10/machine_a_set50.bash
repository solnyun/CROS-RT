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
ros2 run evaluation_3_randomdag uunifast_node -n node50_0_2 -p 16 -st topic50_0_1 -pt None -u 0.0020685661012240786 > ./result_10chains/node50_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node50_1_2 -p 409 -st topic50_1_1 -pt None -u 0.017689212213178263 > ./result_10chains/node50_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node50_2_2 -p 612 -st topic50_2_1 -pt None -u 0.000966089615671184 > ./result_10chains/node50_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node50_3_2 -p 708 -st topic50_3_1 -pt None -u 0.0086081224225667 > ./result_10chains/node50_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node50_4_2 -p 792 -st topic50_4_1 -pt None -u 0.012395803302545916 > ./result_10chains/node50_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node50_5_2 -p 818 -st topic50_5_1 -pt None -u 0.011331251815966531 > ./result_10chains/node50_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node50_6_2 -p 841 -st topic50_6_1 -pt None -u 0.02622052578876974 > ./result_10chains/node50_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node50_7_2 -p 844 -st topic50_7_1 -pt None -u 0.006661321239877144 > ./result_10chains/node50_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node50_8_2 -p 879 -st topic50_8_1 -pt None -u 0.00011930216719638342 > ./result_10chains/node50_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node50_9_2 -p 946 -st topic50_9_1 -pt None -u 0.021485519426859334 > ./result_10chains/node50_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node50_0_0 -p 16 -st none -pt topic50_0_0 -u 0.0034784693490941265 > ./result_10chains/node50_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node50_1_0 -p 409 -st none -pt topic50_1_0 -u 0.009244197323334868 > ./result_10chains/node50_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node50_2_0 -p 612 -st none -pt topic50_2_0 -u 0.04111443825598582 > ./result_10chains/node50_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node50_3_0 -p 708 -st none -pt topic50_3_0 -u 0.0028661976987732762 > ./result_10chains/node50_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node50_4_0 -p 792 -st none -pt topic50_4_0 -u 0.006052477124484867 > ./result_10chains/node50_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node50_5_0 -p 818 -st none -pt topic50_5_0 -u 0.020974730452846813 > ./result_10chains/node50_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node50_6_0 -p 841 -st none -pt topic50_6_0 -u 0.017010618059830396 > ./result_10chains/node50_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node50_7_0 -p 844 -st none -pt topic50_7_0 -u 0.0007572682128398067 > ./result_10chains/node50_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node50_8_0 -p 879 -st none -pt topic50_8_0 -u 0.008315922561457384 > ./result_10chains/node50_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node50_9_0 -p 946 -st none -pt topic50_9_0 -u 0.05122721879653592 > ./result_10chains/node50_9_0.txt &
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
    "./result_10chains/node50_0_0.txt 90"
    "./result_10chains/node50_0_2.txt 90"
    "./result_10chains/node50_1_0.txt 89"
    "./result_10chains/node50_1_2.txt 89"
    "./result_10chains/node50_2_0.txt 88"
    "./result_10chains/node50_2_2.txt 88"
    "./result_10chains/node50_3_0.txt 87"
    "./result_10chains/node50_3_2.txt 87"
    "./result_10chains/node50_4_0.txt 86"
    "./result_10chains/node50_4_2.txt 86"
    "./result_10chains/node50_5_0.txt 85"
    "./result_10chains/node50_5_2.txt 85"
    "./result_10chains/node50_6_0.txt 84"
    "./result_10chains/node50_6_2.txt 84"
    "./result_10chains/node50_7_0.txt 83"
    "./result_10chains/node50_7_2.txt 83"
    "./result_10chains/node50_8_0.txt 82"
    "./result_10chains/node50_8_2.txt 82"
    "./result_10chains/node50_9_0.txt 81"
    "./result_10chains/node50_9_2.txt 81"
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
