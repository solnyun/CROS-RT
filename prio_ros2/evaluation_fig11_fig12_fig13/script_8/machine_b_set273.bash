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
ros2 run evaluation_3_randomdag uunifast_node -n node273_0_1 -p 20 -st topic273_0_0 -pt topic273_0_1 -u 0.02330716675132688 > ./result_8chains/node273_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_1_1 -p 22 -st topic273_1_0 -pt topic273_1_1 -u 0.019885922887690755 > ./result_8chains/node273_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_2_1 -p 55 -st topic273_2_0 -pt topic273_2_1 -u 0.006916400004211676 > ./result_8chains/node273_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_3_1 -p 127 -st topic273_3_0 -pt topic273_3_1 -u 0.03525735287568593 > ./result_8chains/node273_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_4_1 -p 206 -st topic273_4_0 -pt topic273_4_1 -u 0.0004074130897141759 > ./result_8chains/node273_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_5_1 -p 397 -st topic273_5_0 -pt topic273_5_1 -u 0.04494700423771292 > ./result_8chains/node273_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_6_1 -p 802 -st topic273_6_0 -pt topic273_6_1 -u 0.07770262637836424 > ./result_8chains/node273_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_7_1 -p 808 -st topic273_7_0 -pt topic273_7_1 -u 0.017696573462395178 > ./result_8chains/node273_7_1.txt &
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
    "./result_8chains/node273_0_1.txt 90"
    "./result_8chains/node273_1_1.txt 89"
    "./result_8chains/node273_2_1.txt 88"
    "./result_8chains/node273_3_1.txt 87"
    "./result_8chains/node273_4_1.txt 86"
    "./result_8chains/node273_5_1.txt 85"
    "./result_8chains/node273_6_1.txt 84"
    "./result_8chains/node273_7_1.txt 83"
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
