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
ros2 run evaluation_3_randomdag uunifast_node -n node473_0_1 -p 64 -st topic473_0_0 -pt topic473_0_1 -u 0.011198955607874095 > ./result_10chains/node473_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_1_1 -p 237 -st topic473_1_0 -pt topic473_1_1 -u 0.006106841241840522 > ./result_10chains/node473_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_2_1 -p 304 -st topic473_2_0 -pt topic473_2_1 -u 0.020807443648424573 > ./result_10chains/node473_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_3_1 -p 308 -st topic473_3_0 -pt topic473_3_1 -u 0.0008690953214535724 > ./result_10chains/node473_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_4_1 -p 478 -st topic473_4_0 -pt topic473_4_1 -u 0.003381012320338911 > ./result_10chains/node473_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_5_1 -p 587 -st topic473_5_0 -pt topic473_5_1 -u 0.005291832881104769 > ./result_10chains/node473_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_6_1 -p 615 -st topic473_6_0 -pt topic473_6_1 -u 0.022294878304627397 > ./result_10chains/node473_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_7_1 -p 650 -st topic473_7_0 -pt topic473_7_1 -u 0.026636289838255306 > ./result_10chains/node473_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_8_1 -p 822 -st topic473_8_0 -pt topic473_8_1 -u 0.0046912865489271705 > ./result_10chains/node473_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_9_1 -p 977 -st topic473_9_0 -pt topic473_9_1 -u 0.01794392878356721 > ./result_10chains/node473_9_1.txt &
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
    "./result_10chains/node473_0_1.txt 90"
    "./result_10chains/node473_1_1.txt 89"
    "./result_10chains/node473_2_1.txt 88"
    "./result_10chains/node473_3_1.txt 87"
    "./result_10chains/node473_4_1.txt 86"
    "./result_10chains/node473_5_1.txt 85"
    "./result_10chains/node473_6_1.txt 84"
    "./result_10chains/node473_7_1.txt 83"
    "./result_10chains/node473_8_1.txt 82"
    "./result_10chains/node473_9_1.txt 81"
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
