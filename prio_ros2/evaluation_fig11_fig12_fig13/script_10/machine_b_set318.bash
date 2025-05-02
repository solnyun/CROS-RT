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
ros2 run evaluation_3_randomdag uunifast_node -n node318_0_1 -p 62 -st topic318_0_0 -pt topic318_0_1 -u 0.027356345814219973 > ./result_10chains/node318_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_1_1 -p 134 -st topic318_1_0 -pt topic318_1_1 -u 0.002813202966771844 > ./result_10chains/node318_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_2_1 -p 148 -st topic318_2_0 -pt topic318_2_1 -u 0.005206561701567747 > ./result_10chains/node318_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_3_1 -p 229 -st topic318_3_0 -pt topic318_3_1 -u 0.022601721042189993 > ./result_10chains/node318_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_4_1 -p 262 -st topic318_4_0 -pt topic318_4_1 -u 0.007229647982038456 > ./result_10chains/node318_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_5_1 -p 467 -st topic318_5_0 -pt topic318_5_1 -u 9.760057013091794e-05 > ./result_10chains/node318_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_6_1 -p 674 -st topic318_6_0 -pt topic318_6_1 -u 0.01954930259201429 > ./result_10chains/node318_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_7_1 -p 793 -st topic318_7_0 -pt topic318_7_1 -u 0.057372273035848936 > ./result_10chains/node318_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_8_1 -p 796 -st topic318_8_0 -pt topic318_8_1 -u 0.03759886784271688 > ./result_10chains/node318_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_9_1 -p 839 -st topic318_9_0 -pt topic318_9_1 -u 0.01903000419810618 > ./result_10chains/node318_9_1.txt &
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
    "./result_10chains/node318_0_1.txt 90"
    "./result_10chains/node318_1_1.txt 89"
    "./result_10chains/node318_2_1.txt 88"
    "./result_10chains/node318_3_1.txt 87"
    "./result_10chains/node318_4_1.txt 86"
    "./result_10chains/node318_5_1.txt 85"
    "./result_10chains/node318_6_1.txt 84"
    "./result_10chains/node318_7_1.txt 83"
    "./result_10chains/node318_8_1.txt 82"
    "./result_10chains/node318_9_1.txt 81"
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
