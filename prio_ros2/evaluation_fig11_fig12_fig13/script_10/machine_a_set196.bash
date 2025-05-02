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
ros2 run evaluation_3_randomdag uunifast_node -n node196_0_2 -p 45 -st topic196_0_1 -pt None -u 0.05821572494117533 > ./result_10chains/node196_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node196_1_2 -p 162 -st topic196_1_1 -pt None -u 0.030311671554484 > ./result_10chains/node196_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_2_2 -p 179 -st topic196_2_1 -pt None -u 0.05163754952174149 > ./result_10chains/node196_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node196_3_2 -p 228 -st topic196_3_1 -pt None -u 0.0029591983890928653 > ./result_10chains/node196_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_4_2 -p 288 -st topic196_4_1 -pt None -u 0.00046613283271557115 > ./result_10chains/node196_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node196_5_2 -p 381 -st topic196_5_1 -pt None -u 0.011737467752186037 > ./result_10chains/node196_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_6_2 -p 437 -st topic196_6_1 -pt None -u 0.0026666430204602964 > ./result_10chains/node196_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node196_7_2 -p 685 -st topic196_7_1 -pt None -u 0.015895316123499176 > ./result_10chains/node196_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_8_2 -p 802 -st topic196_8_1 -pt None -u 0.025040819199898173 > ./result_10chains/node196_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node196_9_2 -p 880 -st topic196_9_1 -pt None -u 0.02402548884297567 > ./result_10chains/node196_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_0_0 -p 45 -st none -pt topic196_0_0 -u 0.012021895406613248 > ./result_10chains/node196_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node196_1_0 -p 162 -st none -pt topic196_1_0 -u 0.014406131392208643 > ./result_10chains/node196_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_2_0 -p 179 -st none -pt topic196_2_0 -u 0.007052628868432109 > ./result_10chains/node196_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node196_3_0 -p 228 -st none -pt topic196_3_0 -u 0.009252400291144824 > ./result_10chains/node196_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_4_0 -p 288 -st none -pt topic196_4_0 -u 0.008483378673196429 > ./result_10chains/node196_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node196_5_0 -p 381 -st none -pt topic196_5_0 -u 0.020229666172214278 > ./result_10chains/node196_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_6_0 -p 437 -st none -pt topic196_6_0 -u 0.018277629942265783 > ./result_10chains/node196_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node196_7_0 -p 685 -st none -pt topic196_7_0 -u 0.00031509833685083866 > ./result_10chains/node196_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_8_0 -p 802 -st none -pt topic196_8_0 -u 0.039405050953507284 > ./result_10chains/node196_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node196_9_0 -p 880 -st none -pt topic196_9_0 -u 0.0590285440923812 > ./result_10chains/node196_9_0.txt &
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
    "./result_10chains/node196_0_0.txt 90"
    "./result_10chains/node196_0_2.txt 90"
    "./result_10chains/node196_1_0.txt 89"
    "./result_10chains/node196_1_2.txt 89"
    "./result_10chains/node196_2_0.txt 88"
    "./result_10chains/node196_2_2.txt 88"
    "./result_10chains/node196_3_0.txt 87"
    "./result_10chains/node196_3_2.txt 87"
    "./result_10chains/node196_4_0.txt 86"
    "./result_10chains/node196_4_2.txt 86"
    "./result_10chains/node196_5_0.txt 85"
    "./result_10chains/node196_5_2.txt 85"
    "./result_10chains/node196_6_0.txt 84"
    "./result_10chains/node196_6_2.txt 84"
    "./result_10chains/node196_7_0.txt 83"
    "./result_10chains/node196_7_2.txt 83"
    "./result_10chains/node196_8_0.txt 82"
    "./result_10chains/node196_8_2.txt 82"
    "./result_10chains/node196_9_0.txt 81"
    "./result_10chains/node196_9_2.txt 81"
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
