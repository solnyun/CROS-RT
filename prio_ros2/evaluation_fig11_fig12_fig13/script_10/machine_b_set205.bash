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
ros2 run evaluation_3_randomdag uunifast_node -n node205_0_1 -p 146 -st topic205_0_0 -pt topic205_0_1 -u 0.012038382343639686 > ./result_10chains/node205_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_1_1 -p 259 -st topic205_1_0 -pt topic205_1_1 -u 0.006075005417045309 > ./result_10chains/node205_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_2_1 -p 307 -st topic205_2_0 -pt topic205_2_1 -u 0.02734318904359928 > ./result_10chains/node205_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_3_1 -p 337 -st topic205_3_0 -pt topic205_3_1 -u 0.004188604481545566 > ./result_10chains/node205_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_4_1 -p 463 -st topic205_4_0 -pt topic205_4_1 -u 0.026833246878343542 > ./result_10chains/node205_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_5_1 -p 620 -st topic205_5_0 -pt topic205_5_1 -u 0.012979631248392381 > ./result_10chains/node205_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_6_1 -p 711 -st topic205_6_0 -pt topic205_6_1 -u 0.0032870525008899254 > ./result_10chains/node205_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_7_1 -p 715 -st topic205_7_0 -pt topic205_7_1 -u 0.00565829407826593 > ./result_10chains/node205_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_8_1 -p 793 -st topic205_8_0 -pt topic205_8_1 -u 0.038890562078100474 > ./result_10chains/node205_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_9_1 -p 837 -st topic205_9_0 -pt topic205_9_1 -u 0.0024628829807778127 > ./result_10chains/node205_9_1.txt &
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
    "./result_10chains/node205_0_1.txt 90"
    "./result_10chains/node205_1_1.txt 89"
    "./result_10chains/node205_2_1.txt 88"
    "./result_10chains/node205_3_1.txt 87"
    "./result_10chains/node205_4_1.txt 86"
    "./result_10chains/node205_5_1.txt 85"
    "./result_10chains/node205_6_1.txt 84"
    "./result_10chains/node205_7_1.txt 83"
    "./result_10chains/node205_8_1.txt 82"
    "./result_10chains/node205_9_1.txt 81"
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
