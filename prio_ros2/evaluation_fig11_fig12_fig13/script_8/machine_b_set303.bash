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
ros2 run evaluation_3_randomdag uunifast_node -n node303_0_1 -p 25 -st topic303_0_0 -pt topic303_0_1 -u 0.00983841785684525 > ./result_8chains/node303_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_1_1 -p 41 -st topic303_1_0 -pt topic303_1_1 -u 0.022026341097642177 > ./result_8chains/node303_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_2_1 -p 190 -st topic303_2_0 -pt topic303_2_1 -u 0.006755007476126451 > ./result_8chains/node303_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_3_1 -p 369 -st topic303_3_0 -pt topic303_3_1 -u 0.008086510336400232 > ./result_8chains/node303_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_4_1 -p 516 -st topic303_4_0 -pt topic303_4_1 -u 0.019946165378091657 > ./result_8chains/node303_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_5_1 -p 539 -st topic303_5_0 -pt topic303_5_1 -u 0.007406650064096687 > ./result_8chains/node303_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_6_1 -p 683 -st topic303_6_0 -pt topic303_6_1 -u 0.02730907412032188 > ./result_8chains/node303_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_7_1 -p 738 -st topic303_7_0 -pt topic303_7_1 -u 0.0118030872172535 > ./result_8chains/node303_7_1.txt &
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
    "./result_8chains/node303_0_1.txt 90"
    "./result_8chains/node303_1_1.txt 89"
    "./result_8chains/node303_2_1.txt 88"
    "./result_8chains/node303_3_1.txt 87"
    "./result_8chains/node303_4_1.txt 86"
    "./result_8chains/node303_5_1.txt 85"
    "./result_8chains/node303_6_1.txt 84"
    "./result_8chains/node303_7_1.txt 83"
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
