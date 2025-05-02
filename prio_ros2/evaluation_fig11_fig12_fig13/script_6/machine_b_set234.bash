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
ros2 run evaluation_3_randomdag uunifast_node -n node234_0_1 -p 343 -st topic234_0_0 -pt topic234_0_1 -u 0.009057056100052863 > ./result_6chains/node234_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_1_1 -p 512 -st topic234_1_0 -pt topic234_1_1 -u 0.048205072905811275 > ./result_6chains/node234_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_2_1 -p 718 -st topic234_2_0 -pt topic234_2_1 -u 0.003725161681028155 > ./result_6chains/node234_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_3_1 -p 762 -st topic234_3_0 -pt topic234_3_1 -u 0.005299856056269897 > ./result_6chains/node234_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_4_1 -p 799 -st topic234_4_0 -pt topic234_4_1 -u 5.128068534476782e-06 > ./result_6chains/node234_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_5_1 -p 932 -st topic234_5_0 -pt topic234_5_1 -u 0.018951123038617824 > ./result_6chains/node234_5_1.txt &
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
    "./result_6chains/node234_0_1.txt 90"
    "./result_6chains/node234_1_1.txt 89"
    "./result_6chains/node234_2_1.txt 88"
    "./result_6chains/node234_3_1.txt 87"
    "./result_6chains/node234_4_1.txt 86"
    "./result_6chains/node234_5_1.txt 85"
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
