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
ros2 run evaluation_3_randomdag uunifast_node -n node9_0_2 -p 24 -st topic9_0_1 -pt None -u 0.024938032185357117 > ./result_10chains/node9_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_1_2 -p 408 -st topic9_1_1 -pt None -u 0.0030946147951929626 > ./result_10chains/node9_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_2_2 -p 433 -st topic9_2_1 -pt None -u 0.017220556822684308 > ./result_10chains/node9_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_3_2 -p 500 -st topic9_3_1 -pt None -u 0.00773930984675697 > ./result_10chains/node9_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_4_2 -p 512 -st topic9_4_1 -pt None -u 0.04582246811261881 > ./result_10chains/node9_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_5_2 -p 566 -st topic9_5_1 -pt None -u 0.006540627046464714 > ./result_10chains/node9_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_6_2 -p 596 -st topic9_6_1 -pt None -u 0.007336718317516533 > ./result_10chains/node9_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_7_2 -p 701 -st topic9_7_1 -pt None -u 0.05943576326683002 > ./result_10chains/node9_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_8_2 -p 856 -st topic9_8_1 -pt None -u 0.030875411583282664 > ./result_10chains/node9_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_9_2 -p 928 -st topic9_9_1 -pt None -u 0.004169201936056323 > ./result_10chains/node9_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_0_0 -p 24 -st none -pt topic9_0_0 -u 0.0012796716032074662 > ./result_10chains/node9_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_1_0 -p 408 -st none -pt topic9_1_0 -u 0.019910371180908826 > ./result_10chains/node9_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_2_0 -p 433 -st none -pt topic9_2_0 -u 0.016121444074574054 > ./result_10chains/node9_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_3_0 -p 500 -st none -pt topic9_3_0 -u 0.0013598827698811933 > ./result_10chains/node9_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_4_0 -p 512 -st none -pt topic9_4_0 -u 0.03785113467158385 > ./result_10chains/node9_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_5_0 -p 566 -st none -pt topic9_5_0 -u 0.011843056586209405 > ./result_10chains/node9_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_6_0 -p 596 -st none -pt topic9_6_0 -u 0.009483341901358355 > ./result_10chains/node9_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_7_0 -p 701 -st none -pt topic9_7_0 -u 0.01866529817765239 > ./result_10chains/node9_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_8_0 -p 856 -st none -pt topic9_8_0 -u 0.02700378982945928 > ./result_10chains/node9_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_9_0 -p 928 -st none -pt topic9_9_0 -u 0.004514815990017946 > ./result_10chains/node9_9_0.txt &
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
    "./result_10chains/node9_0_0.txt 90"
    "./result_10chains/node9_0_2.txt 90"
    "./result_10chains/node9_1_0.txt 89"
    "./result_10chains/node9_1_2.txt 89"
    "./result_10chains/node9_2_0.txt 88"
    "./result_10chains/node9_2_2.txt 88"
    "./result_10chains/node9_3_0.txt 87"
    "./result_10chains/node9_3_2.txt 87"
    "./result_10chains/node9_4_0.txt 86"
    "./result_10chains/node9_4_2.txt 86"
    "./result_10chains/node9_5_0.txt 85"
    "./result_10chains/node9_5_2.txt 85"
    "./result_10chains/node9_6_0.txt 84"
    "./result_10chains/node9_6_2.txt 84"
    "./result_10chains/node9_7_0.txt 83"
    "./result_10chains/node9_7_2.txt 83"
    "./result_10chains/node9_8_0.txt 82"
    "./result_10chains/node9_8_2.txt 82"
    "./result_10chains/node9_9_0.txt 81"
    "./result_10chains/node9_9_2.txt 81"
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
