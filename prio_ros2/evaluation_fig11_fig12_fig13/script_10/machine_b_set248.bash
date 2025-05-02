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
ros2 run evaluation_3_randomdag uunifast_node -n node248_0_1 -p 120 -st topic248_0_0 -pt topic248_0_1 -u 0.020170581781254582 > ./result_10chains/node248_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_1_1 -p 523 -st topic248_1_0 -pt topic248_1_1 -u 0.028919426076926935 > ./result_10chains/node248_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_2_1 -p 536 -st topic248_2_0 -pt topic248_2_1 -u 0.024554181884343107 > ./result_10chains/node248_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_3_1 -p 588 -st topic248_3_0 -pt topic248_3_1 -u 0.016886791568467396 > ./result_10chains/node248_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_4_1 -p 649 -st topic248_4_0 -pt topic248_4_1 -u 0.00037764759308878126 > ./result_10chains/node248_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_5_1 -p 653 -st topic248_5_0 -pt topic248_5_1 -u 0.009717238720532428 > ./result_10chains/node248_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_6_1 -p 703 -st topic248_6_0 -pt topic248_6_1 -u 0.030828439813716746 > ./result_10chains/node248_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_7_1 -p 709 -st topic248_7_0 -pt topic248_7_1 -u 0.05330089445946613 > ./result_10chains/node248_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_8_1 -p 861 -st topic248_8_0 -pt topic248_8_1 -u 0.003712655023990888 > ./result_10chains/node248_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_9_1 -p 921 -st topic248_9_0 -pt topic248_9_1 -u 0.004625910344320629 > ./result_10chains/node248_9_1.txt &
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
    "./result_10chains/node248_0_1.txt 90"
    "./result_10chains/node248_1_1.txt 89"
    "./result_10chains/node248_2_1.txt 88"
    "./result_10chains/node248_3_1.txt 87"
    "./result_10chains/node248_4_1.txt 86"
    "./result_10chains/node248_5_1.txt 85"
    "./result_10chains/node248_6_1.txt 84"
    "./result_10chains/node248_7_1.txt 83"
    "./result_10chains/node248_8_1.txt 82"
    "./result_10chains/node248_9_1.txt 81"
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
