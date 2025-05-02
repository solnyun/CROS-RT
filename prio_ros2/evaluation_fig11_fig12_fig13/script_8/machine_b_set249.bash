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
ros2 run evaluation_3_randomdag uunifast_node -n node249_0_1 -p 115 -st topic249_0_0 -pt topic249_0_1 -u 0.02338976794259562 > ./result_8chains/node249_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_1_1 -p 349 -st topic249_1_0 -pt topic249_1_1 -u 0.0048349879928364925 > ./result_8chains/node249_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_2_1 -p 494 -st topic249_2_0 -pt topic249_2_1 -u 0.014140363506151887 > ./result_8chains/node249_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_3_1 -p 638 -st topic249_3_0 -pt topic249_3_1 -u 0.09982375281890393 > ./result_8chains/node249_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_4_1 -p 680 -st topic249_4_0 -pt topic249_4_1 -u 0.016854880517513438 > ./result_8chains/node249_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_5_1 -p 820 -st topic249_5_0 -pt topic249_5_1 -u 0.006517095017507163 > ./result_8chains/node249_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_6_1 -p 987 -st topic249_6_0 -pt topic249_6_1 -u 0.03807993873777342 > ./result_8chains/node249_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_7_1 -p 992 -st topic249_7_0 -pt topic249_7_1 -u 0.022962895583871087 > ./result_8chains/node249_7_1.txt &
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
    "./result_8chains/node249_0_1.txt 90"
    "./result_8chains/node249_1_1.txt 89"
    "./result_8chains/node249_2_1.txt 88"
    "./result_8chains/node249_3_1.txt 87"
    "./result_8chains/node249_4_1.txt 86"
    "./result_8chains/node249_5_1.txt 85"
    "./result_8chains/node249_6_1.txt 84"
    "./result_8chains/node249_7_1.txt 83"
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
