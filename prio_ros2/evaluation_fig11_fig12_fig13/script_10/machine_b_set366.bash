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
ros2 run evaluation_3_randomdag uunifast_node -n node366_0_1 -p 139 -st topic366_0_0 -pt topic366_0_1 -u 0.017675001008176372 > ./result_10chains/node366_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_1_1 -p 260 -st topic366_1_0 -pt topic366_1_1 -u 0.01616656822861623 > ./result_10chains/node366_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_2_1 -p 268 -st topic366_2_0 -pt topic366_2_1 -u 0.009408301341106318 > ./result_10chains/node366_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_3_1 -p 578 -st topic366_3_0 -pt topic366_3_1 -u 0.040133263771955585 > ./result_10chains/node366_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_4_1 -p 634 -st topic366_4_0 -pt topic366_4_1 -u 0.030192260305562213 > ./result_10chains/node366_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_5_1 -p 755 -st topic366_5_0 -pt topic366_5_1 -u 0.025600548147829638 > ./result_10chains/node366_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_6_1 -p 820 -st topic366_6_0 -pt topic366_6_1 -u 0.060271046377831844 > ./result_10chains/node366_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_7_1 -p 874 -st topic366_7_0 -pt topic366_7_1 -u 0.01364811946686624 > ./result_10chains/node366_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_8_1 -p 897 -st topic366_8_0 -pt topic366_8_1 -u 0.010686945828977584 > ./result_10chains/node366_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_9_1 -p 966 -st topic366_9_0 -pt topic366_9_1 -u 0.04088378876336055 > ./result_10chains/node366_9_1.txt &
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
    "./result_10chains/node366_0_1.txt 90"
    "./result_10chains/node366_1_1.txt 89"
    "./result_10chains/node366_2_1.txt 88"
    "./result_10chains/node366_3_1.txt 87"
    "./result_10chains/node366_4_1.txt 86"
    "./result_10chains/node366_5_1.txt 85"
    "./result_10chains/node366_6_1.txt 84"
    "./result_10chains/node366_7_1.txt 83"
    "./result_10chains/node366_8_1.txt 82"
    "./result_10chains/node366_9_1.txt 81"
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
