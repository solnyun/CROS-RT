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
ros2 run evaluation_3_randomdag uunifast_node -n node224_0_1 -p 177 -st topic224_0_0 -pt topic224_0_1 -u 0.024803443216607324 > ./result_10chains/node224_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_1_1 -p 182 -st topic224_1_0 -pt topic224_1_1 -u 0.011833763045750123 > ./result_10chains/node224_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_2_1 -p 184 -st topic224_2_0 -pt topic224_2_1 -u 0.0031373398053707313 > ./result_10chains/node224_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_3_1 -p 379 -st topic224_3_0 -pt topic224_3_1 -u 0.00893464506674102 > ./result_10chains/node224_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_4_1 -p 409 -st topic224_4_0 -pt topic224_4_1 -u 0.009422874654160751 > ./result_10chains/node224_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_5_1 -p 510 -st topic224_5_0 -pt topic224_5_1 -u 0.005633970146341316 > ./result_10chains/node224_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_6_1 -p 544 -st topic224_6_0 -pt topic224_6_1 -u 0.0388501880579844 > ./result_10chains/node224_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_7_1 -p 604 -st topic224_7_0 -pt topic224_7_1 -u 0.0018871032544368616 > ./result_10chains/node224_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_8_1 -p 882 -st topic224_8_0 -pt topic224_8_1 -u 0.020285695867022974 > ./result_10chains/node224_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_9_1 -p 909 -st topic224_9_0 -pt topic224_9_1 -u 0.016008653563563065 > ./result_10chains/node224_9_1.txt &
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
    "./result_10chains/node224_0_1.txt 90"
    "./result_10chains/node224_1_1.txt 89"
    "./result_10chains/node224_2_1.txt 88"
    "./result_10chains/node224_3_1.txt 87"
    "./result_10chains/node224_4_1.txt 86"
    "./result_10chains/node224_5_1.txt 85"
    "./result_10chains/node224_6_1.txt 84"
    "./result_10chains/node224_7_1.txt 83"
    "./result_10chains/node224_8_1.txt 82"
    "./result_10chains/node224_9_1.txt 81"
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
