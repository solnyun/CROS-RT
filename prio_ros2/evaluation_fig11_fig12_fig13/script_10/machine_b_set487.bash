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
ros2 run evaluation_3_randomdag uunifast_node -n node487_0_1 -p 47 -st topic487_0_0 -pt topic487_0_1 -u 0.021667239437092145 > ./result_10chains/node487_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_1_1 -p 91 -st topic487_1_0 -pt topic487_1_1 -u 0.03591404196358888 > ./result_10chains/node487_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_2_1 -p 97 -st topic487_2_0 -pt topic487_2_1 -u 0.03267469572594239 > ./result_10chains/node487_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_3_1 -p 106 -st topic487_3_0 -pt topic487_3_1 -u 0.007227836325184311 > ./result_10chains/node487_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_4_1 -p 159 -st topic487_4_0 -pt topic487_4_1 -u 0.004685565487095589 > ./result_10chains/node487_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_5_1 -p 333 -st topic487_5_0 -pt topic487_5_1 -u 0.0006314131180769067 > ./result_10chains/node487_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_6_1 -p 494 -st topic487_6_0 -pt topic487_6_1 -u 0.02635534026008099 > ./result_10chains/node487_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_7_1 -p 689 -st topic487_7_0 -pt topic487_7_1 -u 0.005036408164177178 > ./result_10chains/node487_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_8_1 -p 858 -st topic487_8_0 -pt topic487_8_1 -u 0.002753863500130571 > ./result_10chains/node487_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_9_1 -p 904 -st topic487_9_0 -pt topic487_9_1 -u 0.018621873245354494 > ./result_10chains/node487_9_1.txt &
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
    "./result_10chains/node487_0_1.txt 90"
    "./result_10chains/node487_1_1.txt 89"
    "./result_10chains/node487_2_1.txt 88"
    "./result_10chains/node487_3_1.txt 87"
    "./result_10chains/node487_4_1.txt 86"
    "./result_10chains/node487_5_1.txt 85"
    "./result_10chains/node487_6_1.txt 84"
    "./result_10chains/node487_7_1.txt 83"
    "./result_10chains/node487_8_1.txt 82"
    "./result_10chains/node487_9_1.txt 81"
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
