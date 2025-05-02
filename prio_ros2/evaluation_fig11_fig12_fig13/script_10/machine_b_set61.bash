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
ros2 run evaluation_3_randomdag uunifast_node -n node61_0_1 -p 64 -st topic61_0_0 -pt topic61_0_1 -u 0.007949936648707356 > ./result_10chains/node61_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_1_1 -p 105 -st topic61_1_0 -pt topic61_1_1 -u 0.008112398010427901 > ./result_10chains/node61_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_2_1 -p 211 -st topic61_2_0 -pt topic61_2_1 -u 0.0007813827531711892 > ./result_10chains/node61_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_3_1 -p 219 -st topic61_3_0 -pt topic61_3_1 -u 0.019843623407003352 > ./result_10chains/node61_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_4_1 -p 399 -st topic61_4_0 -pt topic61_4_1 -u 0.047024135380565324 > ./result_10chains/node61_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_5_1 -p 424 -st topic61_5_0 -pt topic61_5_1 -u 0.00963589739066345 > ./result_10chains/node61_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_6_1 -p 794 -st topic61_6_0 -pt topic61_6_1 -u 0.0395517936044292 > ./result_10chains/node61_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_7_1 -p 812 -st topic61_7_0 -pt topic61_7_1 -u 0.016267705809374783 > ./result_10chains/node61_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_8_1 -p 815 -st topic61_8_0 -pt topic61_8_1 -u 0.018239947359610847 > ./result_10chains/node61_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_9_1 -p 883 -st topic61_9_0 -pt topic61_9_1 -u 0.0076452724245897885 > ./result_10chains/node61_9_1.txt &
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
    "./result_10chains/node61_0_1.txt 90"
    "./result_10chains/node61_1_1.txt 89"
    "./result_10chains/node61_2_1.txt 88"
    "./result_10chains/node61_3_1.txt 87"
    "./result_10chains/node61_4_1.txt 86"
    "./result_10chains/node61_5_1.txt 85"
    "./result_10chains/node61_6_1.txt 84"
    "./result_10chains/node61_7_1.txt 83"
    "./result_10chains/node61_8_1.txt 82"
    "./result_10chains/node61_9_1.txt 81"
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
