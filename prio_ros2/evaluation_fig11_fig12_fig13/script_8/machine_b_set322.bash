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
ros2 run evaluation_3_randomdag uunifast_node -n node322_0_1 -p 178 -st topic322_0_0 -pt topic322_0_1 -u 0.030177192958153132 > ./result_8chains/node322_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_1_1 -p 320 -st topic322_1_0 -pt topic322_1_1 -u 0.00538775155804766 > ./result_8chains/node322_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_2_1 -p 383 -st topic322_2_0 -pt topic322_2_1 -u 0.008058088195905144 > ./result_8chains/node322_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_3_1 -p 577 -st topic322_3_0 -pt topic322_3_1 -u 0.006386634862452667 > ./result_8chains/node322_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_4_1 -p 634 -st topic322_4_0 -pt topic322_4_1 -u 0.01988411103744192 > ./result_8chains/node322_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_5_1 -p 666 -st topic322_5_0 -pt topic322_5_1 -u 0.009321733129538323 > ./result_8chains/node322_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_6_1 -p 669 -st topic322_6_0 -pt topic322_6_1 -u 0.01702090659889907 > ./result_8chains/node322_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_7_1 -p 957 -st topic322_7_0 -pt topic322_7_1 -u 0.013369500063969104 > ./result_8chains/node322_7_1.txt &
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
    "./result_8chains/node322_0_1.txt 90"
    "./result_8chains/node322_1_1.txt 89"
    "./result_8chains/node322_2_1.txt 88"
    "./result_8chains/node322_3_1.txt 87"
    "./result_8chains/node322_4_1.txt 86"
    "./result_8chains/node322_5_1.txt 85"
    "./result_8chains/node322_6_1.txt 84"
    "./result_8chains/node322_7_1.txt 83"
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
