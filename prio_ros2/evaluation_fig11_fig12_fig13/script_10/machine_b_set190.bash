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
ros2 run evaluation_3_randomdag uunifast_node -n node190_0_1 -p 77 -st topic190_0_0 -pt topic190_0_1 -u 0.020851257975414317 > ./result_10chains/node190_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_1_1 -p 264 -st topic190_1_0 -pt topic190_1_1 -u 0.0026595449648378344 > ./result_10chains/node190_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_2_1 -p 305 -st topic190_2_0 -pt topic190_2_1 -u 0.0037815182843871087 > ./result_10chains/node190_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_3_1 -p 330 -st topic190_3_0 -pt topic190_3_1 -u 0.006174945422169176 > ./result_10chains/node190_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_4_1 -p 476 -st topic190_4_0 -pt topic190_4_1 -u 0.002244909760625635 > ./result_10chains/node190_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_5_1 -p 487 -st topic190_5_0 -pt topic190_5_1 -u 0.010846994069014237 > ./result_10chains/node190_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_6_1 -p 490 -st topic190_6_0 -pt topic190_6_1 -u 0.004822294323392706 > ./result_10chains/node190_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_7_1 -p 576 -st topic190_7_0 -pt topic190_7_1 -u 0.009603590736601081 > ./result_10chains/node190_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_8_1 -p 579 -st topic190_8_0 -pt topic190_8_1 -u 0.004283501160916997 > ./result_10chains/node190_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_9_1 -p 859 -st topic190_9_0 -pt topic190_9_1 -u 0.009496637433173737 > ./result_10chains/node190_9_1.txt &
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
    "./result_10chains/node190_0_1.txt 90"
    "./result_10chains/node190_1_1.txt 89"
    "./result_10chains/node190_2_1.txt 88"
    "./result_10chains/node190_3_1.txt 87"
    "./result_10chains/node190_4_1.txt 86"
    "./result_10chains/node190_5_1.txt 85"
    "./result_10chains/node190_6_1.txt 84"
    "./result_10chains/node190_7_1.txt 83"
    "./result_10chains/node190_8_1.txt 82"
    "./result_10chains/node190_9_1.txt 81"
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
