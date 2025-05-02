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
ros2 run evaluation_3_randomdag uunifast_node -n node154_0_1 -p 119 -st topic154_0_0 -pt topic154_0_1 -u 0.00915679222066701 > ./result_8chains/node154_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_1_1 -p 157 -st topic154_1_0 -pt topic154_1_1 -u 0.044047257626173286 > ./result_8chains/node154_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_2_1 -p 409 -st topic154_2_0 -pt topic154_2_1 -u 0.00038134872242795437 > ./result_8chains/node154_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_3_1 -p 548 -st topic154_3_0 -pt topic154_3_1 -u 0.10689345136851314 > ./result_8chains/node154_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_4_1 -p 549 -st topic154_4_0 -pt topic154_4_1 -u 0.009452787127927686 > ./result_8chains/node154_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_5_1 -p 795 -st topic154_5_0 -pt topic154_5_1 -u 0.02703045366437591 > ./result_8chains/node154_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_6_1 -p 900 -st topic154_6_0 -pt topic154_6_1 -u 0.008880597949812996 > ./result_8chains/node154_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_7_1 -p 985 -st topic154_7_0 -pt topic154_7_1 -u 0.005432616278531381 > ./result_8chains/node154_7_1.txt &
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
    "./result_8chains/node154_0_1.txt 90"
    "./result_8chains/node154_1_1.txt 89"
    "./result_8chains/node154_2_1.txt 88"
    "./result_8chains/node154_3_1.txt 87"
    "./result_8chains/node154_4_1.txt 86"
    "./result_8chains/node154_5_1.txt 85"
    "./result_8chains/node154_6_1.txt 84"
    "./result_8chains/node154_7_1.txt 83"
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
