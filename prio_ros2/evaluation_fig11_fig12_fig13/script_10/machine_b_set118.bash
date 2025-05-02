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
ros2 run evaluation_3_randomdag uunifast_node -n node118_0_1 -p 84 -st topic118_0_0 -pt topic118_0_1 -u 0.004847094743388847 > ./result_10chains/node118_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_1_1 -p 151 -st topic118_1_0 -pt topic118_1_1 -u 0.026336579910211988 > ./result_10chains/node118_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_2_1 -p 156 -st topic118_2_0 -pt topic118_2_1 -u 0.014708695639934766 > ./result_10chains/node118_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_3_1 -p 318 -st topic118_3_0 -pt topic118_3_1 -u 0.0380180235130021 > ./result_10chains/node118_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_4_1 -p 410 -st topic118_4_0 -pt topic118_4_1 -u 0.011090299179894514 > ./result_10chains/node118_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_5_1 -p 677 -st topic118_5_0 -pt topic118_5_1 -u 0.0003492320885992717 > ./result_10chains/node118_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_6_1 -p 723 -st topic118_6_0 -pt topic118_6_1 -u 0.017939782264542264 > ./result_10chains/node118_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_7_1 -p 769 -st topic118_7_0 -pt topic118_7_1 -u 0.02334157707473325 > ./result_10chains/node118_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_8_1 -p 883 -st topic118_8_0 -pt topic118_8_1 -u 0.0034108317968280233 > ./result_10chains/node118_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_9_1 -p 985 -st topic118_9_0 -pt topic118_9_1 -u 0.026749421336584527 > ./result_10chains/node118_9_1.txt &
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
    "./result_10chains/node118_0_1.txt 90"
    "./result_10chains/node118_1_1.txt 89"
    "./result_10chains/node118_2_1.txt 88"
    "./result_10chains/node118_3_1.txt 87"
    "./result_10chains/node118_4_1.txt 86"
    "./result_10chains/node118_5_1.txt 85"
    "./result_10chains/node118_6_1.txt 84"
    "./result_10chains/node118_7_1.txt 83"
    "./result_10chains/node118_8_1.txt 82"
    "./result_10chains/node118_9_1.txt 81"
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
