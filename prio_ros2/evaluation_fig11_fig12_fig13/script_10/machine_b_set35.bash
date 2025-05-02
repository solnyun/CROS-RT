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
ros2 run evaluation_3_randomdag uunifast_node -n node35_0_1 -p 34 -st topic35_0_0 -pt topic35_0_1 -u 0.009146051436506042 > ./result_10chains/node35_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node35_1_1 -p 43 -st topic35_1_0 -pt topic35_1_1 -u 0.013245765571183177 > ./result_10chains/node35_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node35_2_1 -p 203 -st topic35_2_0 -pt topic35_2_1 -u 0.0028826235272607637 > ./result_10chains/node35_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node35_3_1 -p 234 -st topic35_3_0 -pt topic35_3_1 -u 0.031744815579867025 > ./result_10chains/node35_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node35_4_1 -p 301 -st topic35_4_0 -pt topic35_4_1 -u 0.002306865142515435 > ./result_10chains/node35_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node35_5_1 -p 372 -st topic35_5_0 -pt topic35_5_1 -u 0.02710581996959807 > ./result_10chains/node35_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node35_6_1 -p 514 -st topic35_6_0 -pt topic35_6_1 -u 0.0008615796700569001 > ./result_10chains/node35_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node35_7_1 -p 582 -st topic35_7_0 -pt topic35_7_1 -u 0.001076852786499466 > ./result_10chains/node35_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node35_8_1 -p 855 -st topic35_8_0 -pt topic35_8_1 -u 0.010192667974553524 > ./result_10chains/node35_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node35_9_1 -p 942 -st topic35_9_0 -pt topic35_9_1 -u 0.00025839176281453394 > ./result_10chains/node35_9_1.txt &
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
    "./result_10chains/node35_0_1.txt 90"
    "./result_10chains/node35_1_1.txt 89"
    "./result_10chains/node35_2_1.txt 88"
    "./result_10chains/node35_3_1.txt 87"
    "./result_10chains/node35_4_1.txt 86"
    "./result_10chains/node35_5_1.txt 85"
    "./result_10chains/node35_6_1.txt 84"
    "./result_10chains/node35_7_1.txt 83"
    "./result_10chains/node35_8_1.txt 82"
    "./result_10chains/node35_9_1.txt 81"
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
