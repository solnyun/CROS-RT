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
ros2 run evaluation_3_randomdag uunifast_node -n node129_0_1 -p 74 -st topic129_0_0 -pt topic129_0_1 -u 0.0037412572442666603 > ./result_10chains/node129_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_1_1 -p 110 -st topic129_1_0 -pt topic129_1_1 -u 0.00014510187183963685 > ./result_10chains/node129_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_2_1 -p 114 -st topic129_2_0 -pt topic129_2_1 -u 0.013364048587501787 > ./result_10chains/node129_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_3_1 -p 134 -st topic129_3_0 -pt topic129_3_1 -u 0.016463402816467687 > ./result_10chains/node129_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_4_1 -p 178 -st topic129_4_0 -pt topic129_4_1 -u 0.004689001110173674 > ./result_10chains/node129_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_5_1 -p 396 -st topic129_5_0 -pt topic129_5_1 -u 0.0054192364357456 > ./result_10chains/node129_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_6_1 -p 555 -st topic129_6_0 -pt topic129_6_1 -u 0.027140570012414794 > ./result_10chains/node129_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_7_1 -p 578 -st topic129_7_0 -pt topic129_7_1 -u 0.004738738122981562 > ./result_10chains/node129_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_8_1 -p 621 -st topic129_8_0 -pt topic129_8_1 -u 0.013166746010037506 > ./result_10chains/node129_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_9_1 -p 950 -st topic129_9_0 -pt topic129_9_1 -u 0.00460999500031228 > ./result_10chains/node129_9_1.txt &
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
    "./result_10chains/node129_0_1.txt 90"
    "./result_10chains/node129_1_1.txt 89"
    "./result_10chains/node129_2_1.txt 88"
    "./result_10chains/node129_3_1.txt 87"
    "./result_10chains/node129_4_1.txt 86"
    "./result_10chains/node129_5_1.txt 85"
    "./result_10chains/node129_6_1.txt 84"
    "./result_10chains/node129_7_1.txt 83"
    "./result_10chains/node129_8_1.txt 82"
    "./result_10chains/node129_9_1.txt 81"
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
