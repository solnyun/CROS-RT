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
ros2 run evaluation_3_randomdag uunifast_node -n node251_0_1 -p 250 -st topic251_0_0 -pt topic251_0_1 -u 0.055364684878802084 > ./result_8chains/node251_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_1_1 -p 360 -st topic251_1_0 -pt topic251_1_1 -u 0.011691409667802022 > ./result_8chains/node251_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_2_1 -p 490 -st topic251_2_0 -pt topic251_2_1 -u 0.008480279602795848 > ./result_8chains/node251_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_3_1 -p 552 -st topic251_3_0 -pt topic251_3_1 -u 0.014355904026132904 > ./result_8chains/node251_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_4_1 -p 642 -st topic251_4_0 -pt topic251_4_1 -u 0.03278211181494245 > ./result_8chains/node251_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_5_1 -p 769 -st topic251_5_0 -pt topic251_5_1 -u 0.011063262824465236 > ./result_8chains/node251_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_6_1 -p 813 -st topic251_6_0 -pt topic251_6_1 -u 0.02620601676248402 > ./result_8chains/node251_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_7_1 -p 830 -st topic251_7_0 -pt topic251_7_1 -u 0.014407389128412704 > ./result_8chains/node251_7_1.txt &
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
    "./result_8chains/node251_0_1.txt 90"
    "./result_8chains/node251_1_1.txt 89"
    "./result_8chains/node251_2_1.txt 88"
    "./result_8chains/node251_3_1.txt 87"
    "./result_8chains/node251_4_1.txt 86"
    "./result_8chains/node251_5_1.txt 85"
    "./result_8chains/node251_6_1.txt 84"
    "./result_8chains/node251_7_1.txt 83"
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
