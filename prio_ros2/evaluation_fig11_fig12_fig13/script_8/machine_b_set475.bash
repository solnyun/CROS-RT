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
ros2 run evaluation_3_randomdag uunifast_node -n node475_0_1 -p 84 -st topic475_0_0 -pt topic475_0_1 -u 0.010000818390960509 > ./result_8chains/node475_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_1_1 -p 190 -st topic475_1_0 -pt topic475_1_1 -u 0.07970926780083465 > ./result_8chains/node475_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_2_1 -p 241 -st topic475_2_0 -pt topic475_2_1 -u 0.009919844608660633 > ./result_8chains/node475_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_3_1 -p 485 -st topic475_3_0 -pt topic475_3_1 -u 0.0002907543323301398 > ./result_8chains/node475_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_4_1 -p 590 -st topic475_4_0 -pt topic475_4_1 -u 0.01739710386694024 > ./result_8chains/node475_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_5_1 -p 709 -st topic475_5_0 -pt topic475_5_1 -u 0.00044004501662631146 > ./result_8chains/node475_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_6_1 -p 737 -st topic475_6_0 -pt topic475_6_1 -u 0.000836188383049552 > ./result_8chains/node475_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_7_1 -p 748 -st topic475_7_0 -pt topic475_7_1 -u 0.030754890864865055 > ./result_8chains/node475_7_1.txt &
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
    "./result_8chains/node475_0_1.txt 90"
    "./result_8chains/node475_1_1.txt 89"
    "./result_8chains/node475_2_1.txt 88"
    "./result_8chains/node475_3_1.txt 87"
    "./result_8chains/node475_4_1.txt 86"
    "./result_8chains/node475_5_1.txt 85"
    "./result_8chains/node475_6_1.txt 84"
    "./result_8chains/node475_7_1.txt 83"
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
