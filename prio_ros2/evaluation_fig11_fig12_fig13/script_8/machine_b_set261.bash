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
ros2 run evaluation_3_randomdag uunifast_node -n node261_0_1 -p 32 -st topic261_0_0 -pt topic261_0_1 -u 0.040844373306498316 > ./result_8chains/node261_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_1_1 -p 218 -st topic261_1_0 -pt topic261_1_1 -u 0.01899986365470585 > ./result_8chains/node261_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_2_1 -p 323 -st topic261_2_0 -pt topic261_2_1 -u 0.0214659696873003 > ./result_8chains/node261_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_3_1 -p 426 -st topic261_3_0 -pt topic261_3_1 -u 0.04608270488628127 > ./result_8chains/node261_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_4_1 -p 599 -st topic261_4_0 -pt topic261_4_1 -u 0.013480002144747136 > ./result_8chains/node261_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_5_1 -p 630 -st topic261_5_0 -pt topic261_5_1 -u 0.0058634916672847814 > ./result_8chains/node261_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_6_1 -p 695 -st topic261_6_0 -pt topic261_6_1 -u 0.002732975873141759 > ./result_8chains/node261_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_7_1 -p 858 -st topic261_7_0 -pt topic261_7_1 -u 0.002849080566782668 > ./result_8chains/node261_7_1.txt &
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
    "./result_8chains/node261_0_1.txt 90"
    "./result_8chains/node261_1_1.txt 89"
    "./result_8chains/node261_2_1.txt 88"
    "./result_8chains/node261_3_1.txt 87"
    "./result_8chains/node261_4_1.txt 86"
    "./result_8chains/node261_5_1.txt 85"
    "./result_8chains/node261_6_1.txt 84"
    "./result_8chains/node261_7_1.txt 83"
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
