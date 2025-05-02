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
ros2 run evaluation_3_randomdag uunifast_node -n node436_0_1 -p 146 -st topic436_0_0 -pt topic436_0_1 -u 0.00138106985416514 > ./result_6chains/node436_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_1_1 -p 268 -st topic436_1_0 -pt topic436_1_1 -u 0.03737476512111082 > ./result_6chains/node436_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_2_1 -p 366 -st topic436_2_0 -pt topic436_2_1 -u 0.0044519784297580856 > ./result_6chains/node436_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_3_1 -p 720 -st topic436_3_0 -pt topic436_3_1 -u 0.056254692947403234 > ./result_6chains/node436_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_4_1 -p 765 -st topic436_4_0 -pt topic436_4_1 -u 0.03584909239874015 > ./result_6chains/node436_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_5_1 -p 772 -st topic436_5_0 -pt topic436_5_1 -u 0.04282929338122973 > ./result_6chains/node436_5_1.txt &
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
    "./result_6chains/node436_0_1.txt 90"
    "./result_6chains/node436_1_1.txt 89"
    "./result_6chains/node436_2_1.txt 88"
    "./result_6chains/node436_3_1.txt 87"
    "./result_6chains/node436_4_1.txt 86"
    "./result_6chains/node436_5_1.txt 85"
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
