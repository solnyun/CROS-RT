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
ros2 run evaluation_3_randomdag uunifast_node -n node199_0_1 -p 58 -st topic199_0_0 -pt topic199_0_1 -u 0.004988412815700061 > ./result_8chains/node199_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_1_1 -p 128 -st topic199_1_0 -pt topic199_1_1 -u 0.024042210004561748 > ./result_8chains/node199_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_2_1 -p 251 -st topic199_2_0 -pt topic199_2_1 -u 0.004945316016425838 > ./result_8chains/node199_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_3_1 -p 478 -st topic199_3_0 -pt topic199_3_1 -u 0.03238507543395616 > ./result_8chains/node199_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_4_1 -p 772 -st topic199_4_0 -pt topic199_4_1 -u 0.008706027820876178 > ./result_8chains/node199_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_5_1 -p 853 -st topic199_5_0 -pt topic199_5_1 -u 0.01639632429949381 > ./result_8chains/node199_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_6_1 -p 919 -st topic199_6_0 -pt topic199_6_1 -u 0.010035883808237112 > ./result_8chains/node199_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_7_1 -p 967 -st topic199_7_0 -pt topic199_7_1 -u 0.0876549469282533 > ./result_8chains/node199_7_1.txt &
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
    "./result_8chains/node199_0_1.txt 90"
    "./result_8chains/node199_1_1.txt 89"
    "./result_8chains/node199_2_1.txt 88"
    "./result_8chains/node199_3_1.txt 87"
    "./result_8chains/node199_4_1.txt 86"
    "./result_8chains/node199_5_1.txt 85"
    "./result_8chains/node199_6_1.txt 84"
    "./result_8chains/node199_7_1.txt 83"
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
