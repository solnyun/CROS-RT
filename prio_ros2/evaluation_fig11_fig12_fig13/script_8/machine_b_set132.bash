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
ros2 run evaluation_3_randomdag uunifast_node -n node132_0_1 -p 26 -st topic132_0_0 -pt topic132_0_1 -u 0.004972794410474213 > ./result_8chains/node132_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_1_1 -p 59 -st topic132_1_0 -pt topic132_1_1 -u 0.02640797786319815 > ./result_8chains/node132_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_2_1 -p 214 -st topic132_2_0 -pt topic132_2_1 -u 1.38151894353844e-05 > ./result_8chains/node132_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_3_1 -p 288 -st topic132_3_0 -pt topic132_3_1 -u 0.0029032191236831317 > ./result_8chains/node132_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_4_1 -p 441 -st topic132_4_0 -pt topic132_4_1 -u 0.011862500352738059 > ./result_8chains/node132_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_5_1 -p 828 -st topic132_5_0 -pt topic132_5_1 -u 0.002862888462034835 > ./result_8chains/node132_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_6_1 -p 862 -st topic132_6_0 -pt topic132_6_1 -u 0.027768484871141225 > ./result_8chains/node132_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_7_1 -p 997 -st topic132_7_0 -pt topic132_7_1 -u 0.020592472817310595 > ./result_8chains/node132_7_1.txt &
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
    "./result_8chains/node132_0_1.txt 90"
    "./result_8chains/node132_1_1.txt 89"
    "./result_8chains/node132_2_1.txt 88"
    "./result_8chains/node132_3_1.txt 87"
    "./result_8chains/node132_4_1.txt 86"
    "./result_8chains/node132_5_1.txt 85"
    "./result_8chains/node132_6_1.txt 84"
    "./result_8chains/node132_7_1.txt 83"
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
