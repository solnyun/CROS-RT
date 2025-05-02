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
ros2 run evaluation_3_randomdag uunifast_node -n node69_0_1 -p 230 -st topic69_0_0 -pt topic69_0_1 -u 0.02338493630946481 > ./result_10chains/node69_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_1_1 -p 242 -st topic69_1_0 -pt topic69_1_1 -u 0.003749336949070925 > ./result_10chains/node69_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_2_1 -p 244 -st topic69_2_0 -pt topic69_2_1 -u 0.027009869758208183 > ./result_10chains/node69_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_3_1 -p 351 -st topic69_3_0 -pt topic69_3_1 -u 0.005542677956406339 > ./result_10chains/node69_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_4_1 -p 524 -st topic69_4_0 -pt topic69_4_1 -u 0.005732475819433813 > ./result_10chains/node69_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_5_1 -p 550 -st topic69_5_0 -pt topic69_5_1 -u 0.019466336748576257 > ./result_10chains/node69_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_6_1 -p 750 -st topic69_6_0 -pt topic69_6_1 -u 0.005085531726285397 > ./result_10chains/node69_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_7_1 -p 882 -st topic69_7_0 -pt topic69_7_1 -u 0.005605088181270819 > ./result_10chains/node69_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_8_1 -p 891 -st topic69_8_0 -pt topic69_8_1 -u 0.0015704235593396385 > ./result_10chains/node69_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_9_1 -p 939 -st topic69_9_0 -pt topic69_9_1 -u 0.0016440901516880692 > ./result_10chains/node69_9_1.txt &
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
    "./result_10chains/node69_0_1.txt 90"
    "./result_10chains/node69_1_1.txt 89"
    "./result_10chains/node69_2_1.txt 88"
    "./result_10chains/node69_3_1.txt 87"
    "./result_10chains/node69_4_1.txt 86"
    "./result_10chains/node69_5_1.txt 85"
    "./result_10chains/node69_6_1.txt 84"
    "./result_10chains/node69_7_1.txt 83"
    "./result_10chains/node69_8_1.txt 82"
    "./result_10chains/node69_9_1.txt 81"
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
