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
ros2 run evaluation_3_randomdag uunifast_node -n node261_0_1 -p 187 -st topic261_0_0 -pt topic261_0_1 -u 0.01974143768665748 > ./result_6chains/node261_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_1_1 -p 343 -st topic261_1_0 -pt topic261_1_1 -u 0.00665504805572853 > ./result_6chains/node261_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_2_1 -p 510 -st topic261_2_0 -pt topic261_2_1 -u 0.046406643601559106 > ./result_6chains/node261_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_3_1 -p 572 -st topic261_3_0 -pt topic261_3_1 -u 0.011405620156915125 > ./result_6chains/node261_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_4_1 -p 741 -st topic261_4_0 -pt topic261_4_1 -u 0.0665515206166206 > ./result_6chains/node261_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_5_1 -p 881 -st topic261_5_0 -pt topic261_5_1 -u 0.012560263680711135 > ./result_6chains/node261_5_1.txt &
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
    "./result_6chains/node261_0_1.txt 90"
    "./result_6chains/node261_1_1.txt 89"
    "./result_6chains/node261_2_1.txt 88"
    "./result_6chains/node261_3_1.txt 87"
    "./result_6chains/node261_4_1.txt 86"
    "./result_6chains/node261_5_1.txt 85"
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
