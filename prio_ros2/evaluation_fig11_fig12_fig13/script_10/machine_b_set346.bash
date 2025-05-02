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
ros2 run evaluation_3_randomdag uunifast_node -n node346_0_1 -p 29 -st topic346_0_0 -pt topic346_0_1 -u 0.01583565815527893 > ./result_10chains/node346_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_1_1 -p 243 -st topic346_1_0 -pt topic346_1_1 -u 0.0016176859430067636 > ./result_10chains/node346_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_2_1 -p 330 -st topic346_2_0 -pt topic346_2_1 -u 0.018631162517163014 > ./result_10chains/node346_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_3_1 -p 346 -st topic346_3_0 -pt topic346_3_1 -u 0.008827062476446657 > ./result_10chains/node346_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_4_1 -p 493 -st topic346_4_0 -pt topic346_4_1 -u 0.0071982024776773845 > ./result_10chains/node346_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_5_1 -p 516 -st topic346_5_0 -pt topic346_5_1 -u 0.00488018758389519 > ./result_10chains/node346_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_6_1 -p 526 -st topic346_6_0 -pt topic346_6_1 -u 0.012856738944585416 > ./result_10chains/node346_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_7_1 -p 616 -st topic346_7_0 -pt topic346_7_1 -u 0.02074515491989784 > ./result_10chains/node346_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_8_1 -p 747 -st topic346_8_0 -pt topic346_8_1 -u 0.041431520313564354 > ./result_10chains/node346_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_9_1 -p 960 -st topic346_9_0 -pt topic346_9_1 -u 0.0020816912389299974 > ./result_10chains/node346_9_1.txt &
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
    "./result_10chains/node346_0_1.txt 90"
    "./result_10chains/node346_1_1.txt 89"
    "./result_10chains/node346_2_1.txt 88"
    "./result_10chains/node346_3_1.txt 87"
    "./result_10chains/node346_4_1.txt 86"
    "./result_10chains/node346_5_1.txt 85"
    "./result_10chains/node346_6_1.txt 84"
    "./result_10chains/node346_7_1.txt 83"
    "./result_10chains/node346_8_1.txt 82"
    "./result_10chains/node346_9_1.txt 81"
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
