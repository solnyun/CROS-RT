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
ros2 run evaluation_3_randomdag uunifast_node -n node410_0_1 -p 392 -st topic410_0_0 -pt topic410_0_1 -u 0.028727441152921196 > ./result_4chains/node410_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_1_1 -p 462 -st topic410_1_0 -pt topic410_1_1 -u 0.11265802023685256 > ./result_4chains/node410_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_2_1 -p 494 -st topic410_2_0 -pt topic410_2_1 -u 0.027240001861516594 > ./result_4chains/node410_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_3_1 -p 617 -st topic410_3_0 -pt topic410_3_1 -u 0.0036573573125667468 > ./result_4chains/node410_3_1.txt &
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
    "./result_4chains/node410_0_1.txt 90"
    "./result_4chains/node410_1_1.txt 89"
    "./result_4chains/node410_2_1.txt 88"
    "./result_4chains/node410_3_1.txt 87"
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
