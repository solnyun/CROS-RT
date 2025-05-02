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
ros2 run evaluation_3_randomdag uunifast_node -n node484_0_1 -p 12 -st topic484_0_0 -pt topic484_0_1 -u 0.021989959168933315 > ./result_10chains/node484_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_1_1 -p 40 -st topic484_1_0 -pt topic484_1_1 -u 0.00229453122288098 > ./result_10chains/node484_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_2_1 -p 147 -st topic484_2_0 -pt topic484_2_1 -u 0.02202076059088831 > ./result_10chains/node484_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_3_1 -p 306 -st topic484_3_0 -pt topic484_3_1 -u 0.003982833870240066 > ./result_10chains/node484_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_4_1 -p 369 -st topic484_4_0 -pt topic484_4_1 -u 0.02275014812227316 > ./result_10chains/node484_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_5_1 -p 391 -st topic484_5_0 -pt topic484_5_1 -u 0.0041053061463232066 > ./result_10chains/node484_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_6_1 -p 707 -st topic484_6_0 -pt topic484_6_1 -u 0.010163632115531701 > ./result_10chains/node484_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_7_1 -p 719 -st topic484_7_0 -pt topic484_7_1 -u 0.007178646883303608 > ./result_10chains/node484_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_8_1 -p 823 -st topic484_8_0 -pt topic484_8_1 -u 0.006235844181687739 > ./result_10chains/node484_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_9_1 -p 868 -st topic484_9_0 -pt topic484_9_1 -u 0.0017207163568846613 > ./result_10chains/node484_9_1.txt &
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
    "./result_10chains/node484_0_1.txt 90"
    "./result_10chains/node484_1_1.txt 89"
    "./result_10chains/node484_2_1.txt 88"
    "./result_10chains/node484_3_1.txt 87"
    "./result_10chains/node484_4_1.txt 86"
    "./result_10chains/node484_5_1.txt 85"
    "./result_10chains/node484_6_1.txt 84"
    "./result_10chains/node484_7_1.txt 83"
    "./result_10chains/node484_8_1.txt 82"
    "./result_10chains/node484_9_1.txt 81"
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
