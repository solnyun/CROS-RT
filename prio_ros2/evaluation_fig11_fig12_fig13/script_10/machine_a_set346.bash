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
ros2 run evaluation_3_randomdag uunifast_node -n node346_0_2 -p 29 -st topic346_0_1 -pt None -u 0.0048818921009278204 > ./result_10chains/node346_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_1_2 -p 243 -st topic346_1_1 -pt None -u 0.016892548982787747 > ./result_10chains/node346_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_2_2 -p 330 -st topic346_2_1 -pt None -u 0.006789141064262705 > ./result_10chains/node346_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_3_2 -p 346 -st topic346_3_1 -pt None -u 0.003626568273073172 > ./result_10chains/node346_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_4_2 -p 493 -st topic346_4_1 -pt None -u 0.024771438242599975 > ./result_10chains/node346_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_5_2 -p 516 -st topic346_5_1 -pt None -u 0.02817389282547972 > ./result_10chains/node346_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_6_2 -p 526 -st topic346_6_1 -pt None -u 0.005881563471942797 > ./result_10chains/node346_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_7_2 -p 616 -st topic346_7_1 -pt None -u 0.007699567082291164 > ./result_10chains/node346_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_8_2 -p 747 -st topic346_8_1 -pt None -u 0.03506680635564191 > ./result_10chains/node346_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_9_2 -p 960 -st topic346_9_1 -pt None -u 0.05532231028174112 > ./result_10chains/node346_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_0_0 -p 29 -st none -pt topic346_0_0 -u 0.0025625348491796762 > ./result_10chains/node346_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_1_0 -p 243 -st none -pt topic346_1_0 -u 0.03464662006177799 > ./result_10chains/node346_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_2_0 -p 330 -st none -pt topic346_2_0 -u 0.0023417365423366587 > ./result_10chains/node346_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_3_0 -p 346 -st none -pt topic346_3_0 -u 0.01830294067349758 > ./result_10chains/node346_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_4_0 -p 493 -st none -pt topic346_4_0 -u 0.0030507385529262576 > ./result_10chains/node346_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_5_0 -p 516 -st none -pt topic346_5_0 -u 0.03400608942001054 > ./result_10chains/node346_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_6_0 -p 526 -st none -pt topic346_6_0 -u 0.013157034366399256 > ./result_10chains/node346_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_7_0 -p 616 -st none -pt topic346_7_0 -u 0.0004048769353309223 > ./result_10chains/node346_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_8_0 -p 747 -st none -pt topic346_8_0 -u 0.04245164075112415 > ./result_10chains/node346_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_9_0 -p 960 -st none -pt topic346_9_0 -u 0.02586499459622329 > ./result_10chains/node346_9_0.txt &
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
    "./result_10chains/node346_0_0.txt 90"
    "./result_10chains/node346_0_2.txt 90"
    "./result_10chains/node346_1_0.txt 89"
    "./result_10chains/node346_1_2.txt 89"
    "./result_10chains/node346_2_0.txt 88"
    "./result_10chains/node346_2_2.txt 88"
    "./result_10chains/node346_3_0.txt 87"
    "./result_10chains/node346_3_2.txt 87"
    "./result_10chains/node346_4_0.txt 86"
    "./result_10chains/node346_4_2.txt 86"
    "./result_10chains/node346_5_0.txt 85"
    "./result_10chains/node346_5_2.txt 85"
    "./result_10chains/node346_6_0.txt 84"
    "./result_10chains/node346_6_2.txt 84"
    "./result_10chains/node346_7_0.txt 83"
    "./result_10chains/node346_7_2.txt 83"
    "./result_10chains/node346_8_0.txt 82"
    "./result_10chains/node346_8_2.txt 82"
    "./result_10chains/node346_9_0.txt 81"
    "./result_10chains/node346_9_2.txt 81"
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
