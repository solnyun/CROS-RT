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
ros2 run evaluation_3_randomdag uunifast_node -n node281_0_1 -p 143 -st topic281_0_0 -pt topic281_0_1 -u 0.005299117619959659 > ./result_6chains/node281_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_1_1 -p 183 -st topic281_1_0 -pt topic281_1_1 -u 0.03971637935923311 > ./result_6chains/node281_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_2_1 -p 257 -st topic281_2_0 -pt topic281_2_1 -u 0.03437151079984163 > ./result_6chains/node281_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_3_1 -p 483 -st topic281_3_0 -pt topic281_3_1 -u 0.051767271000363546 > ./result_6chains/node281_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_4_1 -p 811 -st topic281_4_0 -pt topic281_4_1 -u 0.009528148793753535 > ./result_6chains/node281_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_5_1 -p 818 -st topic281_5_0 -pt topic281_5_1 -u 0.023130358882843774 > ./result_6chains/node281_5_1.txt &
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
    "./result_6chains/node281_0_1.txt 90"
    "./result_6chains/node281_1_1.txt 89"
    "./result_6chains/node281_2_1.txt 88"
    "./result_6chains/node281_3_1.txt 87"
    "./result_6chains/node281_4_1.txt 86"
    "./result_6chains/node281_5_1.txt 85"
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
