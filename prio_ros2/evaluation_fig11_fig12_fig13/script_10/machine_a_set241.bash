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
ros2 run evaluation_3_randomdag uunifast_node -n node241_0_2 -p 69 -st topic241_0_1 -pt None -u 0.007115438065601498 > ./result_10chains/node241_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_1_2 -p 157 -st topic241_1_1 -pt None -u 0.027904334381481488 > ./result_10chains/node241_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_2_2 -p 226 -st topic241_2_1 -pt None -u 0.03173642172756336 > ./result_10chains/node241_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_3_2 -p 277 -st topic241_3_1 -pt None -u 0.00657959867916369 > ./result_10chains/node241_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_4_2 -p 394 -st topic241_4_1 -pt None -u 0.0014015293030080755 > ./result_10chains/node241_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_5_2 -p 584 -st topic241_5_1 -pt None -u 0.011033584138902597 > ./result_10chains/node241_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_6_2 -p 621 -st topic241_6_1 -pt None -u 0.012494609498202608 > ./result_10chains/node241_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_7_2 -p 680 -st topic241_7_1 -pt None -u 0.031210367245750492 > ./result_10chains/node241_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_8_2 -p 917 -st topic241_8_1 -pt None -u 0.03791159767400155 > ./result_10chains/node241_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_9_2 -p 939 -st topic241_9_1 -pt None -u 0.000510295417473304 > ./result_10chains/node241_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_0_0 -p 69 -st none -pt topic241_0_0 -u 0.005221709316964418 > ./result_10chains/node241_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_1_0 -p 157 -st none -pt topic241_1_0 -u 0.020670229907620852 > ./result_10chains/node241_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_2_0 -p 226 -st none -pt topic241_2_0 -u 0.026679605501942594 > ./result_10chains/node241_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_3_0 -p 277 -st none -pt topic241_3_0 -u 0.04671062873947324 > ./result_10chains/node241_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_4_0 -p 394 -st none -pt topic241_4_0 -u 0.00677755004437719 > ./result_10chains/node241_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_5_0 -p 584 -st none -pt topic241_5_0 -u 0.012051000465981343 > ./result_10chains/node241_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_6_0 -p 621 -st none -pt topic241_6_0 -u 0.006137150251657647 > ./result_10chains/node241_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_7_0 -p 680 -st none -pt topic241_7_0 -u 0.003030597136121582 > ./result_10chains/node241_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_8_0 -p 917 -st none -pt topic241_8_0 -u 0.009182915607923434 > ./result_10chains/node241_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_9_0 -p 939 -st none -pt topic241_9_0 -u 0.032732448234353936 > ./result_10chains/node241_9_0.txt &
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
    "./result_10chains/node241_0_0.txt 90"
    "./result_10chains/node241_0_2.txt 90"
    "./result_10chains/node241_1_0.txt 89"
    "./result_10chains/node241_1_2.txt 89"
    "./result_10chains/node241_2_0.txt 88"
    "./result_10chains/node241_2_2.txt 88"
    "./result_10chains/node241_3_0.txt 87"
    "./result_10chains/node241_3_2.txt 87"
    "./result_10chains/node241_4_0.txt 86"
    "./result_10chains/node241_4_2.txt 86"
    "./result_10chains/node241_5_0.txt 85"
    "./result_10chains/node241_5_2.txt 85"
    "./result_10chains/node241_6_0.txt 84"
    "./result_10chains/node241_6_2.txt 84"
    "./result_10chains/node241_7_0.txt 83"
    "./result_10chains/node241_7_2.txt 83"
    "./result_10chains/node241_8_0.txt 82"
    "./result_10chains/node241_8_2.txt 82"
    "./result_10chains/node241_9_0.txt 81"
    "./result_10chains/node241_9_2.txt 81"
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
