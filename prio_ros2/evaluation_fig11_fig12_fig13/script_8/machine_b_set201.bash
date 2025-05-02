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
ros2 run evaluation_3_randomdag uunifast_node -n node201_0_1 -p 11 -st topic201_0_0 -pt topic201_0_1 -u 0.030108654484373387 > ./result_8chains/node201_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_1_1 -p 30 -st topic201_1_0 -pt topic201_1_1 -u 0.09233440225692746 > ./result_8chains/node201_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_2_1 -p 244 -st topic201_2_0 -pt topic201_2_1 -u 0.009894234685288106 > ./result_8chains/node201_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_3_1 -p 334 -st topic201_3_0 -pt topic201_3_1 -u 0.03962065054850655 > ./result_8chains/node201_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_4_1 -p 509 -st topic201_4_0 -pt topic201_4_1 -u 0.0015615824483337926 > ./result_8chains/node201_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_5_1 -p 663 -st topic201_5_0 -pt topic201_5_1 -u 0.0022537268094862117 > ./result_8chains/node201_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_6_1 -p 733 -st topic201_6_0 -pt topic201_6_1 -u 0.0610329684267967 > ./result_8chains/node201_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_7_1 -p 791 -st topic201_7_0 -pt topic201_7_1 -u 0.010846776445252702 > ./result_8chains/node201_7_1.txt &
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
    "./result_8chains/node201_0_1.txt 90"
    "./result_8chains/node201_1_1.txt 89"
    "./result_8chains/node201_2_1.txt 88"
    "./result_8chains/node201_3_1.txt 87"
    "./result_8chains/node201_4_1.txt 86"
    "./result_8chains/node201_5_1.txt 85"
    "./result_8chains/node201_6_1.txt 84"
    "./result_8chains/node201_7_1.txt 83"
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
