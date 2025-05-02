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
ros2 run evaluation_3_randomdag uunifast_node -n node2_0_1 -p 58 -st topic2_0_0 -pt topic2_0_1 -u 0.004063324776261423 > ./result_10chains/node2_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node2_1_1 -p 90 -st topic2_1_0 -pt topic2_1_1 -u 0.0368573244151395 > ./result_10chains/node2_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node2_2_1 -p 178 -st topic2_2_0 -pt topic2_2_1 -u 0.00626372273734882 > ./result_10chains/node2_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node2_3_1 -p 241 -st topic2_3_0 -pt topic2_3_1 -u 0.026789316495014315 > ./result_10chains/node2_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node2_4_1 -p 275 -st topic2_4_0 -pt topic2_4_1 -u 0.0007559855857884323 > ./result_10chains/node2_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node2_5_1 -p 648 -st topic2_5_0 -pt topic2_5_1 -u 0.018690346303042893 > ./result_10chains/node2_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node2_6_1 -p 680 -st topic2_6_0 -pt topic2_6_1 -u 0.04214678243583622 > ./result_10chains/node2_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node2_7_1 -p 831 -st topic2_7_0 -pt topic2_7_1 -u 0.0030947894453088876 > ./result_10chains/node2_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node2_8_1 -p 842 -st topic2_8_0 -pt topic2_8_1 -u 0.014249733227822567 > ./result_10chains/node2_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node2_9_1 -p 975 -st topic2_9_0 -pt topic2_9_1 -u 0.02501538692582987 > ./result_10chains/node2_9_1.txt &
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
    "./result_10chains/node2_0_1.txt 90"
    "./result_10chains/node2_1_1.txt 89"
    "./result_10chains/node2_2_1.txt 88"
    "./result_10chains/node2_3_1.txt 87"
    "./result_10chains/node2_4_1.txt 86"
    "./result_10chains/node2_5_1.txt 85"
    "./result_10chains/node2_6_1.txt 84"
    "./result_10chains/node2_7_1.txt 83"
    "./result_10chains/node2_8_1.txt 82"
    "./result_10chains/node2_9_1.txt 81"
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
