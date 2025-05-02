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
ros2 run evaluation_3_randomdag uunifast_node -n node280_0_2 -p 122 -st topic280_0_1 -pt None -u 0.1052427074573824 > ./result_10chains/node280_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_1_2 -p 156 -st topic280_1_1 -pt None -u 0.023355320517757017 > ./result_10chains/node280_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_2_2 -p 339 -st topic280_2_1 -pt None -u 0.0024099693188576743 > ./result_10chains/node280_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_3_2 -p 480 -st topic280_3_1 -pt None -u 0.007934404111635596 > ./result_10chains/node280_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_4_2 -p 493 -st topic280_4_1 -pt None -u 0.022833080463978944 > ./result_10chains/node280_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_5_2 -p 510 -st topic280_5_1 -pt None -u 0.0016101713328764145 > ./result_10chains/node280_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_6_2 -p 551 -st topic280_6_1 -pt None -u 0.0004806992682790667 > ./result_10chains/node280_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_7_2 -p 783 -st topic280_7_1 -pt None -u 0.008709516709342308 > ./result_10chains/node280_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_8_2 -p 852 -st topic280_8_1 -pt None -u 0.010264417405588769 > ./result_10chains/node280_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_9_2 -p 976 -st topic280_9_1 -pt None -u 0.020844880278968598 > ./result_10chains/node280_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_0_0 -p 122 -st none -pt topic280_0_0 -u 0.004858668188914894 > ./result_10chains/node280_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_1_0 -p 156 -st none -pt topic280_1_0 -u 0.01734487413286706 > ./result_10chains/node280_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_2_0 -p 339 -st none -pt topic280_2_0 -u 0.00030192464885708814 > ./result_10chains/node280_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_3_0 -p 480 -st none -pt topic280_3_0 -u 0.006360897835901491 > ./result_10chains/node280_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_4_0 -p 493 -st none -pt topic280_4_0 -u 0.0070513290039300736 > ./result_10chains/node280_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_5_0 -p 510 -st none -pt topic280_5_0 -u 0.008788858620576656 > ./result_10chains/node280_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_6_0 -p 551 -st none -pt topic280_6_0 -u 0.004072968318912185 > ./result_10chains/node280_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_7_0 -p 783 -st none -pt topic280_7_0 -u 0.025297385570303144 > ./result_10chains/node280_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_8_0 -p 852 -st none -pt topic280_8_0 -u 0.021955436582979215 > ./result_10chains/node280_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_9_0 -p 976 -st none -pt topic280_9_0 -u 0.04218489300578245 > ./result_10chains/node280_9_0.txt &
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
    "./result_10chains/node280_0_0.txt 90"
    "./result_10chains/node280_0_2.txt 90"
    "./result_10chains/node280_1_0.txt 89"
    "./result_10chains/node280_1_2.txt 89"
    "./result_10chains/node280_2_0.txt 88"
    "./result_10chains/node280_2_2.txt 88"
    "./result_10chains/node280_3_0.txt 87"
    "./result_10chains/node280_3_2.txt 87"
    "./result_10chains/node280_4_0.txt 86"
    "./result_10chains/node280_4_2.txt 86"
    "./result_10chains/node280_5_0.txt 85"
    "./result_10chains/node280_5_2.txt 85"
    "./result_10chains/node280_6_0.txt 84"
    "./result_10chains/node280_6_2.txt 84"
    "./result_10chains/node280_7_0.txt 83"
    "./result_10chains/node280_7_2.txt 83"
    "./result_10chains/node280_8_0.txt 82"
    "./result_10chains/node280_8_2.txt 82"
    "./result_10chains/node280_9_0.txt 81"
    "./result_10chains/node280_9_2.txt 81"
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
