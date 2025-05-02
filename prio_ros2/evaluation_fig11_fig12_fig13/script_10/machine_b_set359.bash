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
ros2 run evaluation_3_randomdag uunifast_node -n node359_0_1 -p 55 -st topic359_0_0 -pt topic359_0_1 -u 0.0024268384402471588 > ./result_10chains/node359_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_1_1 -p 103 -st topic359_1_0 -pt topic359_1_1 -u 0.01736387355230118 > ./result_10chains/node359_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_2_1 -p 243 -st topic359_2_0 -pt topic359_2_1 -u 0.009792765943453019 > ./result_10chains/node359_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_3_1 -p 281 -st topic359_3_0 -pt topic359_3_1 -u 0.05643298352836712 > ./result_10chains/node359_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_4_1 -p 307 -st topic359_4_0 -pt topic359_4_1 -u 0.018850961210628348 > ./result_10chains/node359_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_5_1 -p 333 -st topic359_5_0 -pt topic359_5_1 -u 0.023247081947650572 > ./result_10chains/node359_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_6_1 -p 474 -st topic359_6_0 -pt topic359_6_1 -u 0.018002069994452086 > ./result_10chains/node359_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_7_1 -p 738 -st topic359_7_0 -pt topic359_7_1 -u 0.011081098026007985 > ./result_10chains/node359_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_8_1 -p 938 -st topic359_8_0 -pt topic359_8_1 -u 0.03467010894136259 > ./result_10chains/node359_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_9_1 -p 982 -st topic359_9_0 -pt topic359_9_1 -u 0.003030357597830122 > ./result_10chains/node359_9_1.txt &
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
    "./result_10chains/node359_0_1.txt 90"
    "./result_10chains/node359_1_1.txt 89"
    "./result_10chains/node359_2_1.txt 88"
    "./result_10chains/node359_3_1.txt 87"
    "./result_10chains/node359_4_1.txt 86"
    "./result_10chains/node359_5_1.txt 85"
    "./result_10chains/node359_6_1.txt 84"
    "./result_10chains/node359_7_1.txt 83"
    "./result_10chains/node359_8_1.txt 82"
    "./result_10chains/node359_9_1.txt 81"
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
