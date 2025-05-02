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
ros2 run evaluation_3_randomdag uunifast_node -n node111_0_1 -p 16 -st topic111_0_0 -pt topic111_0_1 -u 0.04164082274535785 > ./result_6chains/node111_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_1_1 -p 245 -st topic111_1_0 -pt topic111_1_1 -u 0.003900755654242305 > ./result_6chains/node111_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_2_1 -p 491 -st topic111_2_0 -pt topic111_2_1 -u 0.0009871631259643077 > ./result_6chains/node111_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_3_1 -p 507 -st topic111_3_0 -pt topic111_3_1 -u 0.00653432197693371 > ./result_6chains/node111_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_4_1 -p 734 -st topic111_4_0 -pt topic111_4_1 -u 0.02210710993535195 > ./result_6chains/node111_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_5_1 -p 943 -st topic111_5_0 -pt topic111_5_1 -u 0.006353644535260928 > ./result_6chains/node111_5_1.txt &
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
    "./result_6chains/node111_0_1.txt 90"
    "./result_6chains/node111_1_1.txt 89"
    "./result_6chains/node111_2_1.txt 88"
    "./result_6chains/node111_3_1.txt 87"
    "./result_6chains/node111_4_1.txt 86"
    "./result_6chains/node111_5_1.txt 85"
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
