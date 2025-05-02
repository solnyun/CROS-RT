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
ros2 run evaluation_3_randomdag uunifast_node -n node303_0_1 -p 49 -st topic303_0_0 -pt topic303_0_1 -u 0.08380484844953351 > ./result_10chains/node303_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_1_1 -p 70 -st topic303_1_0 -pt topic303_1_1 -u 0.018147559938832658 > ./result_10chains/node303_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_2_1 -p 163 -st topic303_2_0 -pt topic303_2_1 -u 0.002333059328419318 > ./result_10chains/node303_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_3_1 -p 246 -st topic303_3_0 -pt topic303_3_1 -u 0.02269966174435223 > ./result_10chains/node303_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_4_1 -p 491 -st topic303_4_0 -pt topic303_4_1 -u 0.002452777789620275 > ./result_10chains/node303_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_5_1 -p 505 -st topic303_5_0 -pt topic303_5_1 -u 0.011549735994904525 > ./result_10chains/node303_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_6_1 -p 512 -st topic303_6_0 -pt topic303_6_1 -u 0.03588932383282442 > ./result_10chains/node303_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_7_1 -p 599 -st topic303_7_0 -pt topic303_7_1 -u 0.0031862117280807983 > ./result_10chains/node303_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_8_1 -p 703 -st topic303_8_0 -pt topic303_8_1 -u 0.023922433300269337 > ./result_10chains/node303_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_9_1 -p 806 -st topic303_9_0 -pt topic303_9_1 -u 0.0016300866918539658 > ./result_10chains/node303_9_1.txt &
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
    "./result_10chains/node303_0_1.txt 90"
    "./result_10chains/node303_1_1.txt 89"
    "./result_10chains/node303_2_1.txt 88"
    "./result_10chains/node303_3_1.txt 87"
    "./result_10chains/node303_4_1.txt 86"
    "./result_10chains/node303_5_1.txt 85"
    "./result_10chains/node303_6_1.txt 84"
    "./result_10chains/node303_7_1.txt 83"
    "./result_10chains/node303_8_1.txt 82"
    "./result_10chains/node303_9_1.txt 81"
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
