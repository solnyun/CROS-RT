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
ros2 run evaluation_3_randomdag uunifast_node -n node175_0_1 -p 69 -st topic175_0_0 -pt topic175_0_1 -u 0.030913756523814895 > ./result_8chains/node175_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_1_1 -p 219 -st topic175_1_0 -pt topic175_1_1 -u 0.028680964888071148 > ./result_8chains/node175_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_2_1 -p 259 -st topic175_2_0 -pt topic175_2_1 -u 0.056639580267351886 > ./result_8chains/node175_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_3_1 -p 590 -st topic175_3_0 -pt topic175_3_1 -u 0.008202689487297188 > ./result_8chains/node175_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_4_1 -p 642 -st topic175_4_0 -pt topic175_4_1 -u 0.002127676522819616 > ./result_8chains/node175_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_5_1 -p 759 -st topic175_5_0 -pt topic175_5_1 -u 0.005451857843559504 > ./result_8chains/node175_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_6_1 -p 815 -st topic175_6_0 -pt topic175_6_1 -u 0.003274504858934893 > ./result_8chains/node175_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_7_1 -p 902 -st topic175_7_0 -pt topic175_7_1 -u 0.00845018990071865 > ./result_8chains/node175_7_1.txt &
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
    "./result_8chains/node175_0_1.txt 90"
    "./result_8chains/node175_1_1.txt 89"
    "./result_8chains/node175_2_1.txt 88"
    "./result_8chains/node175_3_1.txt 87"
    "./result_8chains/node175_4_1.txt 86"
    "./result_8chains/node175_5_1.txt 85"
    "./result_8chains/node175_6_1.txt 84"
    "./result_8chains/node175_7_1.txt 83"
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
