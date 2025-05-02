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
ros2 run evaluation_3_randomdag uunifast_node -n node426_0_1 -p 73 -st topic426_0_0 -pt topic426_0_1 -u 0.00942223612867421 > ./result_6chains/node426_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_1_1 -p 217 -st topic426_1_0 -pt topic426_1_1 -u 0.03660133317193759 > ./result_6chains/node426_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_2_1 -p 463 -st topic426_2_0 -pt topic426_2_1 -u 0.04258737439660498 > ./result_6chains/node426_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_3_1 -p 484 -st topic426_3_0 -pt topic426_3_1 -u 0.018964677589470402 > ./result_6chains/node426_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_4_1 -p 794 -st topic426_4_0 -pt topic426_4_1 -u 0.005436921856036586 > ./result_6chains/node426_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_5_1 -p 923 -st topic426_5_0 -pt topic426_5_1 -u 0.01914015892608706 > ./result_6chains/node426_5_1.txt &
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
    "./result_6chains/node426_0_1.txt 90"
    "./result_6chains/node426_1_1.txt 89"
    "./result_6chains/node426_2_1.txt 88"
    "./result_6chains/node426_3_1.txt 87"
    "./result_6chains/node426_4_1.txt 86"
    "./result_6chains/node426_5_1.txt 85"
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
