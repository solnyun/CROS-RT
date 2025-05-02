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
ros2 run evaluation_3_randomdag uunifast_node -n node364_0_1 -p 164 -st topic364_0_0 -pt topic364_0_1 -u 0.02647580217197104 > ./result_10chains/node364_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_1_1 -p 306 -st topic364_1_0 -pt topic364_1_1 -u 0.008842847559782319 > ./result_10chains/node364_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_2_1 -p 343 -st topic364_2_0 -pt topic364_2_1 -u 0.006046277706804881 > ./result_10chains/node364_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_3_1 -p 476 -st topic364_3_0 -pt topic364_3_1 -u 0.027165231453689487 > ./result_10chains/node364_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_4_1 -p 481 -st topic364_4_0 -pt topic364_4_1 -u 0.030059350636503057 > ./result_10chains/node364_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_5_1 -p 492 -st topic364_5_0 -pt topic364_5_1 -u 0.021823565280761126 > ./result_10chains/node364_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_6_1 -p 690 -st topic364_6_0 -pt topic364_6_1 -u 0.0034929227128523144 > ./result_10chains/node364_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_7_1 -p 699 -st topic364_7_0 -pt topic364_7_1 -u 0.042325653534140126 > ./result_10chains/node364_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_8_1 -p 717 -st topic364_8_0 -pt topic364_8_1 -u 0.006980548237433715 > ./result_10chains/node364_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_9_1 -p 842 -st topic364_9_0 -pt topic364_9_1 -u 0.004059371279655655 > ./result_10chains/node364_9_1.txt &
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
    "./result_10chains/node364_0_1.txt 90"
    "./result_10chains/node364_1_1.txt 89"
    "./result_10chains/node364_2_1.txt 88"
    "./result_10chains/node364_3_1.txt 87"
    "./result_10chains/node364_4_1.txt 86"
    "./result_10chains/node364_5_1.txt 85"
    "./result_10chains/node364_6_1.txt 84"
    "./result_10chains/node364_7_1.txt 83"
    "./result_10chains/node364_8_1.txt 82"
    "./result_10chains/node364_9_1.txt 81"
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
