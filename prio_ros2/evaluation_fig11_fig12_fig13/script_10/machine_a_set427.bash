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
ros2 run evaluation_3_randomdag uunifast_node -n node427_0_2 -p 55 -st topic427_0_1 -pt None -u 0.013233892190611718 > ./result_10chains/node427_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_1_2 -p 185 -st topic427_1_1 -pt None -u 0.024507583176356595 > ./result_10chains/node427_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_2_2 -p 230 -st topic427_2_1 -pt None -u 0.005356932104311596 > ./result_10chains/node427_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_3_2 -p 283 -st topic427_3_1 -pt None -u 0.004825905333086744 > ./result_10chains/node427_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_4_2 -p 408 -st topic427_4_1 -pt None -u 0.005650440105949478 > ./result_10chains/node427_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_5_2 -p 419 -st topic427_5_1 -pt None -u 0.04461111098516876 > ./result_10chains/node427_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_6_2 -p 595 -st topic427_6_1 -pt None -u 0.005806731732020232 > ./result_10chains/node427_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_7_2 -p 688 -st topic427_7_1 -pt None -u 0.015519374141383713 > ./result_10chains/node427_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_8_2 -p 940 -st topic427_8_1 -pt None -u 0.041586953714508115 > ./result_10chains/node427_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_9_2 -p 949 -st topic427_9_1 -pt None -u 0.00381696327171626 > ./result_10chains/node427_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_0_0 -p 55 -st none -pt topic427_0_0 -u 0.0050961651822065135 > ./result_10chains/node427_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_1_0 -p 185 -st none -pt topic427_1_0 -u 0.06842668901072269 > ./result_10chains/node427_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_2_0 -p 230 -st none -pt topic427_2_0 -u 0.024252390231855825 > ./result_10chains/node427_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_3_0 -p 283 -st none -pt topic427_3_0 -u 0.024203262029785733 > ./result_10chains/node427_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_4_0 -p 408 -st none -pt topic427_4_0 -u 0.00486285808377529 > ./result_10chains/node427_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_5_0 -p 419 -st none -pt topic427_5_0 -u 0.044852540875603836 > ./result_10chains/node427_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_6_0 -p 595 -st none -pt topic427_6_0 -u 0.0044682142050967155 > ./result_10chains/node427_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_7_0 -p 688 -st none -pt topic427_7_0 -u 0.0070338685896942366 > ./result_10chains/node427_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_8_0 -p 940 -st none -pt topic427_8_0 -u 0.01203943091693399 > ./result_10chains/node427_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_9_0 -p 949 -st none -pt topic427_9_0 -u 0.02534902890925521 > ./result_10chains/node427_9_0.txt &
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
    "./result_10chains/node427_0_0.txt 90"
    "./result_10chains/node427_0_2.txt 90"
    "./result_10chains/node427_1_0.txt 89"
    "./result_10chains/node427_1_2.txt 89"
    "./result_10chains/node427_2_0.txt 88"
    "./result_10chains/node427_2_2.txt 88"
    "./result_10chains/node427_3_0.txt 87"
    "./result_10chains/node427_3_2.txt 87"
    "./result_10chains/node427_4_0.txt 86"
    "./result_10chains/node427_4_2.txt 86"
    "./result_10chains/node427_5_0.txt 85"
    "./result_10chains/node427_5_2.txt 85"
    "./result_10chains/node427_6_0.txt 84"
    "./result_10chains/node427_6_2.txt 84"
    "./result_10chains/node427_7_0.txt 83"
    "./result_10chains/node427_7_2.txt 83"
    "./result_10chains/node427_8_0.txt 82"
    "./result_10chains/node427_8_2.txt 82"
    "./result_10chains/node427_9_0.txt 81"
    "./result_10chains/node427_9_2.txt 81"
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
