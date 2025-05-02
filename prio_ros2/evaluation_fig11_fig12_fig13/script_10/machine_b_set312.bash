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
ros2 run evaluation_3_randomdag uunifast_node -n node312_0_1 -p 100 -st topic312_0_0 -pt topic312_0_1 -u 0.015865593041986592 > ./result_10chains/node312_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_1_1 -p 111 -st topic312_1_0 -pt topic312_1_1 -u 0.004029259212917136 > ./result_10chains/node312_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_2_1 -p 118 -st topic312_2_0 -pt topic312_2_1 -u 0.0554826299232381 > ./result_10chains/node312_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_3_1 -p 184 -st topic312_3_0 -pt topic312_3_1 -u 0.0017291817026234835 > ./result_10chains/node312_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_4_1 -p 283 -st topic312_4_0 -pt topic312_4_1 -u 0.00582597414559477 > ./result_10chains/node312_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_5_1 -p 477 -st topic312_5_0 -pt topic312_5_1 -u 0.0010526143829722723 > ./result_10chains/node312_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_6_1 -p 623 -st topic312_6_0 -pt topic312_6_1 -u 0.007288646025104734 > ./result_10chains/node312_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_7_1 -p 753 -st topic312_7_0 -pt topic312_7_1 -u 0.02158301577113883 > ./result_10chains/node312_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_8_1 -p 754 -st topic312_8_0 -pt topic312_8_1 -u 0.005911649954376499 > ./result_10chains/node312_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_9_1 -p 924 -st topic312_9_0 -pt topic312_9_1 -u 0.005506114173748904 > ./result_10chains/node312_9_1.txt &
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
    "./result_10chains/node312_0_1.txt 90"
    "./result_10chains/node312_1_1.txt 89"
    "./result_10chains/node312_2_1.txt 88"
    "./result_10chains/node312_3_1.txt 87"
    "./result_10chains/node312_4_1.txt 86"
    "./result_10chains/node312_5_1.txt 85"
    "./result_10chains/node312_6_1.txt 84"
    "./result_10chains/node312_7_1.txt 83"
    "./result_10chains/node312_8_1.txt 82"
    "./result_10chains/node312_9_1.txt 81"
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
