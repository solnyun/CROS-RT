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
ros2 run evaluation_3_randomdag uunifast_node -n node499_0_1 -p 132 -st topic499_0_0 -pt topic499_0_1 -u 0.018183059680412395 > ./result_10chains/node499_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_1_1 -p 300 -st topic499_1_0 -pt topic499_1_1 -u 0.0008569152720749873 > ./result_10chains/node499_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_2_1 -p 411 -st topic499_2_0 -pt topic499_2_1 -u 0.015664523598625912 > ./result_10chains/node499_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_3_1 -p 493 -st topic499_3_0 -pt topic499_3_1 -u 0.01096249445392633 > ./result_10chains/node499_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_4_1 -p 503 -st topic499_4_0 -pt topic499_4_1 -u 0.007842386325523754 > ./result_10chains/node499_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_5_1 -p 537 -st topic499_5_0 -pt topic499_5_1 -u 0.03073976062774475 > ./result_10chains/node499_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_6_1 -p 564 -st topic499_6_0 -pt topic499_6_1 -u 0.0174216898464086 > ./result_10chains/node499_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_7_1 -p 882 -st topic499_7_0 -pt topic499_7_1 -u 0.0018248549323189311 > ./result_10chains/node499_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_8_1 -p 974 -st topic499_8_0 -pt topic499_8_1 -u 0.0016693055907530674 > ./result_10chains/node499_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_9_1 -p 985 -st topic499_9_0 -pt topic499_9_1 -u 0.0008834676113625567 > ./result_10chains/node499_9_1.txt &
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
    "./result_10chains/node499_0_1.txt 90"
    "./result_10chains/node499_1_1.txt 89"
    "./result_10chains/node499_2_1.txt 88"
    "./result_10chains/node499_3_1.txt 87"
    "./result_10chains/node499_4_1.txt 86"
    "./result_10chains/node499_5_1.txt 85"
    "./result_10chains/node499_6_1.txt 84"
    "./result_10chains/node499_7_1.txt 83"
    "./result_10chains/node499_8_1.txt 82"
    "./result_10chains/node499_9_1.txt 81"
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
