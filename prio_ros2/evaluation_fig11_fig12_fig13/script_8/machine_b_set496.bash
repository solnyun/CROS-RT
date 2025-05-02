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
ros2 run evaluation_3_randomdag uunifast_node -n node496_0_1 -p 127 -st topic496_0_0 -pt topic496_0_1 -u 0.0031907548547370213 > ./result_8chains/node496_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_1_1 -p 362 -st topic496_1_0 -pt topic496_1_1 -u 0.020139479988612374 > ./result_8chains/node496_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_2_1 -p 434 -st topic496_2_0 -pt topic496_2_1 -u 0.008749578515571177 > ./result_8chains/node496_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_3_1 -p 486 -st topic496_3_0 -pt topic496_3_1 -u 0.02765749418633684 > ./result_8chains/node496_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_4_1 -p 528 -st topic496_4_0 -pt topic496_4_1 -u 0.024203294811101894 > ./result_8chains/node496_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_5_1 -p 558 -st topic496_5_0 -pt topic496_5_1 -u 0.02989076259478393 > ./result_8chains/node496_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_6_1 -p 640 -st topic496_6_0 -pt topic496_6_1 -u 0.015309685415830485 > ./result_8chains/node496_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_7_1 -p 667 -st topic496_7_0 -pt topic496_7_1 -u 0.02172169711728692 > ./result_8chains/node496_7_1.txt &
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
    "./result_8chains/node496_0_1.txt 90"
    "./result_8chains/node496_1_1.txt 89"
    "./result_8chains/node496_2_1.txt 88"
    "./result_8chains/node496_3_1.txt 87"
    "./result_8chains/node496_4_1.txt 86"
    "./result_8chains/node496_5_1.txt 85"
    "./result_8chains/node496_6_1.txt 84"
    "./result_8chains/node496_7_1.txt 83"
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
