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
ros2 run evaluation_3_randomdag uunifast_node -n node321_0_1 -p 149 -st topic321_0_0 -pt topic321_0_1 -u 0.017881937406444615 > ./result_6chains/node321_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_1_1 -p 303 -st topic321_1_0 -pt topic321_1_1 -u 0.06267177794330414 > ./result_6chains/node321_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_2_1 -p 395 -st topic321_2_0 -pt topic321_2_1 -u 0.022008509679657673 > ./result_6chains/node321_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_3_1 -p 742 -st topic321_3_0 -pt topic321_3_1 -u 0.029396534074252245 > ./result_6chains/node321_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_4_1 -p 749 -st topic321_4_0 -pt topic321_4_1 -u 0.0032534272606909165 > ./result_6chains/node321_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_5_1 -p 846 -st topic321_5_0 -pt topic321_5_1 -u 0.06555455720387832 > ./result_6chains/node321_5_1.txt &
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
    "./result_6chains/node321_0_1.txt 90"
    "./result_6chains/node321_1_1.txt 89"
    "./result_6chains/node321_2_1.txt 88"
    "./result_6chains/node321_3_1.txt 87"
    "./result_6chains/node321_4_1.txt 86"
    "./result_6chains/node321_5_1.txt 85"
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
