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
ros2 run evaluation_3_randomdag uunifast_node -n node397_0_1 -p 201 -st topic397_0_0 -pt topic397_0_1 -u 0.035934187004836526 > ./result_10chains/node397_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_1_1 -p 231 -st topic397_1_0 -pt topic397_1_1 -u 0.012072371836813311 > ./result_10chains/node397_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_2_1 -p 316 -st topic397_2_0 -pt topic397_2_1 -u 0.02121095312624033 > ./result_10chains/node397_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_3_1 -p 428 -st topic397_3_0 -pt topic397_3_1 -u 0.011623627892509758 > ./result_10chains/node397_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_4_1 -p 596 -st topic397_4_0 -pt topic397_4_1 -u 0.033017995122054056 > ./result_10chains/node397_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_5_1 -p 627 -st topic397_5_0 -pt topic397_5_1 -u 0.019087372838902966 > ./result_10chains/node397_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_6_1 -p 689 -st topic397_6_0 -pt topic397_6_1 -u 0.01477253572097989 > ./result_10chains/node397_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_7_1 -p 690 -st topic397_7_0 -pt topic397_7_1 -u 0.007576054933913168 > ./result_10chains/node397_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_8_1 -p 784 -st topic397_8_0 -pt topic397_8_1 -u 0.006620693416589524 > ./result_10chains/node397_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_9_1 -p 872 -st topic397_9_0 -pt topic397_9_1 -u 0.02580476136770123 > ./result_10chains/node397_9_1.txt &
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
    "./result_10chains/node397_0_1.txt 90"
    "./result_10chains/node397_1_1.txt 89"
    "./result_10chains/node397_2_1.txt 88"
    "./result_10chains/node397_3_1.txt 87"
    "./result_10chains/node397_4_1.txt 86"
    "./result_10chains/node397_5_1.txt 85"
    "./result_10chains/node397_6_1.txt 84"
    "./result_10chains/node397_7_1.txt 83"
    "./result_10chains/node397_8_1.txt 82"
    "./result_10chains/node397_9_1.txt 81"
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
