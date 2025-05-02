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
ros2 run evaluation_3_randomdag uunifast_node -n node278_0_1 -p 12 -st topic278_0_0 -pt topic278_0_1 -u 0.012479952831979335 > ./result_10chains/node278_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_1_1 -p 44 -st topic278_1_0 -pt topic278_1_1 -u 0.01370404524840213 > ./result_10chains/node278_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_2_1 -p 199 -st topic278_2_0 -pt topic278_2_1 -u 0.0005452101387435904 > ./result_10chains/node278_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_3_1 -p 329 -st topic278_3_0 -pt topic278_3_1 -u 0.050109614357189636 > ./result_10chains/node278_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_4_1 -p 546 -st topic278_4_0 -pt topic278_4_1 -u 0.030995270062622038 > ./result_10chains/node278_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_5_1 -p 555 -st topic278_5_0 -pt topic278_5_1 -u 0.03323521755277878 > ./result_10chains/node278_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_6_1 -p 568 -st topic278_6_0 -pt topic278_6_1 -u 0.007668438478067974 > ./result_10chains/node278_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_7_1 -p 582 -st topic278_7_0 -pt topic278_7_1 -u 0.018706239423601362 > ./result_10chains/node278_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_8_1 -p 915 -st topic278_8_0 -pt topic278_8_1 -u 0.006060873088278088 > ./result_10chains/node278_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_9_1 -p 996 -st topic278_9_0 -pt topic278_9_1 -u 0.057180023190507835 > ./result_10chains/node278_9_1.txt &
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
    "./result_10chains/node278_0_1.txt 90"
    "./result_10chains/node278_1_1.txt 89"
    "./result_10chains/node278_2_1.txt 88"
    "./result_10chains/node278_3_1.txt 87"
    "./result_10chains/node278_4_1.txt 86"
    "./result_10chains/node278_5_1.txt 85"
    "./result_10chains/node278_6_1.txt 84"
    "./result_10chains/node278_7_1.txt 83"
    "./result_10chains/node278_8_1.txt 82"
    "./result_10chains/node278_9_1.txt 81"
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
