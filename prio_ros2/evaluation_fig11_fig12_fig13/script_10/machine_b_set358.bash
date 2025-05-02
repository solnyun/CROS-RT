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
ros2 run evaluation_3_randomdag uunifast_node -n node358_0_1 -p 211 -st topic358_0_0 -pt topic358_0_1 -u 0.005100415258032176 > ./result_10chains/node358_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_1_1 -p 230 -st topic358_1_0 -pt topic358_1_1 -u 0.034949566017737244 > ./result_10chains/node358_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_2_1 -p 300 -st topic358_2_0 -pt topic358_2_1 -u 0.04593201289020926 > ./result_10chains/node358_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_3_1 -p 317 -st topic358_3_0 -pt topic358_3_1 -u 0.02309035436798243 > ./result_10chains/node358_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_4_1 -p 378 -st topic358_4_0 -pt topic358_4_1 -u 0.01931737751767243 > ./result_10chains/node358_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_5_1 -p 458 -st topic358_5_0 -pt topic358_5_1 -u 0.0037791654275367015 > ./result_10chains/node358_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_6_1 -p 530 -st topic358_6_0 -pt topic358_6_1 -u 0.0034136976988198564 > ./result_10chains/node358_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_7_1 -p 707 -st topic358_7_0 -pt topic358_7_1 -u 0.03469759486176331 > ./result_10chains/node358_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_8_1 -p 816 -st topic358_8_0 -pt topic358_8_1 -u 0.007935404551848435 > ./result_10chains/node358_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_9_1 -p 908 -st topic358_9_0 -pt topic358_9_1 -u 0.007301286796327779 > ./result_10chains/node358_9_1.txt &
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
    "./result_10chains/node358_0_1.txt 90"
    "./result_10chains/node358_1_1.txt 89"
    "./result_10chains/node358_2_1.txt 88"
    "./result_10chains/node358_3_1.txt 87"
    "./result_10chains/node358_4_1.txt 86"
    "./result_10chains/node358_5_1.txt 85"
    "./result_10chains/node358_6_1.txt 84"
    "./result_10chains/node358_7_1.txt 83"
    "./result_10chains/node358_8_1.txt 82"
    "./result_10chains/node358_9_1.txt 81"
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
