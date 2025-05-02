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
ros2 run evaluation_3_randomdag uunifast_node -n node265_0_1 -p 427 -st topic265_0_0 -pt topic265_0_1 -u 0.03263269736473606 > ./result_4chains/node265_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_1_1 -p 455 -st topic265_1_0 -pt topic265_1_1 -u 0.00395195119664421 > ./result_4chains/node265_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_2_1 -p 512 -st topic265_2_0 -pt topic265_2_1 -u 0.09710893696600556 > ./result_4chains/node265_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_3_1 -p 866 -st topic265_3_0 -pt topic265_3_1 -u 0.11418778888590111 > ./result_4chains/node265_3_1.txt &
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
    "./result_4chains/node265_0_1.txt 90"
    "./result_4chains/node265_1_1.txt 89"
    "./result_4chains/node265_2_1.txt 88"
    "./result_4chains/node265_3_1.txt 87"
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
