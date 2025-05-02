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
ros2 run evaluation_3_randomdag uunifast_node -n node316_0_2 -p 45 -st topic316_0_1 -pt None -u 0.009332263544863828 > ./result_8chains/node316_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_1_2 -p 80 -st topic316_1_1 -pt None -u 0.0039803741391372105 > ./result_8chains/node316_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_2_2 -p 360 -st topic316_2_1 -pt None -u 0.042265445357327874 > ./result_8chains/node316_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_3_2 -p 494 -st topic316_3_1 -pt None -u 0.006227543913040617 > ./result_8chains/node316_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_4_2 -p 498 -st topic316_4_1 -pt None -u 0.02205736423992538 > ./result_8chains/node316_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_5_2 -p 810 -st topic316_5_1 -pt None -u 0.004126482065236886 > ./result_8chains/node316_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_6_2 -p 831 -st topic316_6_1 -pt None -u 0.01221037176999553 > ./result_8chains/node316_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_7_2 -p 836 -st topic316_7_1 -pt None -u 0.021910512250952474 > ./result_8chains/node316_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_0_0 -p 45 -st none -pt topic316_0_0 -u 0.07602123181840048 > ./result_8chains/node316_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_1_0 -p 80 -st none -pt topic316_1_0 -u 9.211353946919631e-05 > ./result_8chains/node316_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_2_0 -p 360 -st none -pt topic316_2_0 -u 0.024096631694262016 > ./result_8chains/node316_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_3_0 -p 494 -st none -pt topic316_3_0 -u 0.04142968238716957 > ./result_8chains/node316_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_4_0 -p 498 -st none -pt topic316_4_0 -u 0.00909937223262064 > ./result_8chains/node316_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_5_0 -p 810 -st none -pt topic316_5_0 -u 0.031055419196052134 > ./result_8chains/node316_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_6_0 -p 831 -st none -pt topic316_6_0 -u 0.01829665025388534 > ./result_8chains/node316_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_7_0 -p 836 -st none -pt topic316_7_0 -u 0.019078677352880314 > ./result_8chains/node316_7_0.txt &
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
    "./result_8chains/node316_0_0.txt 90"
    "./result_8chains/node316_0_2.txt 90"
    "./result_8chains/node316_1_0.txt 89"
    "./result_8chains/node316_1_2.txt 89"
    "./result_8chains/node316_2_0.txt 88"
    "./result_8chains/node316_2_2.txt 88"
    "./result_8chains/node316_3_0.txt 87"
    "./result_8chains/node316_3_2.txt 87"
    "./result_8chains/node316_4_0.txt 86"
    "./result_8chains/node316_4_2.txt 86"
    "./result_8chains/node316_5_0.txt 85"
    "./result_8chains/node316_5_2.txt 85"
    "./result_8chains/node316_6_0.txt 84"
    "./result_8chains/node316_6_2.txt 84"
    "./result_8chains/node316_7_0.txt 83"
    "./result_8chains/node316_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
