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
ros2 run evaluation_3_randomdag uunifast_node -n node157_0_1 -p 65 -st topic157_0_0 -pt topic157_0_1 -u 0.04416018269776473 > ./result_6chains/node157_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_1_1 -p 166 -st topic157_1_0 -pt topic157_1_1 -u 0.003098063105725468 > ./result_6chains/node157_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_2_1 -p 236 -st topic157_2_0 -pt topic157_2_1 -u 0.024487637657372385 > ./result_6chains/node157_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_3_1 -p 704 -st topic157_3_0 -pt topic157_3_1 -u 0.01635563883692734 > ./result_6chains/node157_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_4_1 -p 756 -st topic157_4_0 -pt topic157_4_1 -u 0.018213078868223403 > ./result_6chains/node157_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_5_1 -p 968 -st topic157_5_0 -pt topic157_5_1 -u 0.015538365687090716 > ./result_6chains/node157_5_1.txt &
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
    "./result_6chains/node157_0_1.txt 90"
    "./result_6chains/node157_1_1.txt 89"
    "./result_6chains/node157_2_1.txt 88"
    "./result_6chains/node157_3_1.txt 87"
    "./result_6chains/node157_4_1.txt 86"
    "./result_6chains/node157_5_1.txt 85"
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
