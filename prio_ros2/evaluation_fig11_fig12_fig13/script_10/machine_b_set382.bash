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
ros2 run evaluation_3_randomdag uunifast_node -n node382_0_1 -p 112 -st topic382_0_0 -pt topic382_0_1 -u 0.05723876222186386 > ./result_10chains/node382_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_1_1 -p 318 -st topic382_1_0 -pt topic382_1_1 -u 0.015642006641166994 > ./result_10chains/node382_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_2_1 -p 401 -st topic382_2_0 -pt topic382_2_1 -u 0.028666662535058174 > ./result_10chains/node382_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_3_1 -p 409 -st topic382_3_0 -pt topic382_3_1 -u 0.008365895584730165 > ./result_10chains/node382_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_4_1 -p 531 -st topic382_4_0 -pt topic382_4_1 -u 0.008071834172434761 > ./result_10chains/node382_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_5_1 -p 537 -st topic382_5_0 -pt topic382_5_1 -u 0.009336678334162685 > ./result_10chains/node382_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_6_1 -p 588 -st topic382_6_0 -pt topic382_6_1 -u 0.016181395074752303 > ./result_10chains/node382_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_7_1 -p 718 -st topic382_7_0 -pt topic382_7_1 -u 0.02105203531154204 > ./result_10chains/node382_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_8_1 -p 774 -st topic382_8_0 -pt topic382_8_1 -u 0.011746166369122665 > ./result_10chains/node382_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_9_1 -p 951 -st topic382_9_0 -pt topic382_9_1 -u 0.015199755284277663 > ./result_10chains/node382_9_1.txt &
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
    "./result_10chains/node382_0_1.txt 90"
    "./result_10chains/node382_1_1.txt 89"
    "./result_10chains/node382_2_1.txt 88"
    "./result_10chains/node382_3_1.txt 87"
    "./result_10chains/node382_4_1.txt 86"
    "./result_10chains/node382_5_1.txt 85"
    "./result_10chains/node382_6_1.txt 84"
    "./result_10chains/node382_7_1.txt 83"
    "./result_10chains/node382_8_1.txt 82"
    "./result_10chains/node382_9_1.txt 81"
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
