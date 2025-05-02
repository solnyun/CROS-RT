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
ros2 run evaluation_3_randomdag uunifast_node -n node451_0_1 -p 28 -st topic451_0_0 -pt topic451_0_1 -u 0.01399165513373346 > ./result_10chains/node451_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_1_1 -p 96 -st topic451_1_0 -pt topic451_1_1 -u 0.02231118419889999 > ./result_10chains/node451_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_2_1 -p 153 -st topic451_2_0 -pt topic451_2_1 -u 0.001512791276072234 > ./result_10chains/node451_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_3_1 -p 209 -st topic451_3_0 -pt topic451_3_1 -u 0.0018516451431748737 > ./result_10chains/node451_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_4_1 -p 347 -st topic451_4_0 -pt topic451_4_1 -u 0.07574733060300365 > ./result_10chains/node451_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_5_1 -p 425 -st topic451_5_0 -pt topic451_5_1 -u 0.08127858543728178 > ./result_10chains/node451_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_6_1 -p 503 -st topic451_6_0 -pt topic451_6_1 -u 0.004017277180938569 > ./result_10chains/node451_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_7_1 -p 520 -st topic451_7_0 -pt topic451_7_1 -u 0.004911322722279718 > ./result_10chains/node451_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_8_1 -p 582 -st topic451_8_0 -pt topic451_8_1 -u 0.002648132597238076 > ./result_10chains/node451_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_9_1 -p 961 -st topic451_9_0 -pt topic451_9_1 -u 0.004957072359286301 > ./result_10chains/node451_9_1.txt &
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
    "./result_10chains/node451_0_1.txt 90"
    "./result_10chains/node451_1_1.txt 89"
    "./result_10chains/node451_2_1.txt 88"
    "./result_10chains/node451_3_1.txt 87"
    "./result_10chains/node451_4_1.txt 86"
    "./result_10chains/node451_5_1.txt 85"
    "./result_10chains/node451_6_1.txt 84"
    "./result_10chains/node451_7_1.txt 83"
    "./result_10chains/node451_8_1.txt 82"
    "./result_10chains/node451_9_1.txt 81"
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
