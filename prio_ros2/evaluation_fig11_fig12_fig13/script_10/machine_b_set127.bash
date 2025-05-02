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
ros2 run evaluation_3_randomdag uunifast_node -n node127_0_1 -p 68 -st topic127_0_0 -pt topic127_0_1 -u 0.010963180603250411 > ./result_10chains/node127_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_1_1 -p 84 -st topic127_1_0 -pt topic127_1_1 -u 0.004746090938666014 > ./result_10chains/node127_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_2_1 -p 188 -st topic127_2_0 -pt topic127_2_1 -u 0.0008637331038311991 > ./result_10chains/node127_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_3_1 -p 250 -st topic127_3_0 -pt topic127_3_1 -u 0.0023154601091859572 > ./result_10chains/node127_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_4_1 -p 256 -st topic127_4_0 -pt topic127_4_1 -u 0.013605333276935028 > ./result_10chains/node127_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_5_1 -p 297 -st topic127_5_0 -pt topic127_5_1 -u 0.00481106238172796 > ./result_10chains/node127_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_6_1 -p 734 -st topic127_6_0 -pt topic127_6_1 -u 0.024813679154072482 > ./result_10chains/node127_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_7_1 -p 847 -st topic127_7_0 -pt topic127_7_1 -u 0.029744740959177306 > ./result_10chains/node127_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_8_1 -p 932 -st topic127_8_0 -pt topic127_8_1 -u 0.0017480795082077324 > ./result_10chains/node127_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_9_1 -p 972 -st topic127_9_0 -pt topic127_9_1 -u 0.010124888332154115 > ./result_10chains/node127_9_1.txt &
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
    "./result_10chains/node127_0_1.txt 90"
    "./result_10chains/node127_1_1.txt 89"
    "./result_10chains/node127_2_1.txt 88"
    "./result_10chains/node127_3_1.txt 87"
    "./result_10chains/node127_4_1.txt 86"
    "./result_10chains/node127_5_1.txt 85"
    "./result_10chains/node127_6_1.txt 84"
    "./result_10chains/node127_7_1.txt 83"
    "./result_10chains/node127_8_1.txt 82"
    "./result_10chains/node127_9_1.txt 81"
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
