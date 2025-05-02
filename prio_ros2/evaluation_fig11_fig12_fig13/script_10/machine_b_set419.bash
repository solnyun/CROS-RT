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
ros2 run evaluation_3_randomdag uunifast_node -n node419_0_1 -p 94 -st topic419_0_0 -pt topic419_0_1 -u 0.0027193996984051783 > ./result_10chains/node419_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_1_1 -p 134 -st topic419_1_0 -pt topic419_1_1 -u 0.011619082981332629 > ./result_10chains/node419_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_2_1 -p 155 -st topic419_2_0 -pt topic419_2_1 -u 0.009877093930747705 > ./result_10chains/node419_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_3_1 -p 198 -st topic419_3_0 -pt topic419_3_1 -u 0.006853630754049267 > ./result_10chains/node419_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_4_1 -p 246 -st topic419_4_0 -pt topic419_4_1 -u 0.03369500225068328 > ./result_10chains/node419_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_5_1 -p 266 -st topic419_5_0 -pt topic419_5_1 -u 0.015595056476285923 > ./result_10chains/node419_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_6_1 -p 294 -st topic419_6_0 -pt topic419_6_1 -u 0.013354864079788753 > ./result_10chains/node419_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_7_1 -p 416 -st topic419_7_0 -pt topic419_7_1 -u 0.0007838020064111773 > ./result_10chains/node419_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_8_1 -p 475 -st topic419_8_0 -pt topic419_8_1 -u 0.004616665043281534 > ./result_10chains/node419_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_9_1 -p 819 -st topic419_9_0 -pt topic419_9_1 -u 0.007368439588534887 > ./result_10chains/node419_9_1.txt &
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
    "./result_10chains/node419_0_1.txt 90"
    "./result_10chains/node419_1_1.txt 89"
    "./result_10chains/node419_2_1.txt 88"
    "./result_10chains/node419_3_1.txt 87"
    "./result_10chains/node419_4_1.txt 86"
    "./result_10chains/node419_5_1.txt 85"
    "./result_10chains/node419_6_1.txt 84"
    "./result_10chains/node419_7_1.txt 83"
    "./result_10chains/node419_8_1.txt 82"
    "./result_10chains/node419_9_1.txt 81"
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
