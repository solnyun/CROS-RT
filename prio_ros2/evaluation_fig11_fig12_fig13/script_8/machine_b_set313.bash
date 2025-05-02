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
ros2 run evaluation_3_randomdag uunifast_node -n node313_0_1 -p 92 -st topic313_0_0 -pt topic313_0_1 -u 0.035342152312967834 > ./result_8chains/node313_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_1_1 -p 228 -st topic313_1_0 -pt topic313_1_1 -u 0.012179955849188184 > ./result_8chains/node313_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_2_1 -p 334 -st topic313_2_0 -pt topic313_2_1 -u 0.033362991350485316 > ./result_8chains/node313_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_3_1 -p 626 -st topic313_3_0 -pt topic313_3_1 -u 0.02564474368816333 > ./result_8chains/node313_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_4_1 -p 840 -st topic313_4_0 -pt topic313_4_1 -u 0.04643308779162336 > ./result_8chains/node313_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_5_1 -p 862 -st topic313_5_0 -pt topic313_5_1 -u 0.00018791487688843422 > ./result_8chains/node313_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_6_1 -p 869 -st topic313_6_0 -pt topic313_6_1 -u 0.08337704199218773 > ./result_8chains/node313_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_7_1 -p 933 -st topic313_7_0 -pt topic313_7_1 -u 0.0076683399349928225 > ./result_8chains/node313_7_1.txt &
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
    "./result_8chains/node313_0_1.txt 90"
    "./result_8chains/node313_1_1.txt 89"
    "./result_8chains/node313_2_1.txt 88"
    "./result_8chains/node313_3_1.txt 87"
    "./result_8chains/node313_4_1.txt 86"
    "./result_8chains/node313_5_1.txt 85"
    "./result_8chains/node313_6_1.txt 84"
    "./result_8chains/node313_7_1.txt 83"
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
