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
ros2 run evaluation_3_randomdag uunifast_node -n node420_0_2 -p 23 -st topic420_0_1 -pt None -u 0.010170904868514963 > ./result_10chains/node420_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_1_2 -p 53 -st topic420_1_1 -pt None -u 0.00018337779769567186 > ./result_10chains/node420_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_2_2 -p 137 -st topic420_2_1 -pt None -u 0.006325396139930106 > ./result_10chains/node420_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_3_2 -p 153 -st topic420_3_1 -pt None -u 0.02069907891907402 > ./result_10chains/node420_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_4_2 -p 196 -st topic420_4_1 -pt None -u 0.016368076704226908 > ./result_10chains/node420_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_5_2 -p 315 -st topic420_5_1 -pt None -u 0.004484345374517418 > ./result_10chains/node420_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_6_2 -p 340 -st topic420_6_1 -pt None -u 0.008524195268591023 > ./result_10chains/node420_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_7_2 -p 791 -st topic420_7_1 -pt None -u 0.002227719545062304 > ./result_10chains/node420_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_8_2 -p 793 -st topic420_8_1 -pt None -u 0.027174699254294526 > ./result_10chains/node420_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_9_2 -p 983 -st topic420_9_1 -pt None -u 0.0018689442680141517 > ./result_10chains/node420_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_0_0 -p 23 -st none -pt topic420_0_0 -u 0.03343222993427025 > ./result_10chains/node420_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_1_0 -p 53 -st none -pt topic420_1_0 -u 0.009861962422300419 > ./result_10chains/node420_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_2_0 -p 137 -st none -pt topic420_2_0 -u 0.03182520067154593 > ./result_10chains/node420_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_3_0 -p 153 -st none -pt topic420_3_0 -u 0.0119795315023844 > ./result_10chains/node420_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_4_0 -p 196 -st none -pt topic420_4_0 -u 0.0014286031443361824 > ./result_10chains/node420_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_5_0 -p 315 -st none -pt topic420_5_0 -u 0.01064467939749858 > ./result_10chains/node420_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_6_0 -p 340 -st none -pt topic420_6_0 -u 0.0026561390225290915 > ./result_10chains/node420_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_7_0 -p 791 -st none -pt topic420_7_0 -u 0.014907029373284392 > ./result_10chains/node420_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_8_0 -p 793 -st none -pt topic420_8_0 -u 0.0015445193019016645 > ./result_10chains/node420_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_9_0 -p 983 -st none -pt topic420_9_0 -u 0.0750434981377203 > ./result_10chains/node420_9_0.txt &
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
    "./result_10chains/node420_0_0.txt 90"
    "./result_10chains/node420_0_2.txt 90"
    "./result_10chains/node420_1_0.txt 89"
    "./result_10chains/node420_1_2.txt 89"
    "./result_10chains/node420_2_0.txt 88"
    "./result_10chains/node420_2_2.txt 88"
    "./result_10chains/node420_3_0.txt 87"
    "./result_10chains/node420_3_2.txt 87"
    "./result_10chains/node420_4_0.txt 86"
    "./result_10chains/node420_4_2.txt 86"
    "./result_10chains/node420_5_0.txt 85"
    "./result_10chains/node420_5_2.txt 85"
    "./result_10chains/node420_6_0.txt 84"
    "./result_10chains/node420_6_2.txt 84"
    "./result_10chains/node420_7_0.txt 83"
    "./result_10chains/node420_7_2.txt 83"
    "./result_10chains/node420_8_0.txt 82"
    "./result_10chains/node420_8_2.txt 82"
    "./result_10chains/node420_9_0.txt 81"
    "./result_10chains/node420_9_2.txt 81"
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
