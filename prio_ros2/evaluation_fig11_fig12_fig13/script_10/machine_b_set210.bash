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
ros2 run evaluation_3_randomdag uunifast_node -n node210_0_1 -p 158 -st topic210_0_0 -pt topic210_0_1 -u 0.0031951770302197646 > ./result_10chains/node210_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_1_1 -p 170 -st topic210_1_0 -pt topic210_1_1 -u 0.007479622123166885 > ./result_10chains/node210_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_2_1 -p 183 -st topic210_2_0 -pt topic210_2_1 -u 0.058030432032827595 > ./result_10chains/node210_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_3_1 -p 217 -st topic210_3_0 -pt topic210_3_1 -u 0.016442578245795814 > ./result_10chains/node210_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_4_1 -p 293 -st topic210_4_0 -pt topic210_4_1 -u 0.004167506299546098 > ./result_10chains/node210_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_5_1 -p 313 -st topic210_5_0 -pt topic210_5_1 -u 0.01790680664715788 > ./result_10chains/node210_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_6_1 -p 495 -st topic210_6_0 -pt topic210_6_1 -u 0.0028240310918144773 > ./result_10chains/node210_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_7_1 -p 615 -st topic210_7_0 -pt topic210_7_1 -u 0.006406550285153995 > ./result_10chains/node210_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_8_1 -p 692 -st topic210_8_0 -pt topic210_8_1 -u 0.020822821213878677 > ./result_10chains/node210_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_9_1 -p 759 -st topic210_9_0 -pt topic210_9_1 -u 0.010663258943003233 > ./result_10chains/node210_9_1.txt &
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
    "./result_10chains/node210_0_1.txt 90"
    "./result_10chains/node210_1_1.txt 89"
    "./result_10chains/node210_2_1.txt 88"
    "./result_10chains/node210_3_1.txt 87"
    "./result_10chains/node210_4_1.txt 86"
    "./result_10chains/node210_5_1.txt 85"
    "./result_10chains/node210_6_1.txt 84"
    "./result_10chains/node210_7_1.txt 83"
    "./result_10chains/node210_8_1.txt 82"
    "./result_10chains/node210_9_1.txt 81"
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
