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
ros2 run evaluation_3_randomdag uunifast_node -n node280_0_1 -p 46 -st topic280_0_0 -pt topic280_0_1 -u 8.238362984080982e-05 > ./result_6chains/node280_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_1_1 -p 84 -st topic280_1_0 -pt topic280_1_1 -u 0.03821663362175659 > ./result_6chains/node280_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_2_1 -p 143 -st topic280_2_0 -pt topic280_2_1 -u 0.0401194017313502 > ./result_6chains/node280_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_3_1 -p 626 -st topic280_3_0 -pt topic280_3_1 -u 0.007735919127199564 > ./result_6chains/node280_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_4_1 -p 693 -st topic280_4_0 -pt topic280_4_1 -u 0.05356022228433628 > ./result_6chains/node280_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_5_1 -p 709 -st topic280_5_0 -pt topic280_5_1 -u 0.022425507943846887 > ./result_6chains/node280_5_1.txt &
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
    "./result_6chains/node280_0_1.txt 90"
    "./result_6chains/node280_1_1.txt 89"
    "./result_6chains/node280_2_1.txt 88"
    "./result_6chains/node280_3_1.txt 87"
    "./result_6chains/node280_4_1.txt 86"
    "./result_6chains/node280_5_1.txt 85"
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
