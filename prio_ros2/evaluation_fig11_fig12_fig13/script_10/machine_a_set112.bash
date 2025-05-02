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
ros2 run evaluation_3_randomdag uunifast_node -n node112_0_2 -p 126 -st topic112_0_1 -pt None -u 0.03265918654599648 > ./result_10chains/node112_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_1_2 -p 273 -st topic112_1_1 -pt None -u 0.016645050991570265 > ./result_10chains/node112_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_2_2 -p 373 -st topic112_2_1 -pt None -u 0.021838579889413068 > ./result_10chains/node112_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_3_2 -p 423 -st topic112_3_1 -pt None -u 0.0017518459385425789 > ./result_10chains/node112_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_4_2 -p 510 -st topic112_4_1 -pt None -u 0.01462421589579016 > ./result_10chains/node112_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_5_2 -p 793 -st topic112_5_1 -pt None -u 0.0037440719756671736 > ./result_10chains/node112_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_6_2 -p 811 -st topic112_6_1 -pt None -u 0.004761734306343357 > ./result_10chains/node112_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_7_2 -p 872 -st topic112_7_1 -pt None -u 0.024771179976782867 > ./result_10chains/node112_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_8_2 -p 905 -st topic112_8_1 -pt None -u 0.0022377304094950354 > ./result_10chains/node112_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_9_2 -p 937 -st topic112_9_1 -pt None -u 0.004780985802651522 > ./result_10chains/node112_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_0_0 -p 126 -st none -pt topic112_0_0 -u 0.024503803611136354 > ./result_10chains/node112_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_1_0 -p 273 -st none -pt topic112_1_0 -u 0.004147864333326257 > ./result_10chains/node112_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_2_0 -p 373 -st none -pt topic112_2_0 -u 0.0025439173829082673 > ./result_10chains/node112_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_3_0 -p 423 -st none -pt topic112_3_0 -u 0.08608901704954752 > ./result_10chains/node112_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_4_0 -p 510 -st none -pt topic112_4_0 -u 0.0156749505982694 > ./result_10chains/node112_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_5_0 -p 793 -st none -pt topic112_5_0 -u 0.0050422085294995755 > ./result_10chains/node112_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_6_0 -p 811 -st none -pt topic112_6_0 -u 0.0177644030913571 > ./result_10chains/node112_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_7_0 -p 872 -st none -pt topic112_7_0 -u 0.010817646062031089 > ./result_10chains/node112_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_8_0 -p 905 -st none -pt topic112_8_0 -u 0.008474779167290294 > ./result_10chains/node112_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_9_0 -p 937 -st none -pt topic112_9_0 -u 0.02059723686705137 > ./result_10chains/node112_9_0.txt &
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
    "./result_10chains/node112_0_0.txt 90"
    "./result_10chains/node112_0_2.txt 90"
    "./result_10chains/node112_1_0.txt 89"
    "./result_10chains/node112_1_2.txt 89"
    "./result_10chains/node112_2_0.txt 88"
    "./result_10chains/node112_2_2.txt 88"
    "./result_10chains/node112_3_0.txt 87"
    "./result_10chains/node112_3_2.txt 87"
    "./result_10chains/node112_4_0.txt 86"
    "./result_10chains/node112_4_2.txt 86"
    "./result_10chains/node112_5_0.txt 85"
    "./result_10chains/node112_5_2.txt 85"
    "./result_10chains/node112_6_0.txt 84"
    "./result_10chains/node112_6_2.txt 84"
    "./result_10chains/node112_7_0.txt 83"
    "./result_10chains/node112_7_2.txt 83"
    "./result_10chains/node112_8_0.txt 82"
    "./result_10chains/node112_8_2.txt 82"
    "./result_10chains/node112_9_0.txt 81"
    "./result_10chains/node112_9_2.txt 81"
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
