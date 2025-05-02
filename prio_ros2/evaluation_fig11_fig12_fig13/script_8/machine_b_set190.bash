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
ros2 run evaluation_3_randomdag uunifast_node -n node190_0_1 -p 14 -st topic190_0_0 -pt topic190_0_1 -u 0.020764232908541513 > ./result_8chains/node190_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_1_1 -p 322 -st topic190_1_0 -pt topic190_1_1 -u 0.004166811797598091 > ./result_8chains/node190_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_2_1 -p 391 -st topic190_2_0 -pt topic190_2_1 -u 0.05703292448939973 > ./result_8chains/node190_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_3_1 -p 393 -st topic190_3_0 -pt topic190_3_1 -u 0.03406100698938147 > ./result_8chains/node190_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_4_1 -p 409 -st topic190_4_0 -pt topic190_4_1 -u 0.010084976370449528 > ./result_8chains/node190_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_5_1 -p 663 -st topic190_5_0 -pt topic190_5_1 -u 0.0019157279980704794 > ./result_8chains/node190_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_6_1 -p 674 -st topic190_6_0 -pt topic190_6_1 -u 0.0030782347797157356 > ./result_8chains/node190_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_7_1 -p 830 -st topic190_7_0 -pt topic190_7_1 -u 0.011863265457509022 > ./result_8chains/node190_7_1.txt &
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
    "./result_8chains/node190_0_1.txt 90"
    "./result_8chains/node190_1_1.txt 89"
    "./result_8chains/node190_2_1.txt 88"
    "./result_8chains/node190_3_1.txt 87"
    "./result_8chains/node190_4_1.txt 86"
    "./result_8chains/node190_5_1.txt 85"
    "./result_8chains/node190_6_1.txt 84"
    "./result_8chains/node190_7_1.txt 83"
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
