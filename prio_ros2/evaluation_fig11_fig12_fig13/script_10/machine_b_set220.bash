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
ros2 run evaluation_3_randomdag uunifast_node -n node220_0_1 -p 31 -st topic220_0_0 -pt topic220_0_1 -u 0.01889867939096357 > ./result_10chains/node220_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_1_1 -p 36 -st topic220_1_0 -pt topic220_1_1 -u 0.009641687467802973 > ./result_10chains/node220_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_2_1 -p 99 -st topic220_2_0 -pt topic220_2_1 -u 0.005929354048857416 > ./result_10chains/node220_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_3_1 -p 251 -st topic220_3_0 -pt topic220_3_1 -u 0.04553131320362491 > ./result_10chains/node220_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_4_1 -p 413 -st topic220_4_0 -pt topic220_4_1 -u 0.004919673399010949 > ./result_10chains/node220_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_5_1 -p 555 -st topic220_5_0 -pt topic220_5_1 -u 0.00095299048956346 > ./result_10chains/node220_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_6_1 -p 568 -st topic220_6_0 -pt topic220_6_1 -u 0.03638211684517881 > ./result_10chains/node220_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_7_1 -p 727 -st topic220_7_0 -pt topic220_7_1 -u 0.022520507923433464 > ./result_10chains/node220_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_8_1 -p 948 -st topic220_8_0 -pt topic220_8_1 -u 0.005441233584769504 > ./result_10chains/node220_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_9_1 -p 981 -st topic220_9_0 -pt topic220_9_1 -u 0.017673915336684134 > ./result_10chains/node220_9_1.txt &
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
    "./result_10chains/node220_0_1.txt 90"
    "./result_10chains/node220_1_1.txt 89"
    "./result_10chains/node220_2_1.txt 88"
    "./result_10chains/node220_3_1.txt 87"
    "./result_10chains/node220_4_1.txt 86"
    "./result_10chains/node220_5_1.txt 85"
    "./result_10chains/node220_6_1.txt 84"
    "./result_10chains/node220_7_1.txt 83"
    "./result_10chains/node220_8_1.txt 82"
    "./result_10chains/node220_9_1.txt 81"
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
