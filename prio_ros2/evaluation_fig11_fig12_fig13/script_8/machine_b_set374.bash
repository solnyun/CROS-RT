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
ros2 run evaluation_3_randomdag uunifast_node -n node374_0_1 -p 20 -st topic374_0_0 -pt topic374_0_1 -u 0.017709845913462252 > ./result_8chains/node374_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_1_1 -p 37 -st topic374_1_0 -pt topic374_1_1 -u 0.0007730270111910298 > ./result_8chains/node374_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_2_1 -p 54 -st topic374_2_0 -pt topic374_2_1 -u 0.006735771784127931 > ./result_8chains/node374_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_3_1 -p 61 -st topic374_3_0 -pt topic374_3_1 -u 0.015479126046730046 > ./result_8chains/node374_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_4_1 -p 90 -st topic374_4_0 -pt topic374_4_1 -u 0.021903810365238696 > ./result_8chains/node374_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_5_1 -p 494 -st topic374_5_0 -pt topic374_5_1 -u 0.0001359029231878528 > ./result_8chains/node374_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_6_1 -p 574 -st topic374_6_0 -pt topic374_6_1 -u 0.024616918789077583 > ./result_8chains/node374_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_7_1 -p 876 -st topic374_7_0 -pt topic374_7_1 -u 0.015143402430424786 > ./result_8chains/node374_7_1.txt &
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
    "./result_8chains/node374_0_1.txt 90"
    "./result_8chains/node374_1_1.txt 89"
    "./result_8chains/node374_2_1.txt 88"
    "./result_8chains/node374_3_1.txt 87"
    "./result_8chains/node374_4_1.txt 86"
    "./result_8chains/node374_5_1.txt 85"
    "./result_8chains/node374_6_1.txt 84"
    "./result_8chains/node374_7_1.txt 83"
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
