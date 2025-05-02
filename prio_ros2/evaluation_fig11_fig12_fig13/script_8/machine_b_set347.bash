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
ros2 run evaluation_3_randomdag uunifast_node -n node347_0_1 -p 23 -st topic347_0_0 -pt topic347_0_1 -u 0.0021862572872715647 > ./result_8chains/node347_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_1_1 -p 43 -st topic347_1_0 -pt topic347_1_1 -u 0.031656516237680676 > ./result_8chains/node347_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_2_1 -p 324 -st topic347_2_0 -pt topic347_2_1 -u 0.03404956212779858 > ./result_8chains/node347_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_3_1 -p 361 -st topic347_3_0 -pt topic347_3_1 -u 0.03938340745992713 > ./result_8chains/node347_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_4_1 -p 468 -st topic347_4_0 -pt topic347_4_1 -u 0.0067764282226397965 > ./result_8chains/node347_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_5_1 -p 564 -st topic347_5_0 -pt topic347_5_1 -u 0.03016329726772496 > ./result_8chains/node347_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_6_1 -p 748 -st topic347_6_0 -pt topic347_6_1 -u 0.017151997877171393 > ./result_8chains/node347_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_7_1 -p 861 -st topic347_7_0 -pt topic347_7_1 -u 0.027966085166765225 > ./result_8chains/node347_7_1.txt &
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
    "./result_8chains/node347_0_1.txt 90"
    "./result_8chains/node347_1_1.txt 89"
    "./result_8chains/node347_2_1.txt 88"
    "./result_8chains/node347_3_1.txt 87"
    "./result_8chains/node347_4_1.txt 86"
    "./result_8chains/node347_5_1.txt 85"
    "./result_8chains/node347_6_1.txt 84"
    "./result_8chains/node347_7_1.txt 83"
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
