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
ros2 run evaluation_3_randomdag uunifast_node -n node214_0_1 -p 71 -st topic214_0_0 -pt topic214_0_1 -u 0.02815612292698344 > ./result_8chains/node214_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_1_1 -p 325 -st topic214_1_0 -pt topic214_1_1 -u 0.022729368899390312 > ./result_8chains/node214_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_2_1 -p 360 -st topic214_2_0 -pt topic214_2_1 -u 0.026214915803996375 > ./result_8chains/node214_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_3_1 -p 530 -st topic214_3_0 -pt topic214_3_1 -u 0.008796030255940168 > ./result_8chains/node214_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_4_1 -p 641 -st topic214_4_0 -pt topic214_4_1 -u 0.00909856413521909 > ./result_8chains/node214_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_5_1 -p 682 -st topic214_5_0 -pt topic214_5_1 -u 0.004104082839627959 > ./result_8chains/node214_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_6_1 -p 686 -st topic214_6_0 -pt topic214_6_1 -u 0.018648444574041495 > ./result_8chains/node214_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_7_1 -p 993 -st topic214_7_0 -pt topic214_7_1 -u 0.007931806427321206 > ./result_8chains/node214_7_1.txt &
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
    "./result_8chains/node214_0_1.txt 90"
    "./result_8chains/node214_1_1.txt 89"
    "./result_8chains/node214_2_1.txt 88"
    "./result_8chains/node214_3_1.txt 87"
    "./result_8chains/node214_4_1.txt 86"
    "./result_8chains/node214_5_1.txt 85"
    "./result_8chains/node214_6_1.txt 84"
    "./result_8chains/node214_7_1.txt 83"
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
