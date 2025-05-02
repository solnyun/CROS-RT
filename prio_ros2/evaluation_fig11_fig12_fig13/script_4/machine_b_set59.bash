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
ros2 run evaluation_3_randomdag uunifast_node -n node59_0_1 -p 623 -st topic59_0_0 -pt topic59_0_1 -u 0.023908365694439604 > ./result_4chains/node59_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_1_1 -p 722 -st topic59_1_0 -pt topic59_1_1 -u 0.021948213631707347 > ./result_4chains/node59_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_2_1 -p 809 -st topic59_2_0 -pt topic59_2_1 -u 0.06485926253228524 > ./result_4chains/node59_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_3_1 -p 852 -st topic59_3_0 -pt topic59_3_1 -u 0.059852154111917605 > ./result_4chains/node59_3_1.txt &
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
    "./result_4chains/node59_0_1.txt 90"
    "./result_4chains/node59_1_1.txt 89"
    "./result_4chains/node59_2_1.txt 88"
    "./result_4chains/node59_3_1.txt 87"
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
