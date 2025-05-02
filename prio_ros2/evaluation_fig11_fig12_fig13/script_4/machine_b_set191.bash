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
ros2 run evaluation_3_randomdag uunifast_node -n node191_0_1 -p 399 -st topic191_0_0 -pt topic191_0_1 -u 0.010640867495574191 > ./result_4chains/node191_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_1_1 -p 462 -st topic191_1_0 -pt topic191_1_1 -u 0.07916860475150161 > ./result_4chains/node191_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_2_1 -p 666 -st topic191_2_0 -pt topic191_2_1 -u 0.024904634244034357 > ./result_4chains/node191_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_3_1 -p 738 -st topic191_3_0 -pt topic191_3_1 -u 0.14041044571103511 > ./result_4chains/node191_3_1.txt &
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
    "./result_4chains/node191_0_1.txt 90"
    "./result_4chains/node191_1_1.txt 89"
    "./result_4chains/node191_2_1.txt 88"
    "./result_4chains/node191_3_1.txt 87"
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
