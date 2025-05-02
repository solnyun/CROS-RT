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
ros2 run evaluation_3_randomdag uunifast_node -n node468_0_1 -p 165 -st topic468_0_0 -pt topic468_0_1 -u 0.014567806215111778 > ./result_10chains/node468_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_1_1 -p 246 -st topic468_1_0 -pt topic468_1_1 -u 0.03316753126837718 > ./result_10chains/node468_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_2_1 -p 279 -st topic468_2_0 -pt topic468_2_1 -u 0.007833823825808106 > ./result_10chains/node468_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_3_1 -p 331 -st topic468_3_0 -pt topic468_3_1 -u 0.013739813326376138 > ./result_10chains/node468_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_4_1 -p 349 -st topic468_4_0 -pt topic468_4_1 -u 0.013874294412010352 > ./result_10chains/node468_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_5_1 -p 470 -st topic468_5_0 -pt topic468_5_1 -u 0.005545864118497723 > ./result_10chains/node468_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_6_1 -p 598 -st topic468_6_0 -pt topic468_6_1 -u 0.030110778621532053 > ./result_10chains/node468_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_7_1 -p 931 -st topic468_7_0 -pt topic468_7_1 -u 0.0009811926956218367 > ./result_10chains/node468_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_8_1 -p 954 -st topic468_8_0 -pt topic468_8_1 -u 0.012629014236265515 > ./result_10chains/node468_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node468_9_1 -p 955 -st topic468_9_0 -pt topic468_9_1 -u 0.012034152490897088 > ./result_10chains/node468_9_1.txt &
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
    "./result_10chains/node468_0_1.txt 90"
    "./result_10chains/node468_1_1.txt 89"
    "./result_10chains/node468_2_1.txt 88"
    "./result_10chains/node468_3_1.txt 87"
    "./result_10chains/node468_4_1.txt 86"
    "./result_10chains/node468_5_1.txt 85"
    "./result_10chains/node468_6_1.txt 84"
    "./result_10chains/node468_7_1.txt 83"
    "./result_10chains/node468_8_1.txt 82"
    "./result_10chains/node468_9_1.txt 81"
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
