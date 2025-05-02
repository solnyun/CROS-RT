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
ros2 run evaluation_3_randomdag uunifast_node -n node284_0_2 -p 435 -st topic284_0_1 -pt None -u 0.008040206926839821 > ./result_4chains/node284_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_1_2 -p 510 -st topic284_1_1 -pt None -u 0.045772476148524976 > ./result_4chains/node284_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_2_2 -p 859 -st topic284_2_1 -pt None -u 0.09575093779724342 > ./result_4chains/node284_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_3_2 -p 895 -st topic284_3_1 -pt None -u 0.03419487461696474 > ./result_4chains/node284_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_0_0 -p 435 -st none -pt topic284_0_0 -u 0.003963741280701427 > ./result_4chains/node284_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_1_0 -p 510 -st none -pt topic284_1_0 -u 6.97925963965007e-05 > ./result_4chains/node284_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_2_0 -p 859 -st none -pt topic284_2_0 -u 0.027213648030180282 > ./result_4chains/node284_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_3_0 -p 895 -st none -pt topic284_3_0 -u 0.009231011815213047 > ./result_4chains/node284_3_0.txt &
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
    "./result_4chains/node284_0_0.txt 90"
    "./result_4chains/node284_0_2.txt 90"
    "./result_4chains/node284_1_0.txt 89"
    "./result_4chains/node284_1_2.txt 89"
    "./result_4chains/node284_2_0.txt 88"
    "./result_4chains/node284_2_2.txt 88"
    "./result_4chains/node284_3_0.txt 87"
    "./result_4chains/node284_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
