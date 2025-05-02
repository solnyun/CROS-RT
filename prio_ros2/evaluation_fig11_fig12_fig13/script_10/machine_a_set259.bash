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
ros2 run evaluation_3_randomdag uunifast_node -n node259_0_2 -p 139 -st topic259_0_1 -pt None -u 0.014132270420889381 > ./result_10chains/node259_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_1_2 -p 193 -st topic259_1_1 -pt None -u 0.005641114323682028 > ./result_10chains/node259_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_2_2 -p 226 -st topic259_2_1 -pt None -u 0.013573294584676099 > ./result_10chains/node259_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_3_2 -p 352 -st topic259_3_1 -pt None -u 0.09037834082591101 > ./result_10chains/node259_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_4_2 -p 375 -st topic259_4_1 -pt None -u 0.0014195856044107724 > ./result_10chains/node259_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_5_2 -p 443 -st topic259_5_1 -pt None -u 0.0005480716533269037 > ./result_10chains/node259_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_6_2 -p 559 -st topic259_6_1 -pt None -u 0.02823621081804381 > ./result_10chains/node259_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_7_2 -p 575 -st topic259_7_1 -pt None -u 0.011659282865209161 > ./result_10chains/node259_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_8_2 -p 620 -st topic259_8_1 -pt None -u 0.00849361220326297 > ./result_10chains/node259_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_9_2 -p 654 -st topic259_9_1 -pt None -u 0.00778386011170598 > ./result_10chains/node259_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_0_0 -p 139 -st none -pt topic259_0_0 -u 0.014109813262908888 > ./result_10chains/node259_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_1_0 -p 193 -st none -pt topic259_1_0 -u 0.007800798046400492 > ./result_10chains/node259_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_2_0 -p 226 -st none -pt topic259_2_0 -u 0.027696808870745826 > ./result_10chains/node259_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_3_0 -p 352 -st none -pt topic259_3_0 -u 0.010534602020678685 > ./result_10chains/node259_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_4_0 -p 375 -st none -pt topic259_4_0 -u 0.01692333035363569 > ./result_10chains/node259_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_5_0 -p 443 -st none -pt topic259_5_0 -u 0.0074057085232985265 > ./result_10chains/node259_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_6_0 -p 559 -st none -pt topic259_6_0 -u 0.0004988937432556795 > ./result_10chains/node259_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_7_0 -p 575 -st none -pt topic259_7_0 -u 0.012231746654116138 > ./result_10chains/node259_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_8_0 -p 620 -st none -pt topic259_8_0 -u 0.027851832973791103 > ./result_10chains/node259_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_9_0 -p 654 -st none -pt topic259_9_0 -u 0.008136537975828789 > ./result_10chains/node259_9_0.txt &
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
    "./result_10chains/node259_0_0.txt 90"
    "./result_10chains/node259_0_2.txt 90"
    "./result_10chains/node259_1_0.txt 89"
    "./result_10chains/node259_1_2.txt 89"
    "./result_10chains/node259_2_0.txt 88"
    "./result_10chains/node259_2_2.txt 88"
    "./result_10chains/node259_3_0.txt 87"
    "./result_10chains/node259_3_2.txt 87"
    "./result_10chains/node259_4_0.txt 86"
    "./result_10chains/node259_4_2.txt 86"
    "./result_10chains/node259_5_0.txt 85"
    "./result_10chains/node259_5_2.txt 85"
    "./result_10chains/node259_6_0.txt 84"
    "./result_10chains/node259_6_2.txt 84"
    "./result_10chains/node259_7_0.txt 83"
    "./result_10chains/node259_7_2.txt 83"
    "./result_10chains/node259_8_0.txt 82"
    "./result_10chains/node259_8_2.txt 82"
    "./result_10chains/node259_9_0.txt 81"
    "./result_10chains/node259_9_2.txt 81"
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
