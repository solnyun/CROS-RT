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
ros2 run evaluation_3_randomdag uunifast_node -n node481_0_1 -p 60 -st topic481_0_0 -pt topic481_0_1 -u 0.008157859684249424 > ./result_10chains/node481_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_1_1 -p 146 -st topic481_1_0 -pt topic481_1_1 -u 0.08795602059738655 > ./result_10chains/node481_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_2_1 -p 204 -st topic481_2_0 -pt topic481_2_1 -u 0.0010772011011734861 > ./result_10chains/node481_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_3_1 -p 248 -st topic481_3_0 -pt topic481_3_1 -u 0.012963320689885621 > ./result_10chains/node481_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_4_1 -p 361 -st topic481_4_0 -pt topic481_4_1 -u 0.0002334541770281362 > ./result_10chains/node481_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_5_1 -p 396 -st topic481_5_0 -pt topic481_5_1 -u 0.0026363058641594994 > ./result_10chains/node481_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_6_1 -p 420 -st topic481_6_0 -pt topic481_6_1 -u 0.021675136075036766 > ./result_10chains/node481_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_7_1 -p 619 -st topic481_7_0 -pt topic481_7_1 -u 0.009144352479001167 > ./result_10chains/node481_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_8_1 -p 879 -st topic481_8_0 -pt topic481_8_1 -u 0.007250279930423348 > ./result_10chains/node481_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_9_1 -p 982 -st topic481_9_0 -pt topic481_9_1 -u 0.046302629970944406 > ./result_10chains/node481_9_1.txt &
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
    "./result_10chains/node481_0_1.txt 90"
    "./result_10chains/node481_1_1.txt 89"
    "./result_10chains/node481_2_1.txt 88"
    "./result_10chains/node481_3_1.txt 87"
    "./result_10chains/node481_4_1.txt 86"
    "./result_10chains/node481_5_1.txt 85"
    "./result_10chains/node481_6_1.txt 84"
    "./result_10chains/node481_7_1.txt 83"
    "./result_10chains/node481_8_1.txt 82"
    "./result_10chains/node481_9_1.txt 81"
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
