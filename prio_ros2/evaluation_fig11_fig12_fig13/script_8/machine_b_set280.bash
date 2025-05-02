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
ros2 run evaluation_3_randomdag uunifast_node -n node280_0_1 -p 172 -st topic280_0_0 -pt topic280_0_1 -u 0.03080769481472795 > ./result_8chains/node280_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_1_1 -p 250 -st topic280_1_0 -pt topic280_1_1 -u 0.04427332520097321 > ./result_8chains/node280_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_2_1 -p 321 -st topic280_2_0 -pt topic280_2_1 -u 0.02181456724274411 > ./result_8chains/node280_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_3_1 -p 640 -st topic280_3_0 -pt topic280_3_1 -u 0.0037823776893433636 > ./result_8chains/node280_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_4_1 -p 724 -st topic280_4_0 -pt topic280_4_1 -u 0.034964859518509445 > ./result_8chains/node280_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_5_1 -p 786 -st topic280_5_0 -pt topic280_5_1 -u 0.011469518578513624 > ./result_8chains/node280_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_6_1 -p 950 -st topic280_6_0 -pt topic280_6_1 -u 0.06882689385019114 > ./result_8chains/node280_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_7_1 -p 972 -st topic280_7_0 -pt topic280_7_1 -u 0.01296080872724439 > ./result_8chains/node280_7_1.txt &
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
    "./result_8chains/node280_0_1.txt 90"
    "./result_8chains/node280_1_1.txt 89"
    "./result_8chains/node280_2_1.txt 88"
    "./result_8chains/node280_3_1.txt 87"
    "./result_8chains/node280_4_1.txt 86"
    "./result_8chains/node280_5_1.txt 85"
    "./result_8chains/node280_6_1.txt 84"
    "./result_8chains/node280_7_1.txt 83"
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
