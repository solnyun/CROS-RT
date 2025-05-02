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
ros2 run evaluation_3_randomdag uunifast_node -n node29_0_1 -p 56 -st topic29_0_0 -pt topic29_0_1 -u 0.0031061312188607193 > ./result_10chains/node29_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node29_1_1 -p 93 -st topic29_1_0 -pt topic29_1_1 -u 0.008198843990598281 > ./result_10chains/node29_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node29_2_1 -p 100 -st topic29_2_0 -pt topic29_2_1 -u 0.00671109078038995 > ./result_10chains/node29_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node29_3_1 -p 241 -st topic29_3_0 -pt topic29_3_1 -u 0.02066673664101326 > ./result_10chains/node29_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node29_4_1 -p 447 -st topic29_4_0 -pt topic29_4_1 -u 0.024515899262734564 > ./result_10chains/node29_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node29_5_1 -p 702 -st topic29_5_0 -pt topic29_5_1 -u 0.010500070292754848 > ./result_10chains/node29_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node29_6_1 -p 831 -st topic29_6_0 -pt topic29_6_1 -u 0.0008686479883813769 > ./result_10chains/node29_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node29_7_1 -p 840 -st topic29_7_0 -pt topic29_7_1 -u 0.0062499025649188494 > ./result_10chains/node29_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node29_8_1 -p 851 -st topic29_8_0 -pt topic29_8_1 -u 0.03198479141720482 > ./result_10chains/node29_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node29_9_1 -p 859 -st topic29_9_0 -pt topic29_9_1 -u 0.0034054444483141814 > ./result_10chains/node29_9_1.txt &
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
    "./result_10chains/node29_0_1.txt 90"
    "./result_10chains/node29_1_1.txt 89"
    "./result_10chains/node29_2_1.txt 88"
    "./result_10chains/node29_3_1.txt 87"
    "./result_10chains/node29_4_1.txt 86"
    "./result_10chains/node29_5_1.txt 85"
    "./result_10chains/node29_6_1.txt 84"
    "./result_10chains/node29_7_1.txt 83"
    "./result_10chains/node29_8_1.txt 82"
    "./result_10chains/node29_9_1.txt 81"
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
