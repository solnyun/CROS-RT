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
ros2 run evaluation_3_randomdag uunifast_node -n node441_0_1 -p 164 -st topic441_0_0 -pt topic441_0_1 -u 0.024739655026834895 > ./result_10chains/node441_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_1_1 -p 201 -st topic441_1_0 -pt topic441_1_1 -u 0.0077025002724297464 > ./result_10chains/node441_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_2_1 -p 247 -st topic441_2_0 -pt topic441_2_1 -u 0.017616302764251746 > ./result_10chains/node441_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_3_1 -p 295 -st topic441_3_0 -pt topic441_3_1 -u 0.003990776239155891 > ./result_10chains/node441_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_4_1 -p 478 -st topic441_4_0 -pt topic441_4_1 -u 0.004661523723614225 > ./result_10chains/node441_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_5_1 -p 740 -st topic441_5_0 -pt topic441_5_1 -u 0.017823170131434363 > ./result_10chains/node441_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_6_1 -p 758 -st topic441_6_0 -pt topic441_6_1 -u 0.0016621293531338677 > ./result_10chains/node441_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_7_1 -p 850 -st topic441_7_0 -pt topic441_7_1 -u 0.009666026516143872 > ./result_10chains/node441_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_8_1 -p 854 -st topic441_8_0 -pt topic441_8_1 -u 0.0003952352268085241 > ./result_10chains/node441_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_9_1 -p 864 -st topic441_9_0 -pt topic441_9_1 -u 0.005339372676270441 > ./result_10chains/node441_9_1.txt &
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
    "./result_10chains/node441_0_1.txt 90"
    "./result_10chains/node441_1_1.txt 89"
    "./result_10chains/node441_2_1.txt 88"
    "./result_10chains/node441_3_1.txt 87"
    "./result_10chains/node441_4_1.txt 86"
    "./result_10chains/node441_5_1.txt 85"
    "./result_10chains/node441_6_1.txt 84"
    "./result_10chains/node441_7_1.txt 83"
    "./result_10chains/node441_8_1.txt 82"
    "./result_10chains/node441_9_1.txt 81"
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
