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
ros2 run evaluation_3_randomdag uunifast_node -n node395_0_2 -p 11 -st topic395_0_1 -pt None -u 0.01798123233753529 > ./result_10chains/node395_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_1_2 -p 65 -st topic395_1_1 -pt None -u 0.007661204398133337 > ./result_10chains/node395_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_2_2 -p 125 -st topic395_2_1 -pt None -u 0.0012228355575201189 > ./result_10chains/node395_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_3_2 -p 211 -st topic395_3_1 -pt None -u 0.024678057286524835 > ./result_10chains/node395_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_4_2 -p 267 -st topic395_4_1 -pt None -u 0.03272473099130055 > ./result_10chains/node395_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_5_2 -p 325 -st topic395_5_1 -pt None -u 0.0017156009630010793 > ./result_10chains/node395_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_6_2 -p 467 -st topic395_6_1 -pt None -u 0.008590868754224879 > ./result_10chains/node395_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_7_2 -p 712 -st topic395_7_1 -pt None -u 0.012220136371679777 > ./result_10chains/node395_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_8_2 -p 796 -st topic395_8_1 -pt None -u 0.05491665833670366 > ./result_10chains/node395_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_9_2 -p 854 -st topic395_9_1 -pt None -u 0.0038708857845818345 > ./result_10chains/node395_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_0_0 -p 11 -st none -pt topic395_0_0 -u 0.011769506776333816 > ./result_10chains/node395_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_1_0 -p 65 -st none -pt topic395_1_0 -u 0.022388789995969216 > ./result_10chains/node395_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_2_0 -p 125 -st none -pt topic395_2_0 -u 0.010096026819100379 > ./result_10chains/node395_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_3_0 -p 211 -st none -pt topic395_3_0 -u 0.025661026143544763 > ./result_10chains/node395_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_4_0 -p 267 -st none -pt topic395_4_0 -u 0.03571031833351396 > ./result_10chains/node395_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_5_0 -p 325 -st none -pt topic395_5_0 -u 0.003504121332407295 > ./result_10chains/node395_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_6_0 -p 467 -st none -pt topic395_6_0 -u 0.03675440089657869 > ./result_10chains/node395_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_7_0 -p 712 -st none -pt topic395_7_0 -u 0.027337928050171323 > ./result_10chains/node395_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_8_0 -p 796 -st none -pt topic395_8_0 -u 0.001553038570014667 > ./result_10chains/node395_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_9_0 -p 854 -st none -pt topic395_9_0 -u 0.016157310503284367 > ./result_10chains/node395_9_0.txt &
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
    "./result_10chains/node395_0_0.txt 90"
    "./result_10chains/node395_0_2.txt 90"
    "./result_10chains/node395_1_0.txt 89"
    "./result_10chains/node395_1_2.txt 89"
    "./result_10chains/node395_2_0.txt 88"
    "./result_10chains/node395_2_2.txt 88"
    "./result_10chains/node395_3_0.txt 87"
    "./result_10chains/node395_3_2.txt 87"
    "./result_10chains/node395_4_0.txt 86"
    "./result_10chains/node395_4_2.txt 86"
    "./result_10chains/node395_5_0.txt 85"
    "./result_10chains/node395_5_2.txt 85"
    "./result_10chains/node395_6_0.txt 84"
    "./result_10chains/node395_6_2.txt 84"
    "./result_10chains/node395_7_0.txt 83"
    "./result_10chains/node395_7_2.txt 83"
    "./result_10chains/node395_8_0.txt 82"
    "./result_10chains/node395_8_2.txt 82"
    "./result_10chains/node395_9_0.txt 81"
    "./result_10chains/node395_9_2.txt 81"
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
