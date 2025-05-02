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
ros2 run evaluation_3_randomdag uunifast_node -n node225_0_1 -p 662 -st topic225_0_0 -pt topic225_0_1 -u 0.08169775351323061 > ./result_4chains/node225_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_1_1 -p 750 -st topic225_1_0 -pt topic225_1_1 -u 0.04596635625560397 > ./result_4chains/node225_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_2_1 -p 799 -st topic225_2_0 -pt topic225_2_1 -u 0.04500702884509346 > ./result_4chains/node225_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_3_1 -p 804 -st topic225_3_0 -pt topic225_3_1 -u 0.023804039486057638 > ./result_4chains/node225_3_1.txt &
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
    "./result_4chains/node225_0_1.txt 90"
    "./result_4chains/node225_1_1.txt 89"
    "./result_4chains/node225_2_1.txt 88"
    "./result_4chains/node225_3_1.txt 87"
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
