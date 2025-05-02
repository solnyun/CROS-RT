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
ros2 run evaluation_3_randomdag uunifast_node -n node42_0_1 -p 100 -st topic42_0_0 -pt topic42_0_1 -u 0.04517741187369395 > ./result_8chains/node42_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node42_1_1 -p 219 -st topic42_1_0 -pt topic42_1_1 -u 0.020378576896147194 > ./result_8chains/node42_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node42_2_1 -p 232 -st topic42_2_0 -pt topic42_2_1 -u 0.001809193954635857 > ./result_8chains/node42_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node42_3_1 -p 501 -st topic42_3_0 -pt topic42_3_1 -u 0.014376537881683582 > ./result_8chains/node42_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node42_4_1 -p 507 -st topic42_4_0 -pt topic42_4_1 -u 0.014282964035791268 > ./result_8chains/node42_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node42_5_1 -p 680 -st topic42_5_0 -pt topic42_5_1 -u 0.04365572347774069 > ./result_8chains/node42_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node42_6_1 -p 894 -st topic42_6_0 -pt topic42_6_1 -u 0.05960395265147632 > ./result_8chains/node42_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node42_7_1 -p 967 -st topic42_7_0 -pt topic42_7_1 -u 0.024959886902515833 > ./result_8chains/node42_7_1.txt &
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
    "./result_8chains/node42_0_1.txt 90"
    "./result_8chains/node42_1_1.txt 89"
    "./result_8chains/node42_2_1.txt 88"
    "./result_8chains/node42_3_1.txt 87"
    "./result_8chains/node42_4_1.txt 86"
    "./result_8chains/node42_5_1.txt 85"
    "./result_8chains/node42_6_1.txt 84"
    "./result_8chains/node42_7_1.txt 83"
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
