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
ros2 run evaluation_3_randomdag uunifast_node -n node477_0_1 -p 14 -st topic477_0_0 -pt topic477_0_1 -u 0.044407008790882 > ./result_6chains/node477_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_1_1 -p 25 -st topic477_1_0 -pt topic477_1_1 -u 0.027211100477618932 > ./result_6chains/node477_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_2_1 -p 93 -st topic477_2_0 -pt topic477_2_1 -u 0.01705771560231084 > ./result_6chains/node477_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_3_1 -p 335 -st topic477_3_0 -pt topic477_3_1 -u 0.02368996349691635 > ./result_6chains/node477_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_4_1 -p 541 -st topic477_4_0 -pt topic477_4_1 -u 0.09232509380119872 > ./result_6chains/node477_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_5_1 -p 638 -st topic477_5_0 -pt topic477_5_1 -u 0.0033591419826704307 > ./result_6chains/node477_5_1.txt &
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
    "./result_6chains/node477_0_1.txt 90"
    "./result_6chains/node477_1_1.txt 89"
    "./result_6chains/node477_2_1.txt 88"
    "./result_6chains/node477_3_1.txt 87"
    "./result_6chains/node477_4_1.txt 86"
    "./result_6chains/node477_5_1.txt 85"
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
