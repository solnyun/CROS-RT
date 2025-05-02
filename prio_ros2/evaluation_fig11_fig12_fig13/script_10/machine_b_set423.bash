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
ros2 run evaluation_3_randomdag uunifast_node -n node423_0_1 -p 275 -st topic423_0_0 -pt topic423_0_1 -u 0.03405581884903364 > ./result_10chains/node423_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_1_1 -p 374 -st topic423_1_0 -pt topic423_1_1 -u 0.0007142670290724573 > ./result_10chains/node423_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_2_1 -p 451 -st topic423_2_0 -pt topic423_2_1 -u 0.006132225943977776 > ./result_10chains/node423_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_3_1 -p 595 -st topic423_3_0 -pt topic423_3_1 -u 0.023931090157412516 > ./result_10chains/node423_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_4_1 -p 674 -st topic423_4_0 -pt topic423_4_1 -u 0.03523904796251348 > ./result_10chains/node423_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_5_1 -p 751 -st topic423_5_0 -pt topic423_5_1 -u 0.004838052975810303 > ./result_10chains/node423_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_6_1 -p 784 -st topic423_6_0 -pt topic423_6_1 -u 0.03305025610969886 > ./result_10chains/node423_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_7_1 -p 890 -st topic423_7_0 -pt topic423_7_1 -u 0.00712051226466931 > ./result_10chains/node423_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_8_1 -p 937 -st topic423_8_0 -pt topic423_8_1 -u 0.021943508619706287 > ./result_10chains/node423_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_9_1 -p 980 -st topic423_9_0 -pt topic423_9_1 -u 0.08205926122797781 > ./result_10chains/node423_9_1.txt &
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
    "./result_10chains/node423_0_1.txt 90"
    "./result_10chains/node423_1_1.txt 89"
    "./result_10chains/node423_2_1.txt 88"
    "./result_10chains/node423_3_1.txt 87"
    "./result_10chains/node423_4_1.txt 86"
    "./result_10chains/node423_5_1.txt 85"
    "./result_10chains/node423_6_1.txt 84"
    "./result_10chains/node423_7_1.txt 83"
    "./result_10chains/node423_8_1.txt 82"
    "./result_10chains/node423_9_1.txt 81"
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
