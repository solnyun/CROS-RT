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
ros2 run evaluation_3_randomdag uunifast_node -n node220_0_1 -p 276 -st topic220_0_0 -pt topic220_0_1 -u 0.015156285419902271 > ./result_8chains/node220_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_1_1 -p 281 -st topic220_1_0 -pt topic220_1_1 -u 0.0072779122473606295 > ./result_8chains/node220_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_2_1 -p 307 -st topic220_2_0 -pt topic220_2_1 -u 0.06069300883944806 > ./result_8chains/node220_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_3_1 -p 513 -st topic220_3_0 -pt topic220_3_1 -u 0.010162627639221822 > ./result_8chains/node220_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_4_1 -p 559 -st topic220_4_0 -pt topic220_4_1 -u 0.027607360394066374 > ./result_8chains/node220_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_5_1 -p 648 -st topic220_5_0 -pt topic220_5_1 -u 0.01274188558247745 > ./result_8chains/node220_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_6_1 -p 809 -st topic220_6_0 -pt topic220_6_1 -u 0.00019462420873378808 > ./result_8chains/node220_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_7_1 -p 854 -st topic220_7_0 -pt topic220_7_1 -u 0.004953486322206805 > ./result_8chains/node220_7_1.txt &
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
    "./result_8chains/node220_0_1.txt 90"
    "./result_8chains/node220_1_1.txt 89"
    "./result_8chains/node220_2_1.txt 88"
    "./result_8chains/node220_3_1.txt 87"
    "./result_8chains/node220_4_1.txt 86"
    "./result_8chains/node220_5_1.txt 85"
    "./result_8chains/node220_6_1.txt 84"
    "./result_8chains/node220_7_1.txt 83"
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
