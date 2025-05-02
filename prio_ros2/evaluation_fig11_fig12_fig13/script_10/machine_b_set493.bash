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
ros2 run evaluation_3_randomdag uunifast_node -n node493_0_1 -p 188 -st topic493_0_0 -pt topic493_0_1 -u 0.005142008087622163 > ./result_10chains/node493_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_1_1 -p 248 -st topic493_1_0 -pt topic493_1_1 -u 0.048483497504840045 > ./result_10chains/node493_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_2_1 -p 360 -st topic493_2_0 -pt topic493_2_1 -u 0.017027978394103804 > ./result_10chains/node493_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_3_1 -p 422 -st topic493_3_0 -pt topic493_3_1 -u 0.0066876573945537365 > ./result_10chains/node493_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_4_1 -p 527 -st topic493_4_0 -pt topic493_4_1 -u 0.0019253281059860017 > ./result_10chains/node493_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_5_1 -p 712 -st topic493_5_0 -pt topic493_5_1 -u 0.010505808309274167 > ./result_10chains/node493_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_6_1 -p 820 -st topic493_6_0 -pt topic493_6_1 -u 0.025141954425345586 > ./result_10chains/node493_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_7_1 -p 837 -st topic493_7_0 -pt topic493_7_1 -u 0.00519785785382898 > ./result_10chains/node493_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_8_1 -p 848 -st topic493_8_0 -pt topic493_8_1 -u 0.02500213140473314 > ./result_10chains/node493_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_9_1 -p 887 -st topic493_9_0 -pt topic493_9_1 -u 0.006857482170560172 > ./result_10chains/node493_9_1.txt &
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
    "./result_10chains/node493_0_1.txt 90"
    "./result_10chains/node493_1_1.txt 89"
    "./result_10chains/node493_2_1.txt 88"
    "./result_10chains/node493_3_1.txt 87"
    "./result_10chains/node493_4_1.txt 86"
    "./result_10chains/node493_5_1.txt 85"
    "./result_10chains/node493_6_1.txt 84"
    "./result_10chains/node493_7_1.txt 83"
    "./result_10chains/node493_8_1.txt 82"
    "./result_10chains/node493_9_1.txt 81"
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
