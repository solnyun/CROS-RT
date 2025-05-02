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
ros2 run evaluation_3_randomdag uunifast_node -n node412_0_1 -p 88 -st topic412_0_0 -pt topic412_0_1 -u 0.07903220666242672 > ./result_6chains/node412_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_1_1 -p 98 -st topic412_1_0 -pt topic412_1_1 -u 0.017552317460913902 > ./result_6chains/node412_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_2_1 -p 247 -st topic412_2_0 -pt topic412_2_1 -u 0.047234826680158826 > ./result_6chains/node412_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_3_1 -p 311 -st topic412_3_0 -pt topic412_3_1 -u 1.0992959432173932e-05 > ./result_6chains/node412_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_4_1 -p 538 -st topic412_4_0 -pt topic412_4_1 -u 0.014246272450890704 > ./result_6chains/node412_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_5_1 -p 833 -st topic412_5_0 -pt topic412_5_1 -u 0.03377841093888727 > ./result_6chains/node412_5_1.txt &
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
    "./result_6chains/node412_0_1.txt 90"
    "./result_6chains/node412_1_1.txt 89"
    "./result_6chains/node412_2_1.txt 88"
    "./result_6chains/node412_3_1.txt 87"
    "./result_6chains/node412_4_1.txt 86"
    "./result_6chains/node412_5_1.txt 85"
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
