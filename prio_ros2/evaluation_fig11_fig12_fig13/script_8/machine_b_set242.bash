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
ros2 run evaluation_3_randomdag uunifast_node -n node242_0_1 -p 29 -st topic242_0_0 -pt topic242_0_1 -u 0.026831976736186702 > ./result_8chains/node242_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_1_1 -p 412 -st topic242_1_0 -pt topic242_1_1 -u 0.006407732444289493 > ./result_8chains/node242_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_2_1 -p 554 -st topic242_2_0 -pt topic242_2_1 -u 0.004330627360550177 > ./result_8chains/node242_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_3_1 -p 654 -st topic242_3_0 -pt topic242_3_1 -u 0.015081857707916646 > ./result_8chains/node242_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_4_1 -p 760 -st topic242_4_0 -pt topic242_4_1 -u 0.012662550096525782 > ./result_8chains/node242_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_5_1 -p 764 -st topic242_5_0 -pt topic242_5_1 -u 0.053063282494791336 > ./result_8chains/node242_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_6_1 -p 789 -st topic242_6_0 -pt topic242_6_1 -u 0.004263153731762809 > ./result_8chains/node242_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_7_1 -p 899 -st topic242_7_0 -pt topic242_7_1 -u 0.02746130466930701 > ./result_8chains/node242_7_1.txt &
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
    "./result_8chains/node242_0_1.txt 90"
    "./result_8chains/node242_1_1.txt 89"
    "./result_8chains/node242_2_1.txt 88"
    "./result_8chains/node242_3_1.txt 87"
    "./result_8chains/node242_4_1.txt 86"
    "./result_8chains/node242_5_1.txt 85"
    "./result_8chains/node242_6_1.txt 84"
    "./result_8chains/node242_7_1.txt 83"
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
