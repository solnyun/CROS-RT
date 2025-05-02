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
ros2 run evaluation_3_randomdag uunifast_node -n node428_0_1 -p 26 -st topic428_0_0 -pt topic428_0_1 -u 0.07348415521450763 > ./result_10chains/node428_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_1_1 -p 56 -st topic428_1_0 -pt topic428_1_1 -u 0.02001541205323565 > ./result_10chains/node428_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_2_1 -p 248 -st topic428_2_0 -pt topic428_2_1 -u 0.00305615460835984 > ./result_10chains/node428_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_3_1 -p 272 -st topic428_3_0 -pt topic428_3_1 -u 0.00633178291857478 > ./result_10chains/node428_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_4_1 -p 344 -st topic428_4_0 -pt topic428_4_1 -u 0.0021680908793083598 > ./result_10chains/node428_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_5_1 -p 733 -st topic428_5_0 -pt topic428_5_1 -u 0.00011526721253127259 > ./result_10chains/node428_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_6_1 -p 776 -st topic428_6_0 -pt topic428_6_1 -u 0.027360978172459083 > ./result_10chains/node428_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_7_1 -p 808 -st topic428_7_0 -pt topic428_7_1 -u 0.010972134564286848 > ./result_10chains/node428_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_8_1 -p 837 -st topic428_8_0 -pt topic428_8_1 -u 0.0011654891846150928 > ./result_10chains/node428_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_9_1 -p 876 -st topic428_9_0 -pt topic428_9_1 -u 0.002964703963873369 > ./result_10chains/node428_9_1.txt &
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
    "./result_10chains/node428_0_1.txt 90"
    "./result_10chains/node428_1_1.txt 89"
    "./result_10chains/node428_2_1.txt 88"
    "./result_10chains/node428_3_1.txt 87"
    "./result_10chains/node428_4_1.txt 86"
    "./result_10chains/node428_5_1.txt 85"
    "./result_10chains/node428_6_1.txt 84"
    "./result_10chains/node428_7_1.txt 83"
    "./result_10chains/node428_8_1.txt 82"
    "./result_10chains/node428_9_1.txt 81"
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
