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
ros2 run evaluation_3_randomdag uunifast_node -n node455_0_1 -p 110 -st topic455_0_0 -pt topic455_0_1 -u 0.044284151703153085 > ./result_10chains/node455_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_1_1 -p 186 -st topic455_1_0 -pt topic455_1_1 -u 0.007625276899273337 > ./result_10chains/node455_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_2_1 -p 564 -st topic455_2_0 -pt topic455_2_1 -u 0.061572998091997955 > ./result_10chains/node455_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_3_1 -p 688 -st topic455_3_0 -pt topic455_3_1 -u 0.0026891732845837346 > ./result_10chains/node455_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_4_1 -p 696 -st topic455_4_0 -pt topic455_4_1 -u 0.006184894507161087 > ./result_10chains/node455_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_5_1 -p 762 -st topic455_5_0 -pt topic455_5_1 -u 0.041089785389210653 > ./result_10chains/node455_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_6_1 -p 766 -st topic455_6_0 -pt topic455_6_1 -u 0.010970926363894129 > ./result_10chains/node455_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_7_1 -p 830 -st topic455_7_0 -pt topic455_7_1 -u 0.0016706496604756427 > ./result_10chains/node455_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_8_1 -p 867 -st topic455_8_0 -pt topic455_8_1 -u 0.007248333122144235 > ./result_10chains/node455_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_9_1 -p 963 -st topic455_9_0 -pt topic455_9_1 -u 0.016468761837308415 > ./result_10chains/node455_9_1.txt &
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
    "./result_10chains/node455_0_1.txt 90"
    "./result_10chains/node455_1_1.txt 89"
    "./result_10chains/node455_2_1.txt 88"
    "./result_10chains/node455_3_1.txt 87"
    "./result_10chains/node455_4_1.txt 86"
    "./result_10chains/node455_5_1.txt 85"
    "./result_10chains/node455_6_1.txt 84"
    "./result_10chains/node455_7_1.txt 83"
    "./result_10chains/node455_8_1.txt 82"
    "./result_10chains/node455_9_1.txt 81"
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
