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
ros2 run evaluation_3_randomdag uunifast_node -n node360_0_1 -p 76 -st topic360_0_0 -pt topic360_0_1 -u 0.01325079809073304 > ./result_8chains/node360_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_1_1 -p 88 -st topic360_1_0 -pt topic360_1_1 -u 0.08661937648632828 > ./result_8chains/node360_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_2_1 -p 619 -st topic360_2_0 -pt topic360_2_1 -u 0.005539312078340131 > ./result_8chains/node360_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_3_1 -p 644 -st topic360_3_0 -pt topic360_3_1 -u 0.009974695074581985 > ./result_8chains/node360_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_4_1 -p 716 -st topic360_4_0 -pt topic360_4_1 -u 0.027586432506841285 > ./result_8chains/node360_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_5_1 -p 718 -st topic360_5_0 -pt topic360_5_1 -u 0.019332109814859527 > ./result_8chains/node360_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_6_1 -p 853 -st topic360_6_0 -pt topic360_6_1 -u 0.016323478637422728 > ./result_8chains/node360_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_7_1 -p 910 -st topic360_7_0 -pt topic360_7_1 -u 0.038140452725081896 > ./result_8chains/node360_7_1.txt &
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
    "./result_8chains/node360_0_1.txt 90"
    "./result_8chains/node360_1_1.txt 89"
    "./result_8chains/node360_2_1.txt 88"
    "./result_8chains/node360_3_1.txt 87"
    "./result_8chains/node360_4_1.txt 86"
    "./result_8chains/node360_5_1.txt 85"
    "./result_8chains/node360_6_1.txt 84"
    "./result_8chains/node360_7_1.txt 83"
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
