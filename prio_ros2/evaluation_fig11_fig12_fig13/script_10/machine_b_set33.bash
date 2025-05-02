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
ros2 run evaluation_3_randomdag uunifast_node -n node33_0_1 -p 195 -st topic33_0_0 -pt topic33_0_1 -u 0.012783399957331909 > ./result_10chains/node33_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node33_1_1 -p 204 -st topic33_1_0 -pt topic33_1_1 -u 0.006408923340677775 > ./result_10chains/node33_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node33_2_1 -p 231 -st topic33_2_0 -pt topic33_2_1 -u 0.014806599817028088 > ./result_10chains/node33_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node33_3_1 -p 232 -st topic33_3_0 -pt topic33_3_1 -u 0.013368300231221097 > ./result_10chains/node33_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node33_4_1 -p 377 -st topic33_4_0 -pt topic33_4_1 -u 0.0043420212527075785 > ./result_10chains/node33_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node33_5_1 -p 507 -st topic33_5_0 -pt topic33_5_1 -u 0.02370026436665046 > ./result_10chains/node33_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node33_6_1 -p 556 -st topic33_6_0 -pt topic33_6_1 -u 0.009952308192666015 > ./result_10chains/node33_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node33_7_1 -p 750 -st topic33_7_0 -pt topic33_7_1 -u 0.0022110317141918467 > ./result_10chains/node33_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node33_8_1 -p 895 -st topic33_8_0 -pt topic33_8_1 -u 0.03559261240923787 > ./result_10chains/node33_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node33_9_1 -p 943 -st topic33_9_0 -pt topic33_9_1 -u 0.009351391208437476 > ./result_10chains/node33_9_1.txt &
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
    "./result_10chains/node33_0_1.txt 90"
    "./result_10chains/node33_1_1.txt 89"
    "./result_10chains/node33_2_1.txt 88"
    "./result_10chains/node33_3_1.txt 87"
    "./result_10chains/node33_4_1.txt 86"
    "./result_10chains/node33_5_1.txt 85"
    "./result_10chains/node33_6_1.txt 84"
    "./result_10chains/node33_7_1.txt 83"
    "./result_10chains/node33_8_1.txt 82"
    "./result_10chains/node33_9_1.txt 81"
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
