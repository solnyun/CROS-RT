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
ros2 run evaluation_3_randomdag uunifast_node -n node166_0_1 -p 10 -st topic166_0_0 -pt topic166_0_1 -u 0.010282281963745976 > ./result_10chains/node166_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_1_1 -p 68 -st topic166_1_0 -pt topic166_1_1 -u 0.017782468292616482 > ./result_10chains/node166_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_2_1 -p 223 -st topic166_2_0 -pt topic166_2_1 -u 0.011010242419797367 > ./result_10chains/node166_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_3_1 -p 245 -st topic166_3_0 -pt topic166_3_1 -u 0.004877414770642685 > ./result_10chains/node166_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_4_1 -p 308 -st topic166_4_0 -pt topic166_4_1 -u 0.005189857207134441 > ./result_10chains/node166_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_5_1 -p 469 -st topic166_5_0 -pt topic166_5_1 -u 0.032244149272912026 > ./result_10chains/node166_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_6_1 -p 624 -st topic166_6_0 -pt topic166_6_1 -u 0.04061551167642927 > ./result_10chains/node166_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_7_1 -p 691 -st topic166_7_0 -pt topic166_7_1 -u 0.02592768325206196 > ./result_10chains/node166_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_8_1 -p 694 -st topic166_8_0 -pt topic166_8_1 -u 0.012695169531818193 > ./result_10chains/node166_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_9_1 -p 868 -st topic166_9_0 -pt topic166_9_1 -u 0.006235818589168159 > ./result_10chains/node166_9_1.txt &
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
    "./result_10chains/node166_0_1.txt 90"
    "./result_10chains/node166_1_1.txt 89"
    "./result_10chains/node166_2_1.txt 88"
    "./result_10chains/node166_3_1.txt 87"
    "./result_10chains/node166_4_1.txt 86"
    "./result_10chains/node166_5_1.txt 85"
    "./result_10chains/node166_6_1.txt 84"
    "./result_10chains/node166_7_1.txt 83"
    "./result_10chains/node166_8_1.txt 82"
    "./result_10chains/node166_9_1.txt 81"
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
