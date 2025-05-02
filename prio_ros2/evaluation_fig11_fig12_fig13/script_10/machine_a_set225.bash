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
ros2 run evaluation_3_randomdag uunifast_node -n node225_0_2 -p 119 -st topic225_0_1 -pt None -u 0.001635150367198579 > ./result_10chains/node225_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_1_2 -p 239 -st topic225_1_1 -pt None -u 0.0483533850101317 > ./result_10chains/node225_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_2_2 -p 254 -st topic225_2_1 -pt None -u 0.014201898036080018 > ./result_10chains/node225_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_3_2 -p 257 -st topic225_3_1 -pt None -u 0.001749433844851489 > ./result_10chains/node225_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_4_2 -p 423 -st topic225_4_1 -pt None -u 0.058636227541857266 > ./result_10chains/node225_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_5_2 -p 592 -st topic225_5_1 -pt None -u 0.02965688519459994 > ./result_10chains/node225_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_6_2 -p 640 -st topic225_6_1 -pt None -u 0.015772421621308694 > ./result_10chains/node225_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_7_2 -p 839 -st topic225_7_1 -pt None -u 0.005774447672126898 > ./result_10chains/node225_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_8_2 -p 850 -st topic225_8_1 -pt None -u 0.0072066812494079105 > ./result_10chains/node225_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_9_2 -p 882 -st topic225_9_1 -pt None -u 0.00364644682388041 > ./result_10chains/node225_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_0_0 -p 119 -st none -pt topic225_0_0 -u 0.0039595212362626975 > ./result_10chains/node225_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_1_0 -p 239 -st none -pt topic225_1_0 -u 0.0012336400808816705 > ./result_10chains/node225_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_2_0 -p 254 -st none -pt topic225_2_0 -u 0.0003031385170038092 > ./result_10chains/node225_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_3_0 -p 257 -st none -pt topic225_3_0 -u 0.012741342514848375 > ./result_10chains/node225_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_4_0 -p 423 -st none -pt topic225_4_0 -u 0.0032336148574654278 > ./result_10chains/node225_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_5_0 -p 592 -st none -pt topic225_5_0 -u 0.03135164605344623 > ./result_10chains/node225_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_6_0 -p 640 -st none -pt topic225_6_0 -u 0.01784179162148808 > ./result_10chains/node225_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_7_0 -p 839 -st none -pt topic225_7_0 -u 0.003200087820833905 > ./result_10chains/node225_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_8_0 -p 850 -st none -pt topic225_8_0 -u 0.014906913507088664 > ./result_10chains/node225_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_9_0 -p 882 -st none -pt topic225_9_0 -u 0.023773678434142683 > ./result_10chains/node225_9_0.txt &
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
    "./result_10chains/node225_0_0.txt 90"
    "./result_10chains/node225_0_2.txt 90"
    "./result_10chains/node225_1_0.txt 89"
    "./result_10chains/node225_1_2.txt 89"
    "./result_10chains/node225_2_0.txt 88"
    "./result_10chains/node225_2_2.txt 88"
    "./result_10chains/node225_3_0.txt 87"
    "./result_10chains/node225_3_2.txt 87"
    "./result_10chains/node225_4_0.txt 86"
    "./result_10chains/node225_4_2.txt 86"
    "./result_10chains/node225_5_0.txt 85"
    "./result_10chains/node225_5_2.txt 85"
    "./result_10chains/node225_6_0.txt 84"
    "./result_10chains/node225_6_2.txt 84"
    "./result_10chains/node225_7_0.txt 83"
    "./result_10chains/node225_7_2.txt 83"
    "./result_10chains/node225_8_0.txt 82"
    "./result_10chains/node225_8_2.txt 82"
    "./result_10chains/node225_9_0.txt 81"
    "./result_10chains/node225_9_2.txt 81"
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
