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
ros2 run evaluation_3_randomdag uunifast_node -n node323_0_1 -p 186 -st topic323_0_0 -pt topic323_0_1 -u 0.0223350828376081 > ./result_4chains/node323_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_1_1 -p 485 -st topic323_1_0 -pt topic323_1_1 -u 0.04499908346199677 > ./result_4chains/node323_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_2_1 -p 612 -st topic323_2_0 -pt topic323_2_1 -u 0.007544022772308812 > ./result_4chains/node323_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_3_1 -p 736 -st topic323_3_0 -pt topic323_3_1 -u 0.07856120220937352 > ./result_4chains/node323_3_1.txt &
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
    "./result_4chains/node323_0_1.txt 90"
    "./result_4chains/node323_1_1.txt 89"
    "./result_4chains/node323_2_1.txt 88"
    "./result_4chains/node323_3_1.txt 87"
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
