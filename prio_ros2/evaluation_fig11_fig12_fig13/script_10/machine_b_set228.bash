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
ros2 run evaluation_3_randomdag uunifast_node -n node228_0_1 -p 220 -st topic228_0_0 -pt topic228_0_1 -u 0.0038790348903846583 > ./result_10chains/node228_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_1_1 -p 290 -st topic228_1_0 -pt topic228_1_1 -u 0.0008584381016354947 > ./result_10chains/node228_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_2_1 -p 302 -st topic228_2_0 -pt topic228_2_1 -u 0.0613102440076686 > ./result_10chains/node228_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_3_1 -p 428 -st topic228_3_0 -pt topic228_3_1 -u 0.004108830777999006 > ./result_10chains/node228_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_4_1 -p 498 -st topic228_4_0 -pt topic228_4_1 -u 0.008579049628379742 > ./result_10chains/node228_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_5_1 -p 638 -st topic228_5_0 -pt topic228_5_1 -u 0.027103415706527967 > ./result_10chains/node228_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_6_1 -p 786 -st topic228_6_0 -pt topic228_6_1 -u 0.003796312725215495 > ./result_10chains/node228_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_7_1 -p 815 -st topic228_7_0 -pt topic228_7_1 -u 0.003337326169801258 > ./result_10chains/node228_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_8_1 -p 836 -st topic228_8_0 -pt topic228_8_1 -u 0.008485882378863857 > ./result_10chains/node228_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_9_1 -p 932 -st topic228_9_0 -pt topic228_9_1 -u 0.010829130436837905 > ./result_10chains/node228_9_1.txt &
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
    "./result_10chains/node228_0_1.txt 90"
    "./result_10chains/node228_1_1.txt 89"
    "./result_10chains/node228_2_1.txt 88"
    "./result_10chains/node228_3_1.txt 87"
    "./result_10chains/node228_4_1.txt 86"
    "./result_10chains/node228_5_1.txt 85"
    "./result_10chains/node228_6_1.txt 84"
    "./result_10chains/node228_7_1.txt 83"
    "./result_10chains/node228_8_1.txt 82"
    "./result_10chains/node228_9_1.txt 81"
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
