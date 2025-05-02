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
ros2 run evaluation_3_randomdag uunifast_node -n node470_0_1 -p 71 -st topic470_0_0 -pt topic470_0_1 -u 0.0017401453892200713 > ./result_10chains/node470_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_1_1 -p 195 -st topic470_1_0 -pt topic470_1_1 -u 0.007593744389909396 > ./result_10chains/node470_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_2_1 -p 224 -st topic470_2_0 -pt topic470_2_1 -u 0.05070351366120723 > ./result_10chains/node470_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_3_1 -p 254 -st topic470_3_0 -pt topic470_3_1 -u 0.0305021103573202 > ./result_10chains/node470_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_4_1 -p 263 -st topic470_4_0 -pt topic470_4_1 -u 0.01669369066760598 > ./result_10chains/node470_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_5_1 -p 316 -st topic470_5_0 -pt topic470_5_1 -u 0.009622894883644845 > ./result_10chains/node470_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_6_1 -p 457 -st topic470_6_0 -pt topic470_6_1 -u 0.01221403005993793 > ./result_10chains/node470_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_7_1 -p 592 -st topic470_7_0 -pt topic470_7_1 -u 0.007142378154638737 > ./result_10chains/node470_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_8_1 -p 741 -st topic470_8_0 -pt topic470_8_1 -u 0.026743959631217187 > ./result_10chains/node470_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_9_1 -p 841 -st topic470_9_0 -pt topic470_9_1 -u 0.016748591734332956 > ./result_10chains/node470_9_1.txt &
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
    "./result_10chains/node470_0_1.txt 90"
    "./result_10chains/node470_1_1.txt 89"
    "./result_10chains/node470_2_1.txt 88"
    "./result_10chains/node470_3_1.txt 87"
    "./result_10chains/node470_4_1.txt 86"
    "./result_10chains/node470_5_1.txt 85"
    "./result_10chains/node470_6_1.txt 84"
    "./result_10chains/node470_7_1.txt 83"
    "./result_10chains/node470_8_1.txt 82"
    "./result_10chains/node470_9_1.txt 81"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
