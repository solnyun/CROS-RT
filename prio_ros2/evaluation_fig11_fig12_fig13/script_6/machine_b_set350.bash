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
ros2 run evaluation_3_randomdag uunifast_node -n node350_0_1 -p 363 -st topic350_0_0 -pt topic350_0_1 -u 0.02217238337255989 > ./result_6chains/node350_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_1_1 -p 374 -st topic350_1_0 -pt topic350_1_1 -u 0.04448561183642685 > ./result_6chains/node350_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_2_1 -p 612 -st topic350_2_0 -pt topic350_2_1 -u 0.024517501303169292 > ./result_6chains/node350_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_3_1 -p 658 -st topic350_3_0 -pt topic350_3_1 -u 0.05555936396212513 > ./result_6chains/node350_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_4_1 -p 664 -st topic350_4_0 -pt topic350_4_1 -u 0.020317973455315358 > ./result_6chains/node350_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_5_1 -p 958 -st topic350_5_0 -pt topic350_5_1 -u 0.04180243466048901 > ./result_6chains/node350_5_1.txt &
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
    "./result_6chains/node350_0_1.txt 90"
    "./result_6chains/node350_1_1.txt 89"
    "./result_6chains/node350_2_1.txt 88"
    "./result_6chains/node350_3_1.txt 87"
    "./result_6chains/node350_4_1.txt 86"
    "./result_6chains/node350_5_1.txt 85"
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
