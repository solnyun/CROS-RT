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
ros2 run evaluation_3_randomdag uunifast_node -n node197_0_1 -p 70 -st topic197_0_0 -pt topic197_0_1 -u 0.062018627979023466 > ./result_8chains/node197_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_1_1 -p 242 -st topic197_1_0 -pt topic197_1_1 -u 0.007956410671012992 > ./result_8chains/node197_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_2_1 -p 289 -st topic197_2_0 -pt topic197_2_1 -u 0.012036377622570926 > ./result_8chains/node197_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_3_1 -p 316 -st topic197_3_0 -pt topic197_3_1 -u 0.045560992565903874 > ./result_8chains/node197_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_4_1 -p 396 -st topic197_4_0 -pt topic197_4_1 -u 0.02494367400382186 > ./result_8chains/node197_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_5_1 -p 515 -st topic197_5_0 -pt topic197_5_1 -u 0.004942590418919757 > ./result_8chains/node197_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_6_1 -p 913 -st topic197_6_0 -pt topic197_6_1 -u 0.021011300587409285 > ./result_8chains/node197_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_7_1 -p 971 -st topic197_7_0 -pt topic197_7_1 -u 0.008230062438935246 > ./result_8chains/node197_7_1.txt &
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
    "./result_8chains/node197_0_1.txt 90"
    "./result_8chains/node197_1_1.txt 89"
    "./result_8chains/node197_2_1.txt 88"
    "./result_8chains/node197_3_1.txt 87"
    "./result_8chains/node197_4_1.txt 86"
    "./result_8chains/node197_5_1.txt 85"
    "./result_8chains/node197_6_1.txt 84"
    "./result_8chains/node197_7_1.txt 83"
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
