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
ros2 run evaluation_3_randomdag uunifast_node -n node462_0_1 -p 31 -st topic462_0_0 -pt topic462_0_1 -u 0.02817190285973553 > ./result_10chains/node462_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_1_1 -p 44 -st topic462_1_0 -pt topic462_1_1 -u 0.001882329318683762 > ./result_10chains/node462_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_2_1 -p 51 -st topic462_2_0 -pt topic462_2_1 -u 0.03511796959475827 > ./result_10chains/node462_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_3_1 -p 180 -st topic462_3_0 -pt topic462_3_1 -u 0.02923870762985109 > ./result_10chains/node462_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_4_1 -p 562 -st topic462_4_0 -pt topic462_4_1 -u 0.01504562642292484 > ./result_10chains/node462_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_5_1 -p 576 -st topic462_5_0 -pt topic462_5_1 -u 0.006598360794015823 > ./result_10chains/node462_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_6_1 -p 605 -st topic462_6_0 -pt topic462_6_1 -u 0.0011722932674930742 > ./result_10chains/node462_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_7_1 -p 750 -st topic462_7_0 -pt topic462_7_1 -u 0.010061613465456337 > ./result_10chains/node462_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_8_1 -p 860 -st topic462_8_0 -pt topic462_8_1 -u 0.005020736448766244 > ./result_10chains/node462_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_9_1 -p 981 -st topic462_9_0 -pt topic462_9_1 -u 0.013778779549832924 > ./result_10chains/node462_9_1.txt &
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
    "./result_10chains/node462_0_1.txt 90"
    "./result_10chains/node462_1_1.txt 89"
    "./result_10chains/node462_2_1.txt 88"
    "./result_10chains/node462_3_1.txt 87"
    "./result_10chains/node462_4_1.txt 86"
    "./result_10chains/node462_5_1.txt 85"
    "./result_10chains/node462_6_1.txt 84"
    "./result_10chains/node462_7_1.txt 83"
    "./result_10chains/node462_8_1.txt 82"
    "./result_10chains/node462_9_1.txt 81"
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
