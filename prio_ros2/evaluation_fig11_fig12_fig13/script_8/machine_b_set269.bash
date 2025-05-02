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
ros2 run evaluation_3_randomdag uunifast_node -n node269_0_1 -p 73 -st topic269_0_0 -pt topic269_0_1 -u 0.0007721243735570038 > ./result_8chains/node269_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_1_1 -p 139 -st topic269_1_0 -pt topic269_1_1 -u 0.01701972870103874 > ./result_8chains/node269_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_2_1 -p 274 -st topic269_2_0 -pt topic269_2_1 -u 0.0043038171804852254 > ./result_8chains/node269_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_3_1 -p 317 -st topic269_3_0 -pt topic269_3_1 -u 0.035741893417845505 > ./result_8chains/node269_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_4_1 -p 575 -st topic269_4_0 -pt topic269_4_1 -u 0.02354593214553108 > ./result_8chains/node269_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_5_1 -p 737 -st topic269_5_0 -pt topic269_5_1 -u 0.05865985619847845 > ./result_8chains/node269_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_6_1 -p 875 -st topic269_6_0 -pt topic269_6_1 -u 0.03461210490322244 > ./result_8chains/node269_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_7_1 -p 909 -st topic269_7_0 -pt topic269_7_1 -u 0.010359913760664788 > ./result_8chains/node269_7_1.txt &
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
    "./result_8chains/node269_0_1.txt 90"
    "./result_8chains/node269_1_1.txt 89"
    "./result_8chains/node269_2_1.txt 88"
    "./result_8chains/node269_3_1.txt 87"
    "./result_8chains/node269_4_1.txt 86"
    "./result_8chains/node269_5_1.txt 85"
    "./result_8chains/node269_6_1.txt 84"
    "./result_8chains/node269_7_1.txt 83"
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
