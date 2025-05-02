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
ros2 run evaluation_3_randomdag uunifast_node -n node297_0_1 -p 45 -st topic297_0_0 -pt topic297_0_1 -u 0.018923865446942856 > ./result_10chains/node297_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_1_1 -p 72 -st topic297_1_0 -pt topic297_1_1 -u 0.0026819294759714563 > ./result_10chains/node297_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_2_1 -p 426 -st topic297_2_0 -pt topic297_2_1 -u 0.01022313178932771 > ./result_10chains/node297_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_3_1 -p 488 -st topic297_3_0 -pt topic297_3_1 -u 0.02103007736984791 > ./result_10chains/node297_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_4_1 -p 517 -st topic297_4_0 -pt topic297_4_1 -u 0.011230377761815069 > ./result_10chains/node297_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_5_1 -p 593 -st topic297_5_0 -pt topic297_5_1 -u 0.016792269084976386 > ./result_10chains/node297_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_6_1 -p 812 -st topic297_6_0 -pt topic297_6_1 -u 0.029168806355534038 > ./result_10chains/node297_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_7_1 -p 897 -st topic297_7_0 -pt topic297_7_1 -u 0.018978505659999104 > ./result_10chains/node297_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_8_1 -p 958 -st topic297_8_0 -pt topic297_8_1 -u 0.04385671808965534 > ./result_10chains/node297_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_9_1 -p 974 -st topic297_9_0 -pt topic297_9_1 -u 1.687759980445458e-05 > ./result_10chains/node297_9_1.txt &
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
    "./result_10chains/node297_0_1.txt 90"
    "./result_10chains/node297_1_1.txt 89"
    "./result_10chains/node297_2_1.txt 88"
    "./result_10chains/node297_3_1.txt 87"
    "./result_10chains/node297_4_1.txt 86"
    "./result_10chains/node297_5_1.txt 85"
    "./result_10chains/node297_6_1.txt 84"
    "./result_10chains/node297_7_1.txt 83"
    "./result_10chains/node297_8_1.txt 82"
    "./result_10chains/node297_9_1.txt 81"
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
