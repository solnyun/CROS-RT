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
ros2 run evaluation_3_randomdag uunifast_node -n node383_0_2 -p 71 -st topic383_0_1 -pt None -u 0.015022022545153335 > ./result_10chains/node383_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_1_2 -p 212 -st topic383_1_1 -pt None -u 0.0014034907058765866 > ./result_10chains/node383_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_2_2 -p 249 -st topic383_2_1 -pt None -u 0.010235633275485712 > ./result_10chains/node383_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_3_2 -p 272 -st topic383_3_1 -pt None -u 0.018529484897583492 > ./result_10chains/node383_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_4_2 -p 355 -st topic383_4_1 -pt None -u 0.0558713401562535 > ./result_10chains/node383_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_5_2 -p 387 -st topic383_5_1 -pt None -u 0.044489976418460364 > ./result_10chains/node383_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_6_2 -p 447 -st topic383_6_1 -pt None -u 0.003367871266937411 > ./result_10chains/node383_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_7_2 -p 485 -st topic383_7_1 -pt None -u 0.028228632684292376 > ./result_10chains/node383_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_8_2 -p 747 -st topic383_8_1 -pt None -u 0.006278949176695553 > ./result_10chains/node383_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_9_2 -p 915 -st topic383_9_1 -pt None -u 0.047907194459288545 > ./result_10chains/node383_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_0_0 -p 71 -st none -pt topic383_0_0 -u 0.012402197006215088 > ./result_10chains/node383_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_1_0 -p 212 -st none -pt topic383_1_0 -u 0.01880835513383572 > ./result_10chains/node383_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_2_0 -p 249 -st none -pt topic383_2_0 -u 0.013881512713026067 > ./result_10chains/node383_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_3_0 -p 272 -st none -pt topic383_3_0 -u 0.007099208166167548 > ./result_10chains/node383_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_4_0 -p 355 -st none -pt topic383_4_0 -u 0.009956236565177967 > ./result_10chains/node383_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_5_0 -p 387 -st none -pt topic383_5_0 -u 0.019846031548013565 > ./result_10chains/node383_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_6_0 -p 447 -st none -pt topic383_6_0 -u 0.004260849738228545 > ./result_10chains/node383_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_7_0 -p 485 -st none -pt topic383_7_0 -u 0.04645763749050033 > ./result_10chains/node383_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_8_0 -p 747 -st none -pt topic383_8_0 -u 0.005245676681178493 > ./result_10chains/node383_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_9_0 -p 915 -st none -pt topic383_9_0 -u 0.010027137163921514 > ./result_10chains/node383_9_0.txt &
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
    "./result_10chains/node383_0_0.txt 90"
    "./result_10chains/node383_0_2.txt 90"
    "./result_10chains/node383_1_0.txt 89"
    "./result_10chains/node383_1_2.txt 89"
    "./result_10chains/node383_2_0.txt 88"
    "./result_10chains/node383_2_2.txt 88"
    "./result_10chains/node383_3_0.txt 87"
    "./result_10chains/node383_3_2.txt 87"
    "./result_10chains/node383_4_0.txt 86"
    "./result_10chains/node383_4_2.txt 86"
    "./result_10chains/node383_5_0.txt 85"
    "./result_10chains/node383_5_2.txt 85"
    "./result_10chains/node383_6_0.txt 84"
    "./result_10chains/node383_6_2.txt 84"
    "./result_10chains/node383_7_0.txt 83"
    "./result_10chains/node383_7_2.txt 83"
    "./result_10chains/node383_8_0.txt 82"
    "./result_10chains/node383_8_2.txt 82"
    "./result_10chains/node383_9_0.txt 81"
    "./result_10chains/node383_9_2.txt 81"
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
