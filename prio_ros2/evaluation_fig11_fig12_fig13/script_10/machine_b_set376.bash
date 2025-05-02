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
ros2 run evaluation_3_randomdag uunifast_node -n node376_0_1 -p 48 -st topic376_0_0 -pt topic376_0_1 -u 0.004724833253487104 > ./result_10chains/node376_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_1_1 -p 302 -st topic376_1_0 -pt topic376_1_1 -u 0.001581195923968659 > ./result_10chains/node376_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_2_1 -p 429 -st topic376_2_0 -pt topic376_2_1 -u 0.03558207650010503 > ./result_10chains/node376_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_3_1 -p 449 -st topic376_3_0 -pt topic376_3_1 -u 0.00846427468126909 > ./result_10chains/node376_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_4_1 -p 470 -st topic376_4_0 -pt topic376_4_1 -u 0.009961584137337387 > ./result_10chains/node376_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_5_1 -p 543 -st topic376_5_0 -pt topic376_5_1 -u 0.018147237121767024 > ./result_10chains/node376_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_6_1 -p 627 -st topic376_6_0 -pt topic376_6_1 -u 0.027556375944589623 > ./result_10chains/node376_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_7_1 -p 639 -st topic376_7_0 -pt topic376_7_1 -u 0.00580166863883344 > ./result_10chains/node376_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_8_1 -p 805 -st topic376_8_0 -pt topic376_8_1 -u 0.003664657484844673 > ./result_10chains/node376_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_9_1 -p 870 -st topic376_9_0 -pt topic376_9_1 -u 0.003340969644409348 > ./result_10chains/node376_9_1.txt &
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
    "./result_10chains/node376_0_1.txt 90"
    "./result_10chains/node376_1_1.txt 89"
    "./result_10chains/node376_2_1.txt 88"
    "./result_10chains/node376_3_1.txt 87"
    "./result_10chains/node376_4_1.txt 86"
    "./result_10chains/node376_5_1.txt 85"
    "./result_10chains/node376_6_1.txt 84"
    "./result_10chains/node376_7_1.txt 83"
    "./result_10chains/node376_8_1.txt 82"
    "./result_10chains/node376_9_1.txt 81"
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
