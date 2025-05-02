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
ros2 run evaluation_3_randomdag uunifast_node -n node123_0_1 -p 202 -st topic123_0_0 -pt topic123_0_1 -u 0.03722924726144383 > ./result_6chains/node123_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_1_1 -p 420 -st topic123_1_0 -pt topic123_1_1 -u 0.015943523118478853 > ./result_6chains/node123_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_2_1 -p 465 -st topic123_2_0 -pt topic123_2_1 -u 0.03604948892730908 > ./result_6chains/node123_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_3_1 -p 486 -st topic123_3_0 -pt topic123_3_1 -u 0.00017020419291108313 > ./result_6chains/node123_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_4_1 -p 738 -st topic123_4_0 -pt topic123_4_1 -u 0.10170303167385289 > ./result_6chains/node123_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_5_1 -p 756 -st topic123_5_0 -pt topic123_5_1 -u 0.0501695711078993 > ./result_6chains/node123_5_1.txt &
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
    "./result_6chains/node123_0_1.txt 90"
    "./result_6chains/node123_1_1.txt 89"
    "./result_6chains/node123_2_1.txt 88"
    "./result_6chains/node123_3_1.txt 87"
    "./result_6chains/node123_4_1.txt 86"
    "./result_6chains/node123_5_1.txt 85"
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
