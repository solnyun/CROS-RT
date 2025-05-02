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
ros2 run evaluation_3_randomdag uunifast_node -n node41_0_1 -p 168 -st topic41_0_0 -pt topic41_0_1 -u 0.00033849790918949463 > ./result_8chains/node41_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node41_1_1 -p 214 -st topic41_1_0 -pt topic41_1_1 -u 0.009423306473058168 > ./result_8chains/node41_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node41_2_1 -p 272 -st topic41_2_0 -pt topic41_2_1 -u 0.01816638680536753 > ./result_8chains/node41_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node41_3_1 -p 326 -st topic41_3_0 -pt topic41_3_1 -u 0.061041794257788606 > ./result_8chains/node41_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node41_4_1 -p 365 -st topic41_4_0 -pt topic41_4_1 -u 0.013959773022694744 > ./result_8chains/node41_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node41_5_1 -p 533 -st topic41_5_0 -pt topic41_5_1 -u 0.001560898675088268 > ./result_8chains/node41_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node41_6_1 -p 554 -st topic41_6_0 -pt topic41_6_1 -u 0.012898141355630582 > ./result_8chains/node41_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node41_7_1 -p 832 -st topic41_7_0 -pt topic41_7_1 -u 0.03928590490199248 > ./result_8chains/node41_7_1.txt &
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
    "./result_8chains/node41_0_1.txt 90"
    "./result_8chains/node41_1_1.txt 89"
    "./result_8chains/node41_2_1.txt 88"
    "./result_8chains/node41_3_1.txt 87"
    "./result_8chains/node41_4_1.txt 86"
    "./result_8chains/node41_5_1.txt 85"
    "./result_8chains/node41_6_1.txt 84"
    "./result_8chains/node41_7_1.txt 83"
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
