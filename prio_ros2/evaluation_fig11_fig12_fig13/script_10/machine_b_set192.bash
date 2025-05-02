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
ros2 run evaluation_3_randomdag uunifast_node -n node192_0_1 -p 223 -st topic192_0_0 -pt topic192_0_1 -u 0.015310770764386139 > ./result_10chains/node192_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_1_1 -p 312 -st topic192_1_0 -pt topic192_1_1 -u 0.01858985804710961 > ./result_10chains/node192_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_2_1 -p 449 -st topic192_2_0 -pt topic192_2_1 -u 8.22150485472739e-05 > ./result_10chains/node192_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_3_1 -p 523 -st topic192_3_0 -pt topic192_3_1 -u 0.0045685573365865095 > ./result_10chains/node192_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_4_1 -p 574 -st topic192_4_0 -pt topic192_4_1 -u 0.009259758411286123 > ./result_10chains/node192_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_5_1 -p 757 -st topic192_5_0 -pt topic192_5_1 -u 0.012043781408173027 > ./result_10chains/node192_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_6_1 -p 784 -st topic192_6_0 -pt topic192_6_1 -u 0.02184172140474333 > ./result_10chains/node192_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_7_1 -p 821 -st topic192_7_0 -pt topic192_7_1 -u 0.032210340591835765 > ./result_10chains/node192_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_8_1 -p 845 -st topic192_8_0 -pt topic192_8_1 -u 0.011012080661868484 > ./result_10chains/node192_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_9_1 -p 974 -st topic192_9_0 -pt topic192_9_1 -u 0.0008992980671338885 > ./result_10chains/node192_9_1.txt &
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
    "./result_10chains/node192_0_1.txt 90"
    "./result_10chains/node192_1_1.txt 89"
    "./result_10chains/node192_2_1.txt 88"
    "./result_10chains/node192_3_1.txt 87"
    "./result_10chains/node192_4_1.txt 86"
    "./result_10chains/node192_5_1.txt 85"
    "./result_10chains/node192_6_1.txt 84"
    "./result_10chains/node192_7_1.txt 83"
    "./result_10chains/node192_8_1.txt 82"
    "./result_10chains/node192_9_1.txt 81"
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
