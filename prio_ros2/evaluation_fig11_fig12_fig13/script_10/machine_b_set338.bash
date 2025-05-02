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
ros2 run evaluation_3_randomdag uunifast_node -n node338_0_1 -p 16 -st topic338_0_0 -pt topic338_0_1 -u 0.03336842404545648 > ./result_10chains/node338_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_1_1 -p 243 -st topic338_1_0 -pt topic338_1_1 -u 0.0011503114703612094 > ./result_10chains/node338_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_2_1 -p 246 -st topic338_2_0 -pt topic338_2_1 -u 0.04111929966242539 > ./result_10chains/node338_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_3_1 -p 414 -st topic338_3_0 -pt topic338_3_1 -u 0.010498704549275595 > ./result_10chains/node338_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_4_1 -p 699 -st topic338_4_0 -pt topic338_4_1 -u 0.01603729240399887 > ./result_10chains/node338_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_5_1 -p 729 -st topic338_5_0 -pt topic338_5_1 -u 0.03515911599568383 > ./result_10chains/node338_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_6_1 -p 753 -st topic338_6_0 -pt topic338_6_1 -u 0.011764571540439778 > ./result_10chains/node338_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_7_1 -p 803 -st topic338_7_0 -pt topic338_7_1 -u 0.00961631246029368 > ./result_10chains/node338_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_8_1 -p 849 -st topic338_8_0 -pt topic338_8_1 -u 0.005790484246762803 > ./result_10chains/node338_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_9_1 -p 866 -st topic338_9_0 -pt topic338_9_1 -u 0.012108114539512368 > ./result_10chains/node338_9_1.txt &
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
    "./result_10chains/node338_0_1.txt 90"
    "./result_10chains/node338_1_1.txt 89"
    "./result_10chains/node338_2_1.txt 88"
    "./result_10chains/node338_3_1.txt 87"
    "./result_10chains/node338_4_1.txt 86"
    "./result_10chains/node338_5_1.txt 85"
    "./result_10chains/node338_6_1.txt 84"
    "./result_10chains/node338_7_1.txt 83"
    "./result_10chains/node338_8_1.txt 82"
    "./result_10chains/node338_9_1.txt 81"
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
