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
ros2 run evaluation_3_randomdag uunifast_node -n node305_0_1 -p 110 -st topic305_0_0 -pt topic305_0_1 -u 0.0024218186249722606 > ./result_10chains/node305_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_1_1 -p 136 -st topic305_1_0 -pt topic305_1_1 -u 0.007246992079737891 > ./result_10chains/node305_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_2_1 -p 373 -st topic305_2_0 -pt topic305_2_1 -u 0.02995365229197594 > ./result_10chains/node305_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_3_1 -p 455 -st topic305_3_0 -pt topic305_3_1 -u 0.036474667634973534 > ./result_10chains/node305_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_4_1 -p 619 -st topic305_4_0 -pt topic305_4_1 -u 0.020306614643127774 > ./result_10chains/node305_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_5_1 -p 682 -st topic305_5_0 -pt topic305_5_1 -u 0.019508876912394557 > ./result_10chains/node305_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_6_1 -p 745 -st topic305_6_0 -pt topic305_6_1 -u 0.012655527149090573 > ./result_10chains/node305_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_7_1 -p 794 -st topic305_7_0 -pt topic305_7_1 -u 0.01728620599354362 > ./result_10chains/node305_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_8_1 -p 830 -st topic305_8_0 -pt topic305_8_1 -u 0.001619781677740073 > ./result_10chains/node305_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_9_1 -p 936 -st topic305_9_0 -pt topic305_9_1 -u 0.013132490138941973 > ./result_10chains/node305_9_1.txt &
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
    "./result_10chains/node305_0_1.txt 90"
    "./result_10chains/node305_1_1.txt 89"
    "./result_10chains/node305_2_1.txt 88"
    "./result_10chains/node305_3_1.txt 87"
    "./result_10chains/node305_4_1.txt 86"
    "./result_10chains/node305_5_1.txt 85"
    "./result_10chains/node305_6_1.txt 84"
    "./result_10chains/node305_7_1.txt 83"
    "./result_10chains/node305_8_1.txt 82"
    "./result_10chains/node305_9_1.txt 81"
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
