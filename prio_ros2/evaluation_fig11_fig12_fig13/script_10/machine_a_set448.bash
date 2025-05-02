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
ros2 run evaluation_3_randomdag uunifast_node -n node448_0_2 -p 130 -st topic448_0_1 -pt None -u 0.01631317365644097 > ./result_10chains/node448_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_1_2 -p 133 -st topic448_1_1 -pt None -u 0.010468299928721059 > ./result_10chains/node448_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_2_2 -p 241 -st topic448_2_1 -pt None -u 0.022158848641044004 > ./result_10chains/node448_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_3_2 -p 446 -st topic448_3_1 -pt None -u 0.025096561296528597 > ./result_10chains/node448_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_4_2 -p 485 -st topic448_4_1 -pt None -u 0.004534914206372587 > ./result_10chains/node448_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_5_2 -p 539 -st topic448_5_1 -pt None -u 0.005366901675707331 > ./result_10chains/node448_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_6_2 -p 779 -st topic448_6_1 -pt None -u 0.018241683412580895 > ./result_10chains/node448_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_7_2 -p 789 -st topic448_7_1 -pt None -u 0.0038432003957338673 > ./result_10chains/node448_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_8_2 -p 829 -st topic448_8_1 -pt None -u 0.05067233793105448 > ./result_10chains/node448_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_9_2 -p 947 -st topic448_9_1 -pt None -u 0.0026980032728795207 > ./result_10chains/node448_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_0_0 -p 130 -st none -pt topic448_0_0 -u 0.004147364489185346 > ./result_10chains/node448_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_1_0 -p 133 -st none -pt topic448_1_0 -u 0.010880048235351991 > ./result_10chains/node448_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_2_0 -p 241 -st none -pt topic448_2_0 -u 0.0021370510406132914 > ./result_10chains/node448_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_3_0 -p 446 -st none -pt topic448_3_0 -u 0.013042215866696572 > ./result_10chains/node448_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_4_0 -p 485 -st none -pt topic448_4_0 -u 0.022490277085143784 > ./result_10chains/node448_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_5_0 -p 539 -st none -pt topic448_5_0 -u 0.02418204974704008 > ./result_10chains/node448_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_6_0 -p 779 -st none -pt topic448_6_0 -u 0.01055627348047225 > ./result_10chains/node448_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_7_0 -p 789 -st none -pt topic448_7_0 -u 0.04919066406636155 > ./result_10chains/node448_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_8_0 -p 829 -st none -pt topic448_8_0 -u 0.025852298592069972 > ./result_10chains/node448_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_9_0 -p 947 -st none -pt topic448_9_0 -u 0.0014948728071688573 > ./result_10chains/node448_9_0.txt &
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
    "./result_10chains/node448_0_0.txt 90"
    "./result_10chains/node448_0_2.txt 90"
    "./result_10chains/node448_1_0.txt 89"
    "./result_10chains/node448_1_2.txt 89"
    "./result_10chains/node448_2_0.txt 88"
    "./result_10chains/node448_2_2.txt 88"
    "./result_10chains/node448_3_0.txt 87"
    "./result_10chains/node448_3_2.txt 87"
    "./result_10chains/node448_4_0.txt 86"
    "./result_10chains/node448_4_2.txt 86"
    "./result_10chains/node448_5_0.txt 85"
    "./result_10chains/node448_5_2.txt 85"
    "./result_10chains/node448_6_0.txt 84"
    "./result_10chains/node448_6_2.txt 84"
    "./result_10chains/node448_7_0.txt 83"
    "./result_10chains/node448_7_2.txt 83"
    "./result_10chains/node448_8_0.txt 82"
    "./result_10chains/node448_8_2.txt 82"
    "./result_10chains/node448_9_0.txt 81"
    "./result_10chains/node448_9_2.txt 81"
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
