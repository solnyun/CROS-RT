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
ros2 run evaluation_3_randomdag uunifast_node -n node39_0_1 -p 18 -st topic39_0_0 -pt topic39_0_1 -u 0.004068848067187103 > ./result_10chains/node39_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node39_1_1 -p 78 -st topic39_1_0 -pt topic39_1_1 -u 0.0015209331893101807 > ./result_10chains/node39_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node39_2_1 -p 140 -st topic39_2_0 -pt topic39_2_1 -u 0.009795020124689469 > ./result_10chains/node39_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node39_3_1 -p 304 -st topic39_3_0 -pt topic39_3_1 -u 0.016851419691777947 > ./result_10chains/node39_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node39_4_1 -p 430 -st topic39_4_0 -pt topic39_4_1 -u 0.007301721764859104 > ./result_10chains/node39_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node39_5_1 -p 485 -st topic39_5_0 -pt topic39_5_1 -u 0.014463187648200926 > ./result_10chains/node39_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node39_6_1 -p 655 -st topic39_6_0 -pt topic39_6_1 -u 0.0013588596930693142 > ./result_10chains/node39_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node39_7_1 -p 823 -st topic39_7_0 -pt topic39_7_1 -u 0.07740227715229696 > ./result_10chains/node39_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node39_8_1 -p 876 -st topic39_8_0 -pt topic39_8_1 -u 0.060681707597626616 > ./result_10chains/node39_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node39_9_1 -p 940 -st topic39_9_0 -pt topic39_9_1 -u 3.383425193439343e-05 > ./result_10chains/node39_9_1.txt &
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
    "./result_10chains/node39_0_1.txt 90"
    "./result_10chains/node39_1_1.txt 89"
    "./result_10chains/node39_2_1.txt 88"
    "./result_10chains/node39_3_1.txt 87"
    "./result_10chains/node39_4_1.txt 86"
    "./result_10chains/node39_5_1.txt 85"
    "./result_10chains/node39_6_1.txt 84"
    "./result_10chains/node39_7_1.txt 83"
    "./result_10chains/node39_8_1.txt 82"
    "./result_10chains/node39_9_1.txt 81"
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
