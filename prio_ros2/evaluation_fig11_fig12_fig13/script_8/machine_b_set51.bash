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
ros2 run evaluation_3_randomdag uunifast_node -n node51_0_1 -p 188 -st topic51_0_0 -pt topic51_0_1 -u 0.027938383444316983 > ./result_8chains/node51_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_1_1 -p 196 -st topic51_1_0 -pt topic51_1_1 -u 0.004650018985647597 > ./result_8chains/node51_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_2_1 -p 259 -st topic51_2_0 -pt topic51_2_1 -u 0.009856745642301323 > ./result_8chains/node51_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_3_1 -p 271 -st topic51_3_0 -pt topic51_3_1 -u 0.0033659560980671688 > ./result_8chains/node51_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_4_1 -p 498 -st topic51_4_0 -pt topic51_4_1 -u 0.043854235961884425 > ./result_8chains/node51_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_5_1 -p 647 -st topic51_5_0 -pt topic51_5_1 -u 0.00921740155293399 > ./result_8chains/node51_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_6_1 -p 806 -st topic51_6_0 -pt topic51_6_1 -u 0.004694657510079234 > ./result_8chains/node51_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_7_1 -p 867 -st topic51_7_0 -pt topic51_7_1 -u 0.03139060577761894 > ./result_8chains/node51_7_1.txt &
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
    "./result_8chains/node51_0_1.txt 90"
    "./result_8chains/node51_1_1.txt 89"
    "./result_8chains/node51_2_1.txt 88"
    "./result_8chains/node51_3_1.txt 87"
    "./result_8chains/node51_4_1.txt 86"
    "./result_8chains/node51_5_1.txt 85"
    "./result_8chains/node51_6_1.txt 84"
    "./result_8chains/node51_7_1.txt 83"
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
