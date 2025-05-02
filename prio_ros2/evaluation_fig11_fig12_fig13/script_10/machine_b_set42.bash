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
ros2 run evaluation_3_randomdag uunifast_node -n node42_0_1 -p 19 -st topic42_0_0 -pt topic42_0_1 -u 0.03281834250409926 > ./result_10chains/node42_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node42_1_1 -p 207 -st topic42_1_0 -pt topic42_1_1 -u 0.025985273097168804 > ./result_10chains/node42_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node42_2_1 -p 225 -st topic42_2_0 -pt topic42_2_1 -u 0.01354736032082321 > ./result_10chains/node42_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node42_3_1 -p 231 -st topic42_3_0 -pt topic42_3_1 -u 0.004661801035412916 > ./result_10chains/node42_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node42_4_1 -p 284 -st topic42_4_0 -pt topic42_4_1 -u 0.00016366021797764585 > ./result_10chains/node42_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node42_5_1 -p 462 -st topic42_5_0 -pt topic42_5_1 -u 0.057767731650928994 > ./result_10chains/node42_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node42_6_1 -p 592 -st topic42_6_0 -pt topic42_6_1 -u 0.004830065126913377 > ./result_10chains/node42_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node42_7_1 -p 864 -st topic42_7_0 -pt topic42_7_1 -u 0.00488421599363166 > ./result_10chains/node42_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node42_8_1 -p 882 -st topic42_8_0 -pt topic42_8_1 -u 0.006113806679233367 > ./result_10chains/node42_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node42_9_1 -p 947 -st topic42_9_0 -pt topic42_9_1 -u 0.002634057763399706 > ./result_10chains/node42_9_1.txt &
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
    "./result_10chains/node42_0_1.txt 90"
    "./result_10chains/node42_1_1.txt 89"
    "./result_10chains/node42_2_1.txt 88"
    "./result_10chains/node42_3_1.txt 87"
    "./result_10chains/node42_4_1.txt 86"
    "./result_10chains/node42_5_1.txt 85"
    "./result_10chains/node42_6_1.txt 84"
    "./result_10chains/node42_7_1.txt 83"
    "./result_10chains/node42_8_1.txt 82"
    "./result_10chains/node42_9_1.txt 81"
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
